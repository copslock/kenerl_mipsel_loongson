Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 20:48:05 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43918 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492723Ab0EFSr6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 May 2010 20:47:58 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o46IlrIj022536;
        Thu, 6 May 2010 19:47:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o46IlpPB022525;
        Thu, 6 May 2010 19:47:51 +0100
Date:   Thu, 6 May 2010 19:47:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shane McDonald <mcdonald.shane@gmail.com>
Cc:     "Kevin D. Kissell" <kevink@paralogos.com>,
        Sergei Shtylyov <sshtylyov@mvista.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable by
 ctc1
Message-ID: <20100506184751.GF28066@linux-mips.org>
References: <4BE122D1.3000609@paralogos.com>
 <20100505091159.GA4016@linux-mips.org>
 <4BE19214.4010209@paralogos.com>
 <20100506.012240.118951273.anemo@mba.ocn.ne.jp>
 <4BE1C4EA.1020202@paralogos.com>
 <4BE2A6EE.80705@mvista.com>
 <4BE2E445.5050809@paralogos.com>
 <o2yb2b2f2321005061142v431dbc78n2a21722676a72501@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o2yb2b2f2321005061142v431dbc78n2a21722676a72501@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 06, 2010 at 12:42:35PM -0600, Shane McDonald wrote:
> Date:   Thu, 6 May 2010 12:42:35 -0600
> From: Shane McDonald <mcdonald.shane@gmail.com>
> To: "Kevin D. Kissell" <kevink@paralogos.com>
> Cc: Sergei Shtylyov <sshtylyov@mvista.com>,
> 	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
> 	linux-mips@linux-mips.org
> Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable
>  by
>         ctc1
> Content-Type: text/plain; charset=ISO-8859-1
> 
> On Thu, May 6, 2010 at 9:46 AM, Kevin D. Kissell <kevink@paralogos.com> wrote:
> > Sergei Shtylyov wrote:
> >> Kevin D. Kissell wrote:
> >>
> >>> I'm cool with the patch as is, but in the general spirit of regarding
> >>> numeric constants other than 0 and 1 as instruments of Satan, it
> >>> would probably be even better if those reserved bits were defined
> >>> (FPU_CSR_RSVD, or whatever is compatible with existing convention for
> >>> such bits) along with the other FCSR bit masks in mipsregs.h, so that
> >>> the assigment looks like:
> >>>
> >>>          ctx->fcr31 = (value & ~(FPU_CSR_RSVD | 0x3)) |
> >>>                   ieee_rm[value & 0x3];
> >>
> >>   0x3 is still neither 0 nor 1, and so remains an instrument of Satan.
> >> How about #defining it also? :-)
> >
> > In some software engineering cultures, that would be considered a good
> > idea or even mandatory.  This being the Linux kernel, I think it's OK,
> > because, as Shane remarked, it's a mask that's local to the module and
> > whose value is "obvious", and such things are pretty commonly handled as
> > numeric constants in the kernel.
> >
> > There actually *is* a #define for that field, FPU_CSR_RD, which could be
> > used here in place of the 0x3, but I'm a little torn about its use.  On
> > one hand "value & ~(FPU_CSR_RSVD | FPU_CSR_RD)" is more clear about what
> > we're doing, but on the other hand, it's less obvious that "value &
> > FPU_CSR_RD" is generating an integer in the range 0-3 for an index.  So
> > I'm absolutely fine with the code as written, but wouldn't complain if
> > someone wanted to make it use the symbolic constant.
> 
> I'm torn here, which is why I hadn't changed that at all.  I'd rather not
> use FPU_CSR_RD, because that defines a value in the rounding mode
> bits (which happens to have all the bits set), rather than a mask for the
> bits.  I'd prefer to define a new constant FPU_CSR_RM with the
> value 0x00000003 -- a better name might be FPU_CSR_RM_MASK,
> but that's inconsistent with the names of the other FCSR fields.
> And, as Kevin said, it doesn't make it clear that we're trying to generate
> an index in the range of 0 - 3.  I guess we could also define a constant
> for the number of bits to shift to get the RM bits into the low order bits,
> something like
> 
> #define FPU_CSR_RM_SHIFT 0
> 
> at which point our code could look like
> 
> ctx->fcr31 = (value & ~(FPU_CSR_RSVD | FPU_CSR_RM)) |
>                    ieee_rm[(value & FPU_CSR_RM) >> FPU_CSR_RM_SHIFT];
> 
> I'm a little wary of adding the FPU_CSR_RM_SHIFT, because there aren't
> any other SHIFT defines for the FCSR, and because the shift value is 0.
> But, the above code doesn't look as bad as I originally thought it would,
> and it probably is clearer.
> 
> Comments?
> 
> There's also use of the 0x3 magic number in a number of other cases
> in this file.  Do I make a similar change to those cases in this patch,
> or should I create a separate patch for that?  Or would that just be
> one of those minor style change patches that no one likes?

I'd certainly consider it.  It's logically a separate change so I'd
suggest a separate patch for -queue.  Your earlier patch is 2.6.34 and
-stable material however and that's another reason why this should be
separate patches.

  Ralf
