Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 18:12:33 +0000 (GMT)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:3446
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225362AbTJ1SM3>; Tue, 28 Oct 2003 18:12:29 +0000
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id NAA09445
	for <linux-mips@linux-mips.org>; Tue, 28 Oct 2003 13:12:19 -0500 (EST)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id NAA20687
	for <linux-mips@linux-mips.org>; Tue, 28 Oct 2003 13:12:18 -0500 (EST)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Tue, 28 Oct 2003 13:12:18 -0500 (EST)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: Unresolved symbols
Message-ID: <Pine.GSO.4.44.0310281308450.20592-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I've been unabled to track down these errors. I think it's because I don't
understand how some of the linux h files are used by an independently
compiled kernel module. Why is "extern __inline__" used in a file like
atomic.h.
If any of you have any pointers on the following errors, I'd appreciate
your comments.
/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol
atomic_sub_return
/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol __udelay
/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol atomic_add
/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol strcpy
/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol atomic_sub

Thanks,

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
