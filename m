Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 20:29:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31514 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992121AbdIOS2yArjc5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Sep 2017 20:28:54 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 8F64187B5F477;
        Fri, 15 Sep 2017 19:28:43 +0100 (IST)
Received: from [10.20.78.38] (10.20.78.38) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 15 Sep 2017
 19:28:46 +0100
Date:   Fri, 15 Sep 2017 19:28:37 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add basic R5900 support
In-Reply-To: <20170915131945.GA32582@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1709151838530.16752@tp.orcam.me.uk>
References: <20170827132309.GA32166@localhost.localdomain> <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk> <20170902102830.GA2602@localhost.localdomain> <alpine.DEB.2.00.1709091022180.4331@tp.orcam.me.uk> <alpine.DEB.2.00.1709110610290.5244@tp.orcam.me.uk>
 <20170912175826.GA2526@localhost.localdomain> <alpine.DEB.2.00.1709151136220.16752@tp.orcam.me.uk> <20170915131945.GA32582@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.20.78.38]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Fredrik,

> >  I wonder if FS=1 hardwired also means the Underflow exception cannot 
> > happen.  As the corresponding Cause and Enable bits cannot be set together 
> > or an FPE exception will happen right away, and the Unimplemented 
> > Operation exception is uncoditional so we need to leave it out, can you 
> > please also try these masks in turns:
> > 
> > 	      " li   %1,0x0001f07c\n"
> > 
> > and:
> > 
> > 	      " li   %1,0x00000f80\n"
> > 
> > This will reveal if any of the Cause, Enable or Flag bits are hardwired.
> 
> The result is:
> 
> 	FCSR 0x0001f07c old: 01000001, new: 0101c079
> 	FCSR 0x00000f80 old: 01000001, new: 01000001

 This looks unusual and inconsistent in that only V, Z and O Cause bits 
appear settable, these and also I Flag bits do and no Enable bits do.  
Given Jürgen's observations in the discussion you referred to below I 
would expect the I Flag bit not to be settable either; perhaps it's a 
hardware erratum.

> I was looking for information on GCC for R5900 and found
> 
> https://gcc.gnu.org/ml/gcc-patches/2013-01/msg00658.html
> 
> where you and Jürgen Urban discuss this topic. Jürgen cites some FPU details
> from the Emotion Engine core user's manual that is very helpful, in addition
> to mentioning TX79 differences.

 Thanks for the reference, I did remember I had the discussion, but didn't 
recall the details, although I had a vague recollection about instruction 
encoding differences.

 Given the situation I think we'll have to stick with full FPU emulation 
for regular MIPS/Linux user programs, and then possibly have an ELF ABI 
flag of sorts to mark software requesting running in the R5900 hard-float 
mode (which obviously won't be able to use standard `libm', etc.); we can 
think of doing it in a way to keep binary compatibility with exiting PS2 
software, should this be a concern.

 Tasks run in the R5900 hard-float mode would then have our FPU emulator 
strapped for pass-through operation, i.e. the CpU exception and context 
switching would work normally, however any FPE exception, given the 
findings above about FCSR possibly including Unimplemented Operation only, 
would just throw SIGFPE, letting the userland handle it if desired.  
You'd need a new `si_code' of course for Unimplemented Operation; or maybe 
not even that, because as vague as Jürgen's notes are they seem to suggest 
the R5900 may not actually trap with FPE ever.

 This also means you only want FPU_CSR_CONDX in `c->fpu_msk31' (for the 
full FPU emulation) as with an ordinary MIPS III processor.

 NB, I think the issue with RDHWR emulation to access CP0.UserLocal 
mentioned in the discussion referred will have to be addressed with the 
initial submission as well.

  Maciej
