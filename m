Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 20:07:06 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:65273
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225376AbTIWTHD>; Tue, 23 Sep 2003 20:07:03 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id PAA20107
	for <linux-mips@linux-mips.org>; Tue, 23 Sep 2003 15:06:57 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id PAA09823
	for <linux-mips@linux-mips.org>; Tue, 23 Sep 2003 15:06:56 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Tue, 23 Sep 2003 15:06:56 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: Malta build 2.4 (fwd)
Message-ID: <Pine.GSO.4.44.0309231505310.2816-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

The problem is somehow related to "make menuconfig" setting CONFIG_ARC=y.
When I configured with xconfig the build was ok.

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587

---------- Forwarded message ----------
Date: Tue, 23 Sep 2003 13:01:41 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: Malta build 2.4

I've just checked out the 2.4 tree from linux-mips cvs and used the Malta
config file, defconfig-malta. I get the following error. Does anyone know
if it a Makefile bug or a config file problem?

drivers/char/char.o: In function `console_init':
drivers/char/char.o(.text.init+0x178): undefined reference to
`arc_console_init'make: *** [vmlinux] Error 1

Thanks,
David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
