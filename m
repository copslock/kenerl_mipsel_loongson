Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2003 19:28:57 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:22150
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225202AbTHKS2z>; Mon, 11 Aug 2003 19:28:55 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id OAA07856
	for <linux-mips@linux-mips.org>; Mon, 11 Aug 2003 14:28:47 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id OAA04603
	for <linux-mips@linux-mips.org>; Mon, 11 Aug 2003 14:28:47 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Mon, 11 Aug 2003 14:28:46 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: C0 config reg for 5k core
Message-ID: <Pine.GSO.4.44.0308111422220.4449-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

Has anyone else built linux 2.4 for a 5k or 5kf core? When comparing cpu.h
and the MIPS64 5K Processor Core Family Software Users Manual it doesn't
look to me that the c0-config1 reg is defined the same way. Am I reading
something wrong? For example in the spec FPU flag is bit0 while in cpu.h
it is bit4. Seems pretty basic.

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
