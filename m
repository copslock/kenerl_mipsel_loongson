Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Dec 2002 10:38:51 +0100 (MET)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:39095 "EHLO
	mail.sonytel.be") by ralf.linux-mips.org with ESMTP
	id <S868793AbSLBJik>; Mon, 2 Dec 2002 10:38:40 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA03912;
	Mon, 2 Dec 2002 10:40:51 +0100 (MET)
Date: Mon, 2 Dec 2002 10:40:50 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: [PATCH] Eagle compile fix
Message-ID: <Pine.GSO.4.21.0212021039440.10713-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips


The compilation of arch/mips/vr41xx/common/serial.c depends on CONFIG_SERIAL.

--- linux-mips-2.4.x/arch/mips/vr41xx/nec-eagle/setup.c.orig	Mon Jul 15 02:02:56 2002
+++ linux-mips-2.4.x/arch/mips/vr41xx/nec-eagle/setup.c	Mon Dec  2 10:38:16 2002
@@ -143,8 +143,10 @@
 
 	vr41xx_cmu_init(0);
 
+#ifdef CONFIG_SERIAL
 	vr41xx_dsiu_init();
 	vr41xx_siu_init(SIU_RS232C, 0);
+#endif
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
