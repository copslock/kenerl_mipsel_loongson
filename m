Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 16:40:48 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:26884 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225305AbULHQkm>; Wed, 8 Dec 2004 16:40:42 +0000
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id iB8GRV9f014690;
	Wed, 8 Dec 2004 11:27:31 -0500
In-Reply-To: <MAILSERVERUhrBb0aCQ0000084e@mailserver.sunrisetelecom.com>
References: <MAILSERVERUhrBb0aCQ0000084e@mailserver.sunrisetelecom.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E304EFD0-4937-11D9-81C3-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: linux-mips@linux-mips.org, ppopov@embeddedalley.com
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Epson13806 performances on Pb1100
Date: Wed, 8 Dec 2004 11:40:36 -0500
To: Karl Lessard <klessard@sunrisetelecom.com>
X-Mailer: Apple Mail (2.619)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Dec 8, 2004, at 11:06 AM, Karl Lessard wrote:

> Everything works fine, but for the speed. It seems that accessing the 
> chip is
> too slow for having high-graphic performances.

A couple of things.  First, the Epson controller is obsolete, I don't
know how much time is worth spending on the software.  If you
don't already have a system in production using it, there isn't
much sense spending time working with it.

Second, with the on-chip controller, I have experimented with
some different cache modes for the frame buffer access.  I
don't know if this applicable to the external 13806, but you
could try.  Alchemy has an application note on this, I believe,
but in any case, here is what I put into the au1100fb.c,
au1100fb_mmap() function:

pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
pgprot_val(vma->vm_page_prot) |= _CACHE_CACHABLE_CUW;

A similar kind of update is in the current CVS tree.

Fujitsu has a bunch of nice high performance embedded
graphics controllers for many different applications.


	-- Dan
