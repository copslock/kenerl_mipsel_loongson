Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2003 15:33:14 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:11083
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225193AbTGUOdC>; Mon, 21 Jul 2003 15:33:02 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA11057
	for <linux-mips@linux-mips.org>; Mon, 21 Jul 2003 10:32:55 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA16289
	for <linux-mips@linux-mips.org>; Mon, 21 Jul 2003 10:32:55 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Mon, 21 Jul 2003 10:32:55 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: 64bit Sead build
Message-ID: <Pine.GSO.4.44.0307211027270.16227-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I'm trying to build linux for Sead in 64 bit. I found that it would not
compile without the change at the end of this note. After this fix, I got
the following link error. Does anyone have an idea why?
*******************************************************************
mips64el-linux-ld --oformat elf32-tradlittlemips -G 0 -static  -Ttext
0x80100000 arch/mips64/kernel/head.o
arch/mips64/kernel/init_task.o init/main.o init/version.o init/do_mounts.o
\
        --start-group \
        arch/mips64/kernel/kernel.o arch/mips64/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o \
        net/network.o \
        arch/mips64/lib/lib.a
/home/dkesselr/MIPS/linux-mips-cvs/2003Jul18/linux-build-mips64b/lib/lib.a
arch/mips/mips-boards/sead/sead.o
arch/mips/mips-boards/generic/mipsboards.o \
        --end-group \
        -o vmlinux
mips64el-linux-ld: warning: cannot find entry symbol __start; defaulting
to 0000000080100000
mips64el-linux-ld: vmlinux: Not enough room for program headers (allocated
3, need 4)
mips64el-linux-ld: final link failed: Bad value
make: *** [vmlinux] Error 1

**************************************************************************
--- 2003Jul21/linux/include/asm-mips64/serial.h	2003-06-15
19:42:21.000000000 -0400
+++ 2003Jul18/linux-build-mips64b/include/asm-mips64/serial.h	2003-07-21
10:25:32.000000000 -0400
@@ -20,8 +20,6 @@
  */
 #define BASE_BAUD (1843200 / 16)

-#ifdef CONFIG_HAVE_STD_PC_SERIAL_PORT
-
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #ifdef CONFIG_SERIAL_DETECT_IRQ
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST |
ASYNC_AUTO_IRQ)
@@ -31,6 +29,7 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif

+#ifdef CONFIG_HAVE_STD_PC_SERIAL_PORT
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\







David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
