Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 18:27:06 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19326 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22756158AbYJ3S0w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Oct 2008 18:26:52 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4909fb390000>; Thu, 30 Oct 2008 14:21:50 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Oct 2008 11:21:45 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Oct 2008 11:21:45 -0700
Message-ID: <4909FB38.5070701@caviumnetworks.com>
Date:	Thu, 30 Oct 2008 11:21:44 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 06/36] Add Cavium OCTEON processor CSR definitions
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <20081029184552.GB32500@lst.de> <4908B717.3010603@caviumnetworks.com> <20081030111354.GF26256@linux-mips.org>
In-Reply-To: <20081030111354.GF26256@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2008 18:21:45.0094 (UTC) FILETIME=[5D55DA60:01C93ABC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> struct foo {
> 	unsigned int	x:1;
> 	unsigned int	y:4;
> };
> 
> void bar(volatile struct foo *p)
> {
> 	p->x = 1;
> 	p->y++;
> }
> 
> which gcc 4.3 for a MIPS32R2 target will compile into:
> 
> 	lw	$3, 0($4)
> 	li	$2, 1
> 	ins	$3, $2, 31, 1
> 	sw	$3, 0($4)
> 	lw	$2, 0($4)
> 	lw	$3, 0($4)
> 	ext	$2, $2, 27, 4
> 	addiu	$2, $2, 1
> 	ins	$3, $2, 27, 4
> 	sw	$3, 0($4)
> 	j	$31
> 	nop
> 
> Imagine struct foo was describing a hardware register so the pointer to it
> was marked volatile.  A human coder wouldn't have done multiple loads /
> stores.  Worse, if you actually want to change multiple fields in a
> register atomically then with bitfields you have _no_ possibility to enforce
> that.
> 

This is bogus as you use a false premise.  For your test case the 
compiler is generating exactly the accesses you are requesting by 
declaring the thing as volatile.

> The Linux programming programming model relies on accessor functions like
> readl, ioread32 etc.  Those take addresses as arguments - but bitfields
> don't have addresses in C ...
> 

We too use accessor functions, as they are required on certain classes 
of registers to obtain correct semantics.

The real question is if manipulating the values after they are obtained 
with the accessor is done correctly.  My assertion is that although it 
may not be the One True Kernel Way, our structure bitfield definitions 
result in correct semantics and have better compile time error checking 
than can be obtained when coding a bunch of explicit masks and shifts.

That is not to say that I am adverse to eliminating the structure 
bitfield definitions, but we should not use incorrect register access 
semantics as the reason, as it is not a valid argument.

David Daney
