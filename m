Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 21:20:33 +0100 (BST)
Received: from frank.harvard.edu ([IPv6:::ffff:140.247.122.99]:21671 "EHLO
	frank.harvard.edu") by linux-mips.org with ESMTP
	id <S8225208AbTDXUUa>; Thu, 24 Apr 2003 21:20:30 +0100
Received: from frank.harvard.edu (frank.harvard.edu [140.247.122.99])
	by frank.harvard.edu (8.11.6/8.11.6) with ESMTP id h3OKKTI18285
	for <linux-mips@linux-mips.org>; Thu, 24 Apr 2003 16:20:29 -0400
Date: Thu, 24 Apr 2003 16:20:29 -0400 (EDT)
From: Chip Coldwell <coldwell@frank.harvard.edu>
To: linux-mips@linux-mips.org
Subject: NCD900 port?
Message-ID: <Pine.LNX.4.44.0304241613190.18155-100000@frank.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <coldwell@frank.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: coldwell@frank.harvard.edu
Precedence: bulk
X-list: linux-mips


I'm facing a ~$1K site license charge for NCD's NCBridge software for
their NC948 X Terminals, and since my site consists of exactly three
of these things that I bought for less than $250 each I'm balking a
bit.

The NC948 consists of a 165 MHz QED RM5231, S3 Savage4 graphics
controller, and an AMD PCnet NIC of some sort.  It doesn't seem like
there's anything in that set that Linux or XFree86 wouldn't be happy
to run.

To be completely explicit what I'm proposing is to run Linux on the X
Terminal (as opposed to the server that provides boot image, xdm,
etc.).  My question is: has anybody done it or does anybody know a
reason why it can't be done?

Chip

-- 
Charles  M. "Chip" Coldwell
"Turn on, log in, tune out"
