import("stdfaust.lib");
squelch =hslider("感度",0.5,0,1,0.01); //入感と判定する音
noizeGain = hslider("ノイズ",0.5,0,1,0.01); //ノイズの強さ
noise(g) = no.noise : fi.resonlp(600,30, g);	//ハムノイズっぽいものを生成
receiveFilter(x) = (x > squelch) * x;	//入感の判定
genReceiveSound = receiveFilter;	//入感した音声の生成（いろいろ試した結果、receiveFilterをそのまま出力でよさそう）
genNonReceivedSound(x) = (x<= squelch) * noise((1-squelch)*noizeGain);	//ハムノイズの適用
process(x) = genReceiveSound(x) + genNonReceivedSound(x);
