Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 17:23:28 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:31965 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S3458489AbWBARXI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Feb 2006 17:23:08 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k11HRSEB027413;
	Wed, 1 Feb 2006 09:27:33 -0800 (PST)
Received: from laptopuhler4 ([192.168.2.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k11HRQYr029004;
	Wed, 1 Feb 2006 09:27:27 -0800 (PST)
From:	"Michael Uhler" <uhler@mips.com>
To:	"'Daniel Jacobowitz'" <dan@debian.org>,
	"'Maciej W. Rozycki'" <macro@linux-mips.org>
Cc:	"'Johannes Stezenbach'" <js@linuxtv.org>,
	<linux-mips@linux-mips.org>
Subject: RE: gdb vs. gdbserver with -mips3 / 32bitmode userspace
Date:	Wed, 1 Feb 2006 09:26:57 -0800
Organization: MIPS Technologies, Inc.
Message-ID: <005901c62754$b414dc80$bb14a8c0@MIPS.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20060201164423.GA4891@nevyn.them.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
X-Scanned-By: MIMEDefang 2.39
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

Daniel,

The O/S maybe doing something different, but the architecture has 3 bits in
Status: KX, SX, and UX that enable access to the address space above 32
bits.  With these bits off, an attempt to access these addresses causes an
exception.  So while 32-bit apps have the full 64-bit address space, most of
it is inaccessible to the 32-bit app.

There's a table in Chapter 4 of the MIPS64 Privileged Architecture Spec on
our web page that describes exactly what address references are gated by
what bit.

I notice the original question was about MIPS III.  There were certain early
chips that had problems with access control on the extended segments, so
it's possible that there could be implementation-specific problems.


/gmu
---
Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.   Email: uhler@mips.com
1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
Mountain View, CA 94043   Mobile: (650)868-6870   Admin: (650)567-5085


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Daniel 
> Jacobowitz
> Sent: Wednesday, February 01, 2006 8:44 AM
> To: Maciej W. Rozycki
> Cc: Johannes Stezenbach; linux-mips@linux-mips.org
> Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
> 
> 
> On Tue, Jan 31, 2006 at 05:36:13PM +0000, Maciej W. Rozycki wrote:
> > On Tue, 31 Jan 2006, Johannes Stezenbach wrote:
> > 
> > > I think (maybe in error ;-), that all binaries compiled 
> for a 32bit 
> > > ABI, but a 64bit ISA, have this flag set, as the kernel 
> will refuse 
> > > to execute 64bt code (i.e. not o32 or n32 ABI). 
> Therefore, shouldn't 
> > > gdb also evaluate this flag when deciding about the ISA register 
> > > size?
> > 
> >  O32 implies 32-bit registers no matter what ISA is specified (while
> > o32/MIPS-III is effectively o32/MIPS-II, o32/MIPS-IV makes 
> a difference), 
> > therefore it's a bug.  You should try sending your proposal to 
> > <gdb-patches@sources.redhat.com> instead.  But I smell the 
> problem is 
> > elsewhere -- mips_isa_regsize() shouldn't be called for the 
> "cooked" 
> > registers and these are ones you should only see under 
> Linux or, as a 
> > matter of fact, any hosted environment.  See 
> mips_register_type() for a 
> > start.
> 
> All of this code is flat-out wrong, as far as I'm concerned.  
> I have a project underway which will fix it, as a nice side effect.
> 
> GDB is trying to do something confusing, but admirable, here. 
>  When you're running on a 64-bit system the full 64 bits are 
> always there: even if the binary only uses half of them (is 
> this true in Linux?  I don't remember if the relevant control 
> bits get fudged, it's been a while; it's definitely true on 
> some other systems).  Thus it's possible for a bogus 
> instruction to corrupt the top half of a register, leading to 
> otherwise inexplicable problems.
> 
> So if the remote stub knows about 64-bit registers, it should 
> report them to GDB, and GDB should accept and display them, 
> and still handle 32-bit frames.  If the remote stub doesn't, 
> then there's no option but to report the 32-bit registers.
> 
> Really, GDB ought to (and soon will I hope) autodetect which 
> ones were sent.
> 
> -- 
> Daniel Jacobowitz
> CodeSourcery
> 
> 
