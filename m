Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2009 23:57:26 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59257 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493092AbZHNV5T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Aug 2009 23:57:19 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7ELw0Cn008828;
	Fri, 14 Aug 2009 22:58:02 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7ELvxaY008826;
	Fri, 14 Aug 2009 22:57:59 +0100
Date:	Fri, 14 Aug 2009 22:57:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	Adam Nemet <anemet@caviumnetworks.com>
Subject: Re: .subsection madness
Message-ID: <20090814215759.GA8282@linux-mips.org>
References: <4A85ABD3.5040801@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A85ABD3.5040801@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 14, 2009 at 11:24:19AM -0700, David Daney wrote:

> In atomic.h for atomic_add we have this gem:
>
> 	__asm__ __volatile__(
> 	"	.set	mips3					\n"
> 	"1:	ll	%0, %1		# atomic_add		\n"
> 	"	addu	%0, %2					\n"
> 	"	sc	%0, %1					\n"
> 	"	beqz	%0, 2f					\n"
> 	"	.subsection 2					\n"
> 	"2:	b	1b					\n"
> 	"	.previous					\n"
> 	"	.set	mips0					\n"
>
>
> What is the purpose of the .subsection here?
>
> It will not affect branch prediction in the beqz as nothing happens in  
> .subsection 2.

I'm not following.  Most simple branch predictors will assume a backward
branch to be a loop completion branch and thus predict it as taken while
we assume that the SC instruction rarely fails no matter if spinlock,
bit or atomic operation.

It can even help on a CPU without branch prediction like the R4000 which
kills the two instruction following the delay slot for a taken branch.

> For spin locks it is clear that this technique can help, but for  
> atomic_add I don't think so.  To make matters worse for some code the  
> subsection is going out of branch range.

That problem should have be solved by building the kernel with
-ffunction-sections.  Other architectures needed -ffunction-sections for
the same reason.

  Ralf
