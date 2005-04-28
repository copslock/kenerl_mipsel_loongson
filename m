Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 21:56:56 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:27912 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225768AbVD1U4m>; Thu, 28 Apr 2005 21:56:42 +0100
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j3SKopfg005185;
	Thu, 28 Apr 2005 16:50:51 -0400
In-Reply-To: <8230E1CC35AF9F43839F3049E930169A137217@yang.LibreStream.local>
References: <8230E1CC35AF9F43839F3049E930169A137217@yang.LibreStream.local>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ca9dea6d5cc67afd6a42f06de4286bf9@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	<linux-mips@linux-mips.org>,
	"Herbert Valerio Riedel" <hvr@hvrlab.org>,
	"Josh Green" <jgreen@users.sourceforge.net>,
	"Pete Popov" <ppopov@embeddedalley.com>
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: iptables/vmalloc issues on alchemy
Date:	Thu, 28 Apr 2005 16:56:39 -0400
To:	"Christian Gan" <christian.gan@librestream.com>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Apr 28, 2005, at 4:11 PM, Christian Gan wrote:

> Could this also related to this problem I posted a long time ago?  I
> haven't had a chance to revisit things for a while...

I've just been talking about 2.6, so "long time ago" can't be
that long :-)  I have the updates to the exception handler so
the PTEs get loaded correctly, that's on the way.  I think 2.4
should be OK if anyone is using that.

The one that bothers me is this patch I've been sitting on for
quite some time.  It's not specific to Alchemy, it's a generic
MIPS page table issue.  The problem started when someone
loaded very large modules which caused a new kernel page
table to be allocated.  For some reason I don't remember,
the vmalloc_fault fixup didn't handle this, and the applications
would crash the system because their pgd page  didn't
get updated to reflect this.  The address must have been in
the vmalloc space, but I no longer have the system for testing
(but the code is running in a several thousand real products).
The only way I could make this work is to test the fault address,
the most significant bit anyway, in the TLB miss handler to
see if it was a user or kernel address.  If it was a kernel address,
I loaded the init_mm pgd instead of the thread pgd.  Just one
test and a couple of instructions, but it was necessary.  I'm
still puzzling, but will remember :-)

Thanks.


	-- Dan
