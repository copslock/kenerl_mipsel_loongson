Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 18:07:58 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:62481
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224907AbUJKRHy>;
	Mon, 11 Oct 2004 18:07:54 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9BH7ku30152;
	Mon, 11 Oct 2004 10:07:47 -0700
Message-ID: <416ABDD8.5020102@embeddedalley.com>
Date: Mon, 11 Oct 2004 10:07:36 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
References: <1097452888.4627.25.camel@localhost.localdomain> <Pine.LNX.4.58L.0410110126120.4217@blysk.ds.pg.gda.pl> <1097481328.27818.10.camel@localhost.localdomain> <20041011103231.GA19949@lst.de>
In-Reply-To: <20041011103231.GA19949@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:
>>===================================================================
>>RCS file: arch/mips/mm/remap.c
>>diff -N arch/mips/mm/remap.c
>>--- /dev/null	1 Jan 1970 00:00:00 -0000
>>+++ arch/mips/mm/remap.c	19 Sep 2004 22:51:21 -0000
>>@@ -0,0 +1,115 @@
>>+/*
>>+ *  arch/mips/mm/remap.c
>>+ *
>>+ *  A copy of mm/memory.c, with mods for 64 bit physical I/O addresses on
>>+ *  32 bit native word platforms.
> 
> 
> This is horrible.  Please submit any modifications you'll need over
> remap_page_pfn (as in -mm) that you still need and ensure they're
> portable.

Using remap_page_pfn would simplify the patch but that's very recent and 
I didn't even know it made it in yet. Running MIPS on top of the -mm 
tree might be a problem though, I haven't tried. I'm not sure how up to 
date MIPS is in that tree so I might have to wait until the  changes 
make it to kernel.org and then update the patch to remove remap.c and 
use remap_page_pfn instead.

Pete
