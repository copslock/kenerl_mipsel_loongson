Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 16:47:52 +0100 (CET)
Received: from mail2.sonytel.be ([195.0.45.172]:11142 "EHLO mail.sonytel.be")
	by linux-mips.org with ESMTP id <S8225295AbSLEPrh>;
	Thu, 5 Dec 2002 16:47:37 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA17203;
	Thu, 5 Dec 2002 16:47:30 +0100 (MET)
Date: Thu, 5 Dec 2002 16:47:31 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: [PATCH] Embedded ramdisks
Message-ID: <Pine.GSO.4.21.0212051643360.7346-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips


The embedded ramdisk support allows to embed an arbitrary file in the image,
but the dependency in the Makefile still contains the hardcoded name
`ramdisk.gz'. This patch changes the dependency so it matches the selected file
name during kernel configuration.

The sed magic is needed because the kernel configuration embeds the filename in
double quotes.

--- linux-mips-2.4.x/arch/mips/ramdisk/Makefile	Fri Oct 25 13:37:30 2002
+++ geert-mips-2.4.x/arch/mips/ramdisk/Makefile	Thu Dec  5 11:53:14 2002
@@ -8,7 +8,7 @@
 
 O_FORMAT = $(shell $(OBJDUMP) -i | head -2 | grep elf32)
 img = $(CONFIG_EMBEDDED_RAMDISK_IMAGE)
-ramdisk.o: ramdisk.gz ld.script
+ramdisk.o: $(shell echo $(img) | sed -e 's/"//g') ld.script
 	echo "O_FORMAT:  " $(O_FORMAT)
 	$(LD) -T ld.script -b binary --oformat $(O_FORMAT) -o $@ $(img)
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
