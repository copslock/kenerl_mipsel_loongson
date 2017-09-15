Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 13:13:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14801 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991445AbdIOLMx7OTKu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Sep 2017 13:12:53 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1862BE89B0823;
        Fri, 15 Sep 2017 12:12:44 +0100 (IST)
Received: from [10.20.78.38] (10.20.78.38) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 15 Sep 2017
 12:12:45 +0100
Date:   Fri, 15 Sep 2017 12:12:37 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add basic R5900 support
In-Reply-To: <20170912175826.GA2526@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1709151136220.16752@tp.orcam.me.uk>
References: <20170827132309.GA32166@localhost.localdomain> <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk> <20170902102830.GA2602@localhost.localdomain> <alpine.DEB.2.00.1709091022180.4331@tp.orcam.me.uk> <alpine.DEB.2.00.1709110610290.5244@tp.orcam.me.uk>
 <20170912175826.GA2526@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.38]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60008
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

> > >  Can you please try flipping the bits instead then, e.g.:
> > > 
> > > 	uint32_t fcsr0, fcsr1;
> > > 	asm volatile (" cfc1 %0,$31\n"
> > > 		      " lui  %1,0xfffc\n"
> > 
> >  Actually can you please substitute:
> > 
> > 		      " li   %1,0xfffc0003\n"
> > 
> > here, so that we know how RM behaves?
> 
> Sure. I get "FCSR old: 01000001, new: 01800001" with the R5900.

 Thanks, that is as I suspected then.

 I wonder if FS=1 hardwired also means the Underflow exception cannot 
happen.  As the corresponding Cause and Enable bits cannot be set together 
or an FPE exception will happen right away, and the Unimplemented 
Operation exception is uncoditional so we need to leave it out, can you 
please also try these masks in turns:

	      " li   %1,0x0001f07c\n"

and:

	      " li   %1,0x00000f80\n"

This will reveal if any of the Cause, Enable or Flag bits are hardwired.

> >  Again, it is odd to see it set to 1 (towards zero) by default and if it 
> > is hardwired, then `->fpu_csr31' and `->fpu_msk31' will have to be 
> > updated, AT_FPUCW exported and glibc adjusted.
> 
> Right. Quite a few details to resolve for the FPU then. Here is the
> disassembly to double-check the compiled code:

 Nothing unusual here.  As you can see GCC has been smart enough to 
schedule temporaries right in argument registers passed to the `printf' 
call. :)

  Maciej
