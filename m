Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2003 22:23:07 +0000 (GMT)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:3967
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225382AbTKCWW4>; Mon, 3 Nov 2003 22:22:56 +0000
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id RAA29528
	for <linux-mips@linux-mips.org>; Mon, 3 Nov 2003 17:22:49 -0500 (EST)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id RAA25000
	for <linux-mips@linux-mips.org>; Mon, 3 Nov 2003 17:22:42 -0500 (EST)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Mon, 3 Nov 2003 17:22:42 -0500 (EST)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: Re:lib.a
Message-ID: <Pine.GSO.4.44.0311031717560.24745-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

The function that I am missing (release_firmware) is compiled into
lib/lib.a. and shows up in lib.a.flags. But it does not show up in vmlinux
binary or the symbol table. I couldn't see that the generic Malta make
file has any garbage collection on but I can't see where it is lost.
What I get is unresolved symbols when I insmod my driver.
Any ideas from the experts?

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
