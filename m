Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2003 17:55:23 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:31594
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225347AbTFFQzV>; Fri, 6 Jun 2003 17:55:21 +0100
Received: from hydra.mmc.atmel.com (hydra.mmc.atmel.com [10.127.240.58])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id MAA12340
	for <linux-mips@linux-mips.org>; Fri, 6 Jun 2003 12:55:13 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by hydra.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id MAA04073
	for <linux-mips@linux-mips.org>; Fri, 6 Jun 2003 12:55:13 -0400 (EDT)
X-Authentication-Warning: hydra.mmc.atmel.com: dkesselr owned process doing -bs
Date: Fri, 6 Jun 2003 12:55:13 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: state of 64 bit support
Message-ID: <Pine.GSO.4.44.0306061234410.4045-100000@hydra.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I've been trying to get a 64 bit compiler working for a 5kc/5kf core,
searching the net for info, and following this list for the last couple of
weeks. I have not been able to get some basic questions answered and I
hope that some of you can help me.
First what is the current status of mips 5k 64bit little-endian support
for gcc? Do I have to use 2.95/2.96? I don't think there is a linux binary
but if you know of one I'd love the link. I have been unsuccessful getting
this built.
On the web, there is a howto to build a mipsel gcc 3.2. Does 3.2 support
64 bit mips? Has anyone gotten it to work?

Also linux. From my understanding, kernel 2.4.20 has the latest patches
for mips32 and mips64. Is that a valid codebase?
It seems that some info in the howto regarding building a compiler with
egcs on linux-mips.org is somewhat dated, is that true?

I really appreciate any guidance. I've been trying to follow the
instructions that are out there but I keep running into problems.
For example, as I try to build gcc 3.2 for mips64el, I can't come up with
a correct include directory. Does anyone have one?

Very, very appreciatively yours,

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
