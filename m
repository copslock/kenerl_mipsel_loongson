Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 15:48:01 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:29085
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225233AbTHAOr6>; Fri, 1 Aug 2003 15:47:58 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA07930
	for <linux-mips@linux-mips.org>; Fri, 1 Aug 2003 10:47:51 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA07920
	for <linux-mips@linux-mips.org>; Fri, 1 Aug 2003 10:47:51 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Fri, 1 Aug 2003 10:47:51 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: sead_int.c
Message-ID: <Pine.GSO.4.44.0308011043090.7852-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

Tell me if I'm incorrect but it looks like this for condition is wrong.
There are only 2 defined irqs.

	for (i = 0; i <= SEADINT_END; i++)
	              ^^	should be just < ??

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
