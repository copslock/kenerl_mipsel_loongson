Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2004 20:14:51 +0000 (GMT)
Received: from keymaster.sharplabs.com ([IPv6:::ffff:216.65.151.107]:12942
	"EHLO sharplabs.com") by linux-mips.org with ESMTP
	id <S8225206AbUCHUOu>; Mon, 8 Mar 2004 20:14:50 +0000
Received: from admsrvnt02.enet.sharplabs.com (admsrvnt02.enet.sharplabs.com [172.29.225.253])
	by sharplabs.com (8.12.8/8.12.8) with ESMTP id i28KEdZF002487
	for <linux-mips@linux-mips.org>; Mon, 8 Mar 2004 12:14:42 -0800 (PST)
Received: by admsrvnt02.enet.sharplabs.com with Internet Mail Service (5.5.2653.19)
	id <FZ5RCQQQ>; Mon, 8 Mar 2004 12:14:40 -0800
Message-ID: <CFEE79A465B35C4385389BA5866BEDF0148F9F@mailsrvnt02.enet.sharplabs.com>
From: "Rutman, Nathan" <nrutman@sharplabs.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: userspace virtual memory problem
Date: Mon, 8 Mar 2004 12:14:39 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <nrutman@sharplabs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nrutman@sharplabs.com
Precedence: bulk
X-list: linux-mips

[ Mips newbie, please provide lots of context :) ]

We're bringing up Linux on a new custom RM7000-based board.  Almost
everything is working, except for the following odd behavior:
Userspace virtual addresses in the range 0x2c00_0000 to 0x4000_0000 are
unwritable, and always read as FF's.  This is true whether I malloc() the
space, or mmap() it via remap_page_range().  The physical memory is working
fine, and is completely readable/writable from the kernel via ioremap().
Userspace virtual memory outside these addesses all works.  If I mmap the
same physical memory to two user vitrual addresses, one inside the bad range
and one outside, the outside one works and the inside one doesn't.

So the question of course is Why, or failing that, where do I start to look?
And I guess: where can I make a quick hack to make the memory allocator skip
the bad range?


Nathan
