Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2003 15:32:29 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:14864
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225417AbTJTOcW>; Mon, 20 Oct 2003 15:32:22 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA29333
	for <linux-mips@linux-mips.org>; Mon, 20 Oct 2003 10:32:11 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA12939
	for <linux-mips@linux-mips.org>; Mon, 20 Oct 2003 10:32:08 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Mon, 20 Oct 2003 10:32:08 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: kernel modules
Message-ID: <Pine.GSO.4.44.0310201029090.12930-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

Can someone please confirm that loading and unloading of kernel modules is
functioning in the  2.4 release?

When I try to load a wlan module that I compiled (with mipsel-*) I get
relocation errors. I used the same options as I did to compile the kernel
(for MIPS Malta board). If you have any ideas, please let me know.


David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
