Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2003 18:45:39 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:39578
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225436AbTI2RpZ>; Mon, 29 Sep 2003 18:45:25 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id NAA07416
	for <linux-mips@linux-mips.org>; Mon, 29 Sep 2003 13:45:18 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id NAA04465
	for <linux-mips@linux-mips.org>; Mon, 29 Sep 2003 13:45:18 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Mon, 29 Sep 2003 13:45:18 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: failed build of Mips for 2.4.22
Message-ID: <Pine.GSO.4.44.0309291339570.4225-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

When I tried to build 2.4.22 (including patch-2.4.22-ac4) for Malta, the
build failed when compiling offset.c. It looks like several things changed
in the base code that caused the failure. Does anyone have a patch for the
MIPS build on 2.4.22. I need to use this because a required driver is
already built for 2.4.22. The crux of the problem is the new DFU
stuff(whatever that is).
Thanks for any input.

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
