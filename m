Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 22:53:25 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:45317 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3467599AbWBMWxR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 22:53:17 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id CCB9C64D3D; Mon, 13 Feb 2006 22:59:33 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id C457D82BB; Mon, 13 Feb 2006 22:59:27 +0000 (GMT)
Date:	Mon, 13 Feb 2006 22:59:27 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Peter 'p2' De Schrijver <p2@mind.be>,
	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060213225927.GB4226@deprecation.cyrius.com>
References: <20060123225040.GA23576@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl> <20060124122700.GA8527@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver> <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl> <20060203150232.GA25701@deprecation.cyrius.com> <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

BTW, turning CONFIG_VT on leads to these compile errors:

  CC      drivers/tc/lk201.o
drivers/tc/lk201.c:19:26: error: linux/kbd_ll.h: No such file or directory
drivers/tc/lk201.c:23:26: error: asm/keyboard.h: No such file or directory
drivers/tc/lk201.c: In function ‘parse_kbd_rate’:
drivers/tc/lk201.c:189: error: ‘struct kbd_repeat’ has no member named ‘rate’
drivers/tc/lk201.c:190: error: ‘struct kbd_repeat’ has no member named ‘rate’
drivers/tc/lk201.c:190: error: ‘struct kbd_repeat’ has no member named ‘rate’
drivers/tc/lk201.c:196: error: ‘struct kbd_repeat’ has no member named ‘rate’
drivers/tc/lk201.c:197: error: ‘struct kbd_repeat’ has no member named ‘rate’
drivers/tc/lk201.c:198: error: ‘struct kbd_repeat’ has no member named ‘rate’
drivers/tc/lk201.c:199: error: ‘struct kbd_repeat’ has no member named ‘rate’
drivers/tc/lk201.c:200: error: ‘struct kbd_repeat’ has no member named ‘rate’
drivers/tc/lk201.c:201: error: ‘struct kbd_repeat’ has no member named ‘rate’
drivers/tc/lk201.c: In function ‘write_kbd_rate’:
drivers/tc/lk201.c:210: error: ‘struct kbd_repeat’ has no member named ‘rate’
drivers/tc/lk201.c: In function ‘lk201_rx_char’:
drivers/tc/lk201.c:363: warning: implicit declaration of function ‘handle_scancode’
drivers/tc/lk201.c: In function ‘lk201_init’:
drivers/tc/lk201.c:407: error: invalid lvalue in assignment
drivers/tc/lk201.c:408: error: invalid lvalue in assignment
make[2]: *** [drivers/tc/lk201.o] Error 1


--- old-config	2006-02-13 22:55:32.000000000 +0000
+++ .config	2006-02-13 22:55:36.000000000 +0000
@@ -530,7 +530,9 @@
 #
 # Character devices
 #
-# CONFIG_VT is not set
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 CONFIG_SERIAL_DEC=y
 CONFIG_SERIAL_DEC_CONSOLE=y
@@ -631,6 +633,13 @@
 # CONFIG_FB_VIRTUAL is not set
 
 #
+# Console display driver support
+#
+CONFIG_VGA_CONSOLE=y
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+
+#
 # Logo configuration
 #
 CONFIG_LOGO=y

-- 
Martin Michlmayr
http://www.cyrius.com/
