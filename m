Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jul 2004 03:02:00 +0100 (BST)
Received: from web40005.mail.yahoo.com ([IPv6:::ffff:66.218.78.23]:59499 "HELO
	web40005.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224988AbUGPCBy>; Fri, 16 Jul 2004 03:01:54 +0100
Message-ID: <20040716020147.71295.qmail@web40005.mail.yahoo.com>
Received: from [63.87.1.243] by web40005.mail.yahoo.com via HTTP; Thu, 15 Jul 2004 19:01:47 PDT
Date: Thu, 15 Jul 2004 19:01:47 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: Re: asm-mips/processor.h breaks compiling user applications such as iptables
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040715225657.GA17585@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wsonguci@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsonguci@yahoo.com
Precedence: bulk
X-list: linux-mips

--- Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jul 15, 2004 at 03:22:34PM -0700, Song Wang
> wrote:
> 
> > I think the error is due to the line 146
> > 
> > typedef u64 fpureg_t;
> > 
> > The type 'u64' is defined in asm-mips/types.h, but
> > wrapped by #ifdef __KERNEL__, so when the compiler
> > compiles the user-level application, it cannot
> > recognize u64.
> 
> Correct.  In general the policy is to avoid the use
> of kernel header
> files in user space and copy it but there are still
> a few crucial tools
> that don't follow this rule of Linus, so try below
> patch.  It also
> removes the __KERNEL__ things left.
> 
> Cleaning up the use of kernel header to make them
> more usable for
> userspace is one of the things on the agenda for
> 2.7.  It'll be alot of
> hard and boring work but MIPS will be one of the
> architectures that will
> greatly benefit from this.
> 
>   Ralf
> 
Hi, Ralf

I tested the patch and it compiles fine now, although
when iptables actually runs on mips32, all the 
tcp/udp port numbers are shown as 0 and IP address
shown as 0.0.0.0. I'll dig more.

Anyway, you made a good point for kernel headers
problem. It's kinda headache.

Similar problem happened to asm-mips/page.h when
including <spaces.h> in 2.6.6, but it seemed that
you already fixed in the latest cvs version.

Thanks.

-Song


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
