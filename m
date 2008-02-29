Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Feb 2008 23:12:39 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:31633 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S28596154AbYB2XMh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Feb 2008 23:12:37 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 5E0E7200A237
	for <linux-mips@linux-mips.org>; Sat,  1 Mar 2008 00:12:31 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 22954-01-78 for <linux-mips@linux-mips.org>;
	Sat, 1 Mar 2008 00:12:31 +0100 (CET)
Received: from [192.168.27.166] (152-186-96-87.cust.blixtvik.se [87.96.186.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id F3584200A236
	for <linux-mips@linux-mips.org>; Sat,  1 Mar 2008 00:12:30 +0100 (CET)
Message-ID: <47C89064.7000202@27m.se>
Date:	Sat, 01 Mar 2008 00:08:20 +0100
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Fix for dummy-keyboard and virtual console on 2.4.36.1
X-Enigmail-Version: 0.95.0
Content-Type: multipart/mixed;
 boundary="------------060309040604080906070304"
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060309040604080906070304
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

See attached patch... For some reason gcc 3.4 complains.

Regards,
Markus Gothe

- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHyJBi6I0XmJx2NrwRCO05AJ92Bi4K0NEizm2rRruyjC93hW00cACguw+u
kHm6vINYnEw3rgxfnv+8eV4=
=u7Vb
-----END PGP SIGNATURE-----


--------------060309040604080906070304
Content-Type: text/x-patch;
 name="keyboard_h-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="keyboard_h-fix.patch"

--- linux-2.4.36.1.orig/include/asm-mips/keyboard.orig.h	2008-02-29 22:25:05.000000000 +0100
+++ linux-2.4.36.1/include/asm-mips/keyboard.h	2008-02-29 22:24:40.000000000 +0100
@@ -85,7 +85,7 @@
 extern char kbd_unexpected_up(unsigned char keycode);
 extern void kbd_leds(unsigned char leds);
 extern void kbd_init_hw(void);
-extern unsigned char *kbd_sysrq_xlate;
+extern unsigned char kbd_sysrq_xlate[];
 
 extern unsigned char kbd_sysrq_key;
 #define SYSRQ_KEY kbd_sysrq_key

--------------060309040604080906070304--
