Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 13:48:27 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:31116
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225193AbTGWMsY>; Wed, 23 Jul 2003 13:48:24 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id IAA01880
	for <linux-mips@linux-mips.org>; Wed, 23 Jul 2003 08:48:04 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id IAA17982
	for <linux-mips@linux-mips.org>; Wed, 23 Jul 2003 08:48:04 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Wed, 23 Jul 2003 08:48:03 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: odd link error
Message-ID: <Pine.GSO.4.44.0307230844470.17973-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I know my build for a custom board isn't right but it got through the
compiles only to get this link error. Does anyone know what it might point
to?

mips64el-linux-ld --oformat elf32-tradlittlemips -G 0 -static  -T
arch/mips64/ld.script.elf32 -Ttext  arch/mips64/kernel/head.o
arch/mips64/kernel/init_task.o init/main.o init/version.o init/do_mounts.o
\
        --start-group \
        arch/mips64/kernel/kernel.o arch/mips64/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o
arch/mips/ramdisk/ramdisk.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o \
        net/network.o \
        arch/mips64/lib/lib.a
/home/dkesselr/stbsw/linux/linux-64sead/lib/lib.a \
        --end-group \
        -o vmlinux
mips64el-linux-ld: invalid hex number `arch/mips64/kernel/head.o'
make: *** [vmlinux] Error 1


David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
