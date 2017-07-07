// Canvasを特定要素の大きさに変更
function sizing() {
	$("#canv").attr({
		height: $("#wrapper").height()
	});
	$("#canv").attr({
		width: $("#wrapper").width()
	});
}

// ウィンドウのリサイズ時に、Canvasサイズも変更
$(window).resize(function() {
	sizing();
});

// 最小値～最大値の間でランダムな数値を返す
// 最小値を省くと1～最大値の間でランダムな数値を返す
function randomNum(maxInt, minInt) {
	var ran = Math.random();
	if (minInt) {
		if (Math.floor(ran * maxInt) < minInt) {
			return minInt;
		} else {
			return Math.floor(ran * maxInt);
		}
	} else {
		return Math.floor(ran * maxInt) + 1;
	}
}

// ここから読み込んだら実行
$(function() {
	sizing();

	// 初期設定
	var canvas = document.getElementById('canv');
	ctx = canvas.getContext('2d');
	
	var count = 0; //カウンター
	var rate = 100; // フレームレート
	var objNum = 40; //最初に降るオブジェクトの数
	var objPool = []; //オブジェクトを貯めておく配列
	var bg = '#000'; //背景色

	var wi = $("#canv").width();
	var he = $("#canv").height();

	// 新しい円を設定する
	var Circle = function() {
		// サイズ、移動速度、横座標の位置、色はランダム
		this.radius = randomNum(200, 100);
		this.speed = randomNum(15, 1);
		this.color = 'rgba(' + randomNum(255) + ',' + randomNum(255) + ',' + randomNum(255) + ',';
		this.basePos = {x: randomNum(wi)-20, y: randomNum(he)-300}
	}

	// 設定した円の生成だけしておく（描画はまだ
	for (var i = 0; i < objNum; i++) {
		objPool[i] = new Circle();
	}

	// この無名関数の中身を繰り返す
	(function() {
		// 管理
		var objLen = objPool.length;
		
		// canvasに描かれている内容をリセットする
		ctx.globalCompositeOperation = "source-over";
		ctx.fillStyle = bg;
		ctx.fillRect(0, 0, canvas.width, canvas.height);

		// 円を描画する部分ここから
		for (var i = 0; i < objLen; i++) {
			var thisobj = objPool[i];
			$("#obj_cnt").text(objPool.length);	//生成した円の数＝画面内の円の数を表示

			// 上下左右どこでもCanvas外に出たら削除する
			if (thisobj.basePos.y > canvas.height || thisobj.basePos.x > canvas.width) {
				objPool.splice(i--, 1);
				objLen--;
				count++;
				$("#cnt").text(count);	//消えていった円の数を表示
				continue;
			}

			// 円の描画
			ctx.beginPath();
			var edgecolor1 = thisobj.color+'1)';
			var edgecolor2 = thisobj.color+'0.33)';
			var edgecolor3 = thisobj.color+'0.11)';
			var edgecolor4 = thisobj.color+'0)';
			var gradblur = ctx.createRadialGradient(thisobj.basePos.x, thisobj.basePos.y, 0, thisobj.basePos.x, thisobj.basePos.y, thisobj.radius);
			gradblur.addColorStop(0,edgecolor1);
			gradblur.addColorStop(0.4,edgecolor1);
			gradblur.addColorStop(0.7,edgecolor2);
			gradblur.addColorStop(0.9,edgecolor3);
			gradblur.addColorStop(1,edgecolor4);
			ctx.fillStyle = gradblur;
			ctx.arc(thisobj.basePos.x, thisobj.basePos.y, thisobj.radius, 0, Math.PI*2, false);
			ctx.globalCompositeOperation = "lighter";
			ctx.fill();
		// 円を描画する部分ここまで

		// 円を移動する
			thisobj.basePos.y = thisobj.basePos.y + thisobj.speed;
			(thisobj.speed > 12)?
				thisobj.basePos.x = thisobj.basePos.x+3
				:thisobj.basePos.x = thisobj.basePos.x-2;
		}

		// 数が全体の半分以下になったら新しい円を生成する
		// 画面内のObjの数は、右辺の数に落ち着く模様
		if (objPool.length < objNum) {
			objPool.push(new Circle());
		}

		// 無名関数を繰り返して実行するタイマー
		// 1000 / rateミリ秒ごとに実行する
		setTimeout(arguments.callee, 1000 / rate);
	})();
});