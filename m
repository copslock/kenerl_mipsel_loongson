Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 14:52:57 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:11651 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTEWNwz>;
	Fri, 23 May 2003 14:52:55 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h4NDqeLT006028;
	Fri, 23 May 2003 15:52:41 +0200 (MEST)
Date: Fri, 23 May 2003 15:52:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: [PATCH] Embedded ramdisks
Message-ID: <Pine.GSO.4.21.0305231551110.26586-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

	Hi Ralf,

Fix the dependency for embedded ramdisks by using the contents of
CONFIG_EMBEDDED_RAMDISK_IMAGE (after stripping the leading and trailing double
quotes) instead of using the hardcoded filename `ramdisk.gz'.

--- linux-mips-2.4.x/arch/mips/ramdisk/Makefile	Tue Apr  1 16:22:04 2003
+++ linux/arch/mips/ramdisk/Makefile	Wed Apr  2 18:31:48 2003
@@ -8,7 +8,7 @@
 
 O_FORMAT = $(shell $(OBJDUMP) -i | head -2 | grep elf32)
 img = $(CONFIG_EMBEDDED_RAMDISK_IMAGE)
-ramdisk.o: ramdisk.gz ld.script
+ramdisk.o: $(subst ",,$(img)) ld.script
 	echo "O_FORMAT:  " $(O_FORMAT)
 	$(LD) -T ld.script -b binary --oformat $(O_FORMAT) -o $@ $(img)
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
