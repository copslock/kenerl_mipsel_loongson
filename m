Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 21:09:29 +0200 (CEST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:63644 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133865AbWFBTJS
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Jun 2006 21:09:18 +0200
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k52J8ucQ018137;
	Fri, 2 Jun 2006 12:09:02 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k52J8t6E020955;
	Fri, 2 Jun 2006 12:08:55 -0700 (PDT)
Message-ID: <01b401c68678$98199a10$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Prasad Boddupalli" <bprasad@cs.arizona.edu>,
	<linux-mips@linux-mips.org>
References: <e8180c7f0606021139w6d26e03eice708d5076cccf64@mail.gmail.com>
Subject: Re: replacing synthesized tlb handlers with older ones
Date:	Fri, 2 Jun 2006 21:13:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

The TLB refill handler behavior for 1 CPU is fundamentally
different than for SMP.  In the uniprocessor case, the page
table origin is implicit, whereas in SMP it needs to be indexed
by some per-CPU value, typically maintained in the Context
register.  Pre-synthesed kernels set up up so that the Context
value would be shifted left 23 bits, then right by 2 bits, to generate
an offset.  The newer system eliminates the right shift by ensuring
that the CPU index is stored in a pre-scaled form, and that bits
23 and 24 are zero.  So you can't just drop the old code into
the newer kernel, unless you also change the setup of Context.
A single CPU would work, because 0 == 0, otherwise...
Try nuking those right shifts.

            Regards,

            Kevin K.
 
----- Original Message ----- 
From: "Prasad Boddupalli" <bprasad@cs.arizona.edu>
To: <linux-mips@linux-mips.org>
Sent: Friday, June 02, 2006 8:39 PM
Subject: replacing synthesized tlb handlers with older ones


> Hi,
> 
> To embed some additional functionality in the tlb refill handler, I
> replaced the synthesized refill handlers in 2.6.16 linux with those
> from 2.6.6 (for example tlb-r4k.S under arch/mips/mm-32). Everything
> seem ok when I bring up one CPU, but causes unrecoverable exceptions
> in the kernel when I bring up multiple CPUs. I explored if that could
> be because of unflushed icaches on other CPUs. but that doesn't seem
> to be the case.
> 
> Have anyone run into similar problem ?
> 
> thank you,
> Prasad.
> 
> 
