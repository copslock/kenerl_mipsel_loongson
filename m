Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 08:10:28 +0100 (BST)
Received: from smtp6.infineon.com ([IPv6:::ffff:217.10.50.128]:56352 "EHLO
	smtp6.infineon.com") by linux-mips.org with ESMTP
	id <S8225250AbUJTHKX> convert rfc822-to-8bit; Wed, 20 Oct 2004 08:10:23 +0100
Received: from unknown (HELO mucse211.eu.infineon.com) (172.29.27.228)
  by smtp6.infineon.com with ESMTP; 20 Oct 2004 09:55:37 +0200
X-SBRS: None
Received: from dusse201.eu.infineon.com ([172.29.128.17]) by mucse211.eu.infineon.com over TLS secured channel with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 20 Oct 2004 09:10:04 +0200
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Mozilla Firefox compile problem
Date: Wed, 20 Oct 2004 09:10:03 +0200
Message-ID: <34A8108658DCCE4B8595675ABFD8172709FAFF@dusse201.eu.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mozilla Firefox compile problem
Thread-Index: AcS1ZPeNi/Z1+9xUQCWBGRohZlIPGgBDRvig
From: <Andre.Messerschmidt@infineon.com>
To: <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 20 Oct 2004 07:10:04.0952 (UTC) FILETIME=[D2EDF180:01C4B673]
Return-Path: <Andre.Messerschmidt@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andre.Messerschmidt@infineon.com
Precedence: bulk
X-list: linux-mips


>This patch is broken and will only paper over the problem. Use 
>the patch in https://bugzilla.mozilla.org/show_bug.cgi?id=258429
>At least the firefox 0.93 in Debian mips works with it.

Thanks for the reply. With that patch I got two undefined macros
(SETUP_GP and SAVE_GP). SETUP_GP was mentioned in the thread, but I
could not find a definition for SAVE_GP. To go on I just defined it
empty and continued to compile.
Then I got the following error, which leaves me totally lost.

--- snip --------------------------------------
mips-linux-g++ -I/opt/mvx/usr/X11R6/include -fno-rtti -fno-exceptions
-Wall -Wconversion -Wpointer-arith -Wcast-align -Woverloaded-virtual
-Wsynth -Wno-ctor-dtor-privacy -Wno-non-virtual-dtor -Wno-long-long
-Wa,-xgot -pthread -pipe  -DDEBUG -D_DEBUG -DDEBUG_am -DTRACING -g
-fno-inline -fPIC -shared -Wl,-h -Wl,libnecko2.so -o libnecko2.so
nsNetModule2.o             -Wl,--whole-archive
../../dist/lib/libnkdata_s.a  ../../dist/lib/libnkgopher_s.a
../../dist/lib/libnkkeyword_s.a  ../../dist/lib/libnkviewsource_s.a
-Wl,--no-whole-archive -L../../dist/bin -lxpcom  -L../../dist/bin
-L/data2/Sources/inca/mozilla/dist/lib -lplds4 -lplc4 -lnspr4 -lpthread
-ldl    -Wl,-Bsymbolic -ldl -lm
chmod +x libnecko2.so
/data2/Sources/inca/mozilla/config/nsinstall -R -m 755 libnecko2.so
../../dist/gre/components
: ../../dist/gre/components/libnecko2.so
/data2/Sources/inca/mozilla/config/nsinstall -R -m 755 libnecko2.so
../../dist/lib/components
: ../../dist/lib/components/libnecko2.so
/data2/Sources/inca/mozilla/config/nsinstall -R -m 755 libnecko2.so
../../dist/bin/components
: ../../dist/bin/components/libnecko2.so
gmake[3]: Leaving directory `/data2/Sources/inca/mozilla/netwerk/build2'
gmake[3]: Entering directory
`/data2/Sources/inca/mozilla/netwerk/resources'
+++ making chrome /data2/Sources/inca/mozilla/netwerk/resources  =>
../../dist/bin/chrome/comm.jar
+++ adding chrome ../../dist/bin/chrome/installed-chrome.txt
+++
content,install,url,jar:resource:/chrome/comm.jar!/content/necko/
        zip warning: ../comm.jar not found or empty
  adding: content/necko/redirect_loop.xul (stored 0%)
+++ overriding content/necko/contents.rdf
  adding: content/necko/contents.rdf (stored 0%)
+++ making chrome /data2/Sources/inca/mozilla/netwerk/resources  =>
../../dist/bin/chrome/en-US.jar
error: file '../../toolkit/locales/en-US/chrome/necko/contents.rdf'
doesn't exist at ../../config/make-jars.pl line 418, <STDIN> line 9.
gmake[3]: *** [libs] Fehler 2
gmake[3]: Leaving directory
`/data2/Sources/inca/mozilla/netwerk/resources'
gmake[2]: *** [libs] Fehler 2
gmake[2]: Leaving directory `/data2/Sources/inca/mozilla/netwerk'
gmake[1]: *** [tier_9] Fehler 2
gmake[1]: Leaving directory `/data2/Sources/inca/mozilla'
make: *** [default] Fehler 2
--- snap --------------------------------------

Anyone any ideas?

Best regards
Andre
