Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2003 18:53:46 +0000 (GMT)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:29773
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225382AbTKCSxe>; Mon, 3 Nov 2003 18:53:34 +0000
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id NAA26809
	for <linux-mips@linux-mips.org>; Mon, 3 Nov 2003 13:53:27 -0500 (EST)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id NAA24901
	for <linux-mips@linux-mips.org>; Mon, 3 Nov 2003 13:53:21 -0500 (EST)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Mon, 3 Nov 2003 13:53:21 -0500 (EST)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: lib.a
Message-ID: <Pine.GSO.4.44.0311031349360.24745-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

For the mips architecture, it seems like arch/mips/lib/lib.a is linked in
and not lib/lib.a. For example on menuconfig when zlib* is selected, it is
not included in the final link. Is my understanding correct? Specifically,
2.4.23 has a firmware library (from lib/) that I would like to use with a
driver but regardless of my .config it is not being linked.
Thanks for your help.

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
