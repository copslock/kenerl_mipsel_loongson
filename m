Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2003 15:27:27 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:6994
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225229AbTGXO1Z>; Thu, 24 Jul 2003 15:27:25 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA16323
	for <linux-mips@linux-mips.org>; Thu, 24 Jul 2003 10:27:16 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA23245
	for <linux-mips@linux-mips.org>; Thu, 24 Jul 2003 10:27:16 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Thu, 24 Jul 2003 10:27:16 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: boot requirements
Message-ID: <Pine.GSO.4.44.0307241019450.23101-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I am trying to determine what has to be included in our boot code to start
linux. I didn't think I needed to port yamon. What does yamon or pmon
provide for starting or debugging(gdb) linux? Does the processor need to
be in a specific state or context before jumping from the boot code to the
linux downloaded image? If someone can point me to a simple example, I
would greatly appreciate it.

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
