Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id HAA538321 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Nov 1997 07:18:58 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA14844 for linux-list; Fri, 28 Nov 1997 07:14:44 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA14829 for <linux@engr.sgi.com>; Fri, 28 Nov 1997 07:14:34 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA04045
	for <linux@engr.sgi.com>; Fri, 28 Nov 1997 07:14:31 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id QAA15667;
	Fri, 28 Nov 1997 16:14:19 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id QAA13082; Fri, 28 Nov 1997 16:14:17 +0100
Message-ID: <19971128161417.23781@thoma.uni-koblenz.de>
Date: Fri, 28 Nov 1997 16:14:17 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Announce: X11 patches and binaries
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----

Hi,

I promised somebody I'd use the time during the student strikes in Germany
to work on the NCR driver.  Well, I lied - here is X windows instead :-)

The binaries are mostly packaged into rpm packages with the exception of
the XFree distribution itself which for now I'm providing as a tarball.
A patch to be applied to the XFree source distribution itself is included.
Right now the only X server included is Xnest; only little endian binaries
are included.

Given the short time invested into X and clients most things are untested.
Those things I actually have tested were working very reliable with the
exception of one program based libg++.

  Ralf

e6adead0b3055d837175aaf7d492414f  src/X/XFree86-3.3.1-1.diff.gz
2faa5f943fedc6c779e3eafeaf136ae9  mipsel-linux/tar-balls/XFree86-3.3.1-1.tar.gz
0b93144864e5d39e5b460e33e2a3e8eb  RPMS/noarch/mkxauth-1.7-6.noarch.rpm
78222c2f6acac85dd9e2ae84987d3ad9  RPMS/noarch/pythonlib-1.20-1.noarch.rpm
597c99452dd8640ef0eebdf418de08e9  RPMS/noarch/usercfg-3.4-3.noarch.rpm
b39cee2c84da1ceec9a51f516b64cbb5  RPMS/mipsel-linux/tcl-8.0-9.mips.rpm
489e52c017d6c2e49387e3d6a731419f  RPMS/mipsel-linux/xearth-1.0-6.mips.rpm
6813c27f619292818abd2cf77517c07c  RPMS/mipsel-linux/xfishtank-2.0-7.mips.rpm
422bc302d2f1a262e001c73a33a71502  RPMS/mipsel-linux/xpilot-3.6.1-2.mips.rpm
6b3539546a6d3a23118ba9f08ff87260  RPMS/mipsel-linux/tk-8.0-9.mips.rpm
bc27b017e27bf5187f5a2c79b93ef1d2  RPMS/mipsel-linux/mc-4.1.3-3.mips.rpm
5b7bfd7f94a577aa258c08a573aeb15f  RPMS/mipsel-linux/expect-5.24-9.mips.rpm
f62d8b556056d37a699945b5d9ea8be4  RPMS/mipsel-linux/tclx-8.0.0.0-9.mips.rpm
0f9998fd721f1feb6e2905d42383b56c  RPMS/mipsel-linux/tix-4.1.0.5-9.mips.rpm
b7b104f488165fc5ce926ce95f5a6adb  RPMS/mipsel-linux/tkmc-4.1.3-3.mips.rpm
f1bc632fb79c3bd1edd9a472dc94830f  RPMS/mipsel-linux/mcserv-4.1.3-3.mips.rpm
96b793eb50d0cb6d418deb39bdd047e3  RPMS/mipsel-linux/newt-0.12-1.mips.rpm
a81ebee239a25ac4c15c8674d9a97a4d  RPMS/mipsel-linux/newt-devel-0.12-1.mips.rpm
159b9e86bd0959b4aaf3e743094f8608  RPMS/mipsel-linux/chkconfig-0.6-1.mips.rpm
edeec21984a76e38e565e278ca98f678  RPMS/mipsel-linux/x3270-3.1.0.7-5.mips.rpm
47d82fc6502ad2afc57d98123ecb7840  RPMS/mipsel-linux/xanim-27064-2.mips.rpm
29e4e571dbc426b05aed2d4af38d503b  RPMS/mipsel-linux/xbl-1.0f-6.mips.rpm
3fe839481a663c2c851231f1dcba48c4  RPMS/mipsel-linux/xboard-3.2.pl0-7.mips.rpm
eddf70de60958c35cf6e81b2cb720168  RPMS/mipsel-linux/xdaliclock-2.07-3.mips.rpm
6f6dfe0b636138d41365b51439950b21  RPMS/mipsel-linux/xdemineur-1.1-6.mips.rpm
8c6851dc87cfe7ac4afc744c5f8b681c  RPMS/mipsel-linux/xgammon-0.98-8.mips.rpm
542e6fa3a40585a52e63344c3e30e094  RPMS/mipsel-linux/ytalk-3.0.3-2.mips.rpm
b2f44c6391f20baa96518449dadd16d4  RPMS/mipsel-linux/xgopher-1.3.3-3.mips.rpm
7107fc5905f3240e844d19247d5b56d0  RPMS/mipsel-linux/xjewel-1.6-6.mips.rpm
864d7ddf138206538d56b522274e2a7e  RPMS/mipsel-linux/xlander-1.2-6.mips.rpm
dc99b59165cd0ff04a3f7f5dcdf9b4c4  RPMS/mipsel-linux/kterm-6.1.0-8.mips.rpm
3d04911f8e6fdc1f4d2b05211d869254  RPMS/mipsel-linux/xloadimage-4.1-7.mips.rpm
552b60a3d6ab5a451c4c457fbb62a866  RPMS/mipsel-linux/moonclock-1.0-8.mips.rpm
b99b5c6a5ff895c658a792d97f112d6a  RPMS/mipsel-linux/xlockmore-4.04-1.mips.rpm
f83e2d398447c3517d3033377e14750d  RPMS/mipsel-linux/jed-0.97.14-5.mips.rpm
7e249fdbe91d2c4fee9e2f788cb6c0dd  RPMS/mipsel-linux/jed-xjed-0.97.14-5.mips.rpm
f505111bb4744158aa7fa7e87b71fa59  RPMS/mipsel-linux/rgrep-0.97.14-5.mips.rpm
a2d7b2f585f274c9a4ab8c640cc75d38  RPMS/mipsel-linux/xpm-3.4j-1.mips.rpm
694d4391e87f81a9c4526d837bd656df  RPMS/mipsel-linux/gnuplot-3.5-7.mips.rpm
810ab9acfc82b647bc83bb0e07b7ef94  RPMS/mipsel-linux/rxvt-2.20-3.mips.rpm
b1f52476fe8659911a96e5af5d93fb5f  RPMS/mipsel-linux/xpuzzles-5.3.1-3.mips.rpm
523b18230f873942bcffbf9e1235ba60  RPMS/mipsel-linux/xrn-8.02-4.mips.rpm
a334123c355620063fb4e5a70a80a69c  RPMS/mipsel-linux/xsnow-1.40-3.mips.rpm
6ef307bff3b3c91a3436fc02939bb899  RPMS/mipsel-linux/xscreensaver-1.26-6.mips.rpm
17f12a88b82b6cbb001ba8f89749d2fa  RPMS/mipsel-linux/xsysinfo-1.5-3.mips.rpm
64fe466c8c8431d1d21c121554c543a4  RPMS/mipsel-linux/xtoolwait-0.3-4.mips.rpm
88929be04bc7458b0b6afab31f54bb8d  RPMS/mipsel-linux/xwpick-2.20-6.mips.rpm
86c1b1388c5c54298002399d6aa803f8  RPMS/mipsel-linux/xxgdb-1.12-2.mips.rpm
a2178d8757d962f566cb1cb8e4ac1aed  RPMS/mipsel-linux/ghostscript-3.33-6.mips.rpm
50b58917b727daf1577bb5f6cc8aaf19  RPMS/mipsel-linux/xzip-140-5.mips.rpm
f9c7c0612f2dfa8162d5df8bdbacf489  RPMS/mipsel-linux/ghostview-1.5-7.mips.rpm
15801ff490d0dbdbf2d408ab0d4b638f  RPMS/mipsel-linux/metamail-2.7-8.mips.rpm
d3835ee0d61a998d264ddd67b74567c0  RPMS/mipsel-linux/Xaw3d-1.3-10.mips.rpm
fc52e3d47dc899098845ea015ff4c572  RPMS/mipsel-linux/maplay-1.2-5.mips.rpm
00db0d3a985a91e460f69f5d890003a8  RPMS/mipsel-linux/fvwm-1.24r-12.mips.rpm
3a47392f962cc46746bc87f594fd544f  RPMS/mipsel-linux/X11R6-contrib-3.3-1.mips.rpm
e0b20d06c86fa285c3c6b33f9875ffa3  RPMS/mipsel-linux/gimp-0.99.12-1.mips.rpm
094aac7bc8ab3788bd4af0584285489c  RPMS/mipsel-linux/Xconfigurator-3.18-1.mips.rpm
3aeb40f510cceed9d71d078e39b1c075  RPMS/mipsel-linux/guavac-0.2.6pl1-1.mips.rpm
cf530cd9f0fd6a7411eaa7fbaa76afca  RPMS/mipsel-linux/fvwm95-2.0.42a-7.mips.rpm
5550530ec24b5e5aece2a3bd43f6af3d  RPMS/mipsel-linux/fvwm95-icons-2.0.42a-7.mips.rpm
261fcba3c87d97e44894549021953a09  RPMS/mipsel-linux/gtk-0.99.970925-2.mips.rpm
8ed6b12b8eb5808d2ec3a8935492dc8f  RPMS/mipsel-linux/gtk-devel-0.99.970925-2.mips.rpm
8fd95e730b6f0019c845ca30ad5fca4e  RPMS/mipsel-linux/gimp-devel-0.99.12-1.mips.rpm
564dcb1257c985eada3fdb477a29f894  RPMS/mipsel-linux/gimp-libgimp-0.99.12-1.mips.rpm
9636cc812da5479c34c6460622637234  RPMS/mipsel-linux/tetex-0.4pl8-8.mips.rpm
e3726828656c07036ac295c08656497b  RPMS/mipsel-linux/tetex-latex-0.4pl8-8.mips.rpm
d3995750edff2ccbccb72f7e18f487ef  RPMS/mipsel-linux/tetex-xdvi-0.4pl8-8.mips.rpm
75eb70292e89ecd9d9c65462c096aae1  RPMS/mipsel-linux/tetex-dvips-0.4pl8-8.mips.rpm
dcc673cb2763f11693aef6e162b82d2d  RPMS/mipsel-linux/tetex-dvilj-0.4pl8-8.mips.rpm
662d46143729860adcd98cd12209829a  RPMS/mipsel-linux/tetex-afm-0.4pl8-8.mips.rpm
0fdb2466761145b09b0f66188914dd8a  RPMS/mipsel-linux/tetex-texmf-src-0.4pl8-8.mips.rpm
3439f596224a855f80815eeaa24dbbd6  RPMS/mipsel-linux/xbill-1.1-5.mips.rpm
25c2a1ae7e805290b1bbc6299aa62d1d  RPMS/mipsel-linux/xbanner-1.3-3.mips.rpm
5c97aa9fd3ac3ac50eeae58cfbb91170  RPMS/mipsel-linux/xboing-2.3-5.mips.rpm
69a4f042810694ae283ce5fdd75f0711  RPMS/mipsel-linux/xevil-1.5-5.mips.rpm
12462f4a80e99b6f2b85298c866e9c58  RPMS/mipsel-linux/xfig-3.1.4-9.mips.rpm
77aad6054d71b55e78f1e41827901ff8  RPMS/mipsel-linux/xtrojka-1.2.2-3.mips.rpm
8031afd28600b871d03e0966ee149d0c  RPMS/mipsel-linux/xmailbox-2.4-5.mips.rpm
424f17790dddc4a7dea5dbb8cf1a3f2a  RPMS/mipsel-linux/xmorph-1996.07.12-3.mips.rpm
4b4f33ebda40b7937c9cc1252165fb61  RPMS/mipsel-linux/xpaint-2.4.7-3.mips.rpm
6127ba706dd16a76b033b29de2f77c23  RPMS/mipsel-linux/xfm-1.3.2-6.mips.rpm
d8a24e828ea8363988f3913228a644be  RPMS/mipsel-linux/xgalaga-1.6c-4.mips.rpm
346a8f33c9fa7479b98d5fc8e02f29d3  RPMS/mipsel-linux/xpat2-1.04-4.mips.rpm
9a496db8e2998b3065fd4484975675a8  RPMS/mipsel-linux/xterm-color-1.1-5.mips.rpm
888c2fff1ba81f167568309da039d4d3  RPMS/mipsel-linux/xwpe-1.4.2-11.mips.rpm
621b72c143bac0e5b4daff5a920c4aee  RPMS/mipsel-linux/xwpe-X11-1.4.2-11.mips.rpm
0002465308f5662ca87e1c717b7a9da7  RPMS/mipsel-linux/seyon-2.14c-8.mips.rpm
ad7d93796d8f34e3faad8b5d78bc3818  RPMS/mipsel-linux/spider-1.0-4.mips.rpm
f7e685d0d9dffb60f336a835d26f898e  RPMS/mipsel-linux/tcsh-6.06-12.mips.rpm
4fc603c18f843b4622cab21bebd39acf  RPMS/mipsel-linux/transfig-3.1.2-e.mips.rpm
829fb979dcad8a226744b10c59d01956  RPMS/mipsel-linux/python-1.4-7.mips.rpm
2518d7b849cbeb5d4f8c2ee3d30922fc  RPMS/mipsel-linux/python-devel-1.4-7.mips.rpm
9bc1d57b967a50dcc8761c3fd7817d16  RPMS/mipsel-linux/python-docs-1.4-7.mips.rpm
d10c8dea141aaeb652215d72651d90d3  RPMS/mipsel-linux/rhs-printfilters-1.41-2.mips.rpm
96d8ba4ed46312d54260c5d16166c9b3  RPMS/mipsel-linux/xv-3.10a-7.mips.rpm
806e5a6317ba1b50ae07ca30ee8a3d03  SRPMS/X11R6-contrib-3.3-1.src.rpm
d0906c45e84f5414f32d31d7d44b40ff  SRPMS/Xconfigurator-3.18-1.src.rpm
b30c841d3d7ccb3be7415f9f77a72063  SRPMS/chkconfig-0.6-1.src.rpm
a5193bd6c247549fe4b2bd6a0c280b02  SRPMS/fvwm-1.24r-12.src.rpm
0be6f003dce3052f66746ed3b8a0d97f  SRPMS/fvwm95-2.0.42a-7.src.rpm
fe7f0b369d38a48c738c14eb8ee3f007  SRPMS/ghostscript-3.33-6.src.rpm
afbf64718946fec5c667032ebbbd4c15  SRPMS/ghostview-1.5-7.src.rpm
a9a51c407f47e3ac4dfb9c5f2196a1c9  SRPMS/gimp-0.99.12-1.src.rpm
adf5e364490d39db1c7009189eefc1bd  SRPMS/gnuplot-3.5-7.src.rpm
fb50640226d2831bdb8415365ec7916b  SRPMS/gtk-0.99.970925-2.src.rpm
993a0d8eede6ab505170424d19ccb95a  SRPMS/guavac-0.2.6pl1-1.src.rpm
29e01cf7e9a6ba3cfb98c8b40a8179a1  SRPMS/jed-0.97.14-5.src.rpm
9d248d951b49f299ddec4d5b01793740  SRPMS/kterm-6.1.0-8.src.rpm
a71e5cc387aff865005ccbf3df71987b  SRPMS/maplay-1.2-5.src.rpm
d91363b6e4d23a476ecfcc6ce2336977  SRPMS/mc-4.1.3-3.src.rpm
2334be37741b41a57c2cb2bb43a84342  SRPMS/metamail-2.7-8.src.rpm
60ce6a8b34bdf271b5e7b54842d1f867  SRPMS/mkxauth-1.7-6.src.rpm
d09d999ca1e4c3415e8e4deea7f633eb  SRPMS/moonclock-1.0-8.src.rpm
70ae5dda5ed9f2b634407c67b75a5cf9  SRPMS/newt-0.12-1.src.rpm
ad830b56c87e4cc837cad7c51a52aebf  SRPMS/python-1.4-7.src.rpm
bda1285e9ff03183cb029e7ff917c191  SRPMS/pythonlib-1.20-1.src.rpm
e2a9381e6e60489ed3dbadb6ad79098c  SRPMS/rhs-printfilters-1.41-2.src.rpm
bcd8e1345c504f0b48cfc71ab2a3943d  SRPMS/rxvt-2.20-3.src.rpm
11bbe622cb4de5847329c906a39bb865  SRPMS/seyon-2.14c-8.src.rpm
401de114a093415db18de3f1da989b7b  SRPMS/spider-1.0-4.src.rpm
e96312187c5c701148c1a48c71320fb6  SRPMS/tcltk-8.0-9.src.rpm
fe5de8a5acbe0c9f10382bdc4023ce09  SRPMS/tcsh-6.06-12.src.rpm
9f560ebe109a41a34f9a22528bb3a062  SRPMS/tetex-0.4pl8-8.src.rpm
f576e4d9173104f79f0ec779f56dbc2c  SRPMS/transfig-3.1.2-e.src.rpm
4b850c222ab94bc54355c4e2694f93ec  SRPMS/usercfg-3.4-3.src.rpm
270908a58fa90062e135ea5f6175611f  SRPMS/x3270-3.1.0.7-5.src.rpm
5c32fca774cf9961e623b5b29513eca4  SRPMS/xanim-27064-2.src.rpm
29c484d221e87bcad87326b5574151a9  SRPMS/xbanner-1.3-3.src.rpm
18f20f843ab77135f59f76be772ecff1  SRPMS/xbill-1.1-5.src.rpm
c22e9940c4b577334603e24831c65a62  SRPMS/xbl-1.0f-6.src.rpm
ed40bba71ab46b1423cf6b1a7d99be68  SRPMS/xboard-3.2.pl0-7.src.rpm
17862b66b41085fe5421f60c1c742836  SRPMS/xboing-2.3-5.src.rpm
3291fd7ca7c12b53127dc58bfe31d109  SRPMS/xdaliclock-2.07-3.src.rpm
c92d093de48197e709d8a34284803f02  SRPMS/xdemineur-1.1-6.src.rpm
65f47546fa9e22d450c634c746a71638  SRPMS/xearth-1.0-6.src.rpm
9c45eb710b90b2c719d42d40757ed017  SRPMS/xevil-1.5-5.src.rpm
e748c55eca415624ef56478c079a6ef4  SRPMS/xfig-3.1.4-9.src.rpm
8c59179819496cd02ddbdac3dfe435ee  SRPMS/xfishtank-2.0-7.src.rpm
1044469e6f268813435012dabc11e569  SRPMS/xfm-1.3.2-6.src.rpm
e5abad29ea10dfe0e1a7e48f4f94ed2a  SRPMS/xgalaga-1.6c-4.src.rpm
faa0be7ef1b2f53fb2d6bdd092f01a82  SRPMS/xgammon-0.98-8.src.rpm
f1efd5be121dc48bb0f5152410fe6816  SRPMS/xgopher-1.3.3-3.src.rpm
dacb7477367e3cc1639f0747563ce95c  SRPMS/xjewel-1.6-6.src.rpm
a1e379851025e61ad9cce442b776344b  SRPMS/xlander-1.2-6.src.rpm
b31d2aef61ae7e27f6b12f22fd6c1931  SRPMS/xloadimage-4.1-7.src.rpm
ce3c4140d3473389827431a3f932b9ca  SRPMS/xlockmore-4.04-1.src.rpm
7506a78e1caad8b0f4ce20ead40f26c6  SRPMS/xmailbox-2.4-5.src.rpm
35db377c6b698dbfb406724009a9f989  SRPMS/xmorph-1996.07.12-3.src.rpm
bd0382ef8a59a06af3e92a19d0f617e7  SRPMS/xpaint-2.4.7-3.src.rpm
efc719a523d84b83d01a479062e55a8d  SRPMS/xpat2-1.04-4.src.rpm
5373213258ca057519f36e1c78961eb8  SRPMS/xpilot-3.6.1-2.src.rpm
ee69e4436d1a9891423dabcdabcdbaf7  SRPMS/xpuzzles-5.3.1-3.src.rpm
37587aea1077a5a2acf39edb6fe4bcc7  SRPMS/xrn-8.02-4.src.rpm
9583e4871f94eb79d850d26d2c594e1b  SRPMS/xscreensaver-1.26-6.src.rpm
dbeb3a6f8ef3e7c1fb79d95a068bf2a1  SRPMS/xsnow-1.40-3.src.rpm
46cf53f9322d606a9f8c05a13b4e2568  SRPMS/xsysinfo-1.5-3.src.rpm
a9cbdaa7262a17f60d39a7e8886084f2  SRPMS/xterm-color-1.1-5.src.rpm
a7c78350c22bc7b8bf602257430a8859  SRPMS/xtoolwait-0.3-4.src.rpm
c6eb0534edf15c26caf2bfd48f3f5b8e  SRPMS/xv-3.10a-7.src.rpm
8fafd40a7dae65a884093d10b91c9c6a  SRPMS/xtrojka-1.2.2-3.src.rpm
6e7c5971078f613b558593db22c9a3f6  SRPMS/xwpick-2.20-6.src.rpm
7e66a3889534a92ffaaa1108f3e91b5d  SRPMS/xxgdb-1.12-2.src.rpm
d58b2e110bfe5ee2fbe694fba43a640c  SRPMS/xzip-140-5.src.rpm
1e45d6b8f2e0a25d9acb5591d0390f9a  SRPMS/ytalk-3.0.3-2.src.rpm

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3i
Charset: latin1

iQCVAwUBNH7d5Uckbl6vezDBAQGgwAP/UBNT9EJZDmTXZT63skzeu8xcNcPSu/hY
La4sve0DG+iWjrvsCgb9Vv7DMu/nGGF7QQQUOFXVCkAZVHK+x7/eQf1bd3nJSgYb
JBDnBzkrU8npUEpMvomKqj0Y2Ohmc3nNlricNhO+OeTMblAHGFNujmI7SXA/g3db
y+FSRx16wpY=
=+RqM
-----END PGP SIGNATURE-----
