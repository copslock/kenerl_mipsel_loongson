Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 16:54:36 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:15889
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225222AbTGaPye>; Thu, 31 Jul 2003 16:54:34 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id LAA26833
	for <linux-mips@linux-mips.org>; Thu, 31 Jul 2003 11:54:16 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id LAA06954
	for <linux-mips@linux-mips.org>; Thu, 31 Jul 2003 11:54:16 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Thu, 31 Jul 2003 11:54:15 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: mips64/setup.c
Message-ID: <Pine.GSO.4.44.0307311150440.6891-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

Is the file mips64/setup.c used? I believe that I see two problems in it;
1) The Ocelot options in setup_arch have case statements without a switch.
2) There is no option for Sead but the mips64 build for sead compiles
fine.
Is this some leftovers from some merging that has been talked about?

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
