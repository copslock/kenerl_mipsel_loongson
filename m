Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 13:52:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48794 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028929AbcEKLwNJszKY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 13:52:13 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id C3F827A53D155;
        Wed, 11 May 2016 12:52:02 +0100 (IST)
Received: from [10.20.78.170] (10.20.78.170) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Wed, 11 May 2016
 12:52:04 +0100
Date:   Wed, 11 May 2016 12:51:56 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@caviumnetworks.com>,
        LMO <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Fix type and FCSR mask.
In-Reply-To: <20160511114117.GK16402@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1605111244280.6794@tp.orcam.me.uk>
References: <57322408.5060702@caviumnetworks.com> <alpine.DEB.2.00.1605111200200.6794@tp.orcam.me.uk> <20160511114117.GK16402@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.170]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53361
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

On Wed, 11 May 2016, Ralf Baechle wrote:

> >  This change is broken, see the description of commit 9b26616c8d9d ("MIPS: 
> > Respect the ISA level in FCSR handling") where this code comes from.  The 
> > very purpose is to probe for the writability of bits 31:18, in particular 
> > NAN2008 and ABS2008 stuff, but it applies to vendor bits too.  An accurate 
> > identification of writable bits is required for the correct presentation 
> > of FCSR via ptrace(2) for programs like GDB.
> > 
> >  You need to fix your simulator instead, the architecture does not permit 
> > trapping on optional FCSR bits (there are no reserved bits there anymore 
> > with the current architecture revision) especially as access to this 
> > register is unprivileged.  I don't think we can support arbitrary 
> > non-compliant architecture implementations -- if you need to handle an 
> > erratum, then please do it on a PRId by PRId basis.
> > 
> >  As to changing the data type, I'm fine in principle, but then please do 
> > so across all our source base where CP1 control registers are handled.  
> > Here the `long' type is used for consistency with the rest of code, so 
> > changing just this single place seems gratuitous to me.
> > 
> >  Ralf, please discard this change until it has been corrected.
> 
> Using a 32 bit variable made sufficient sense to me to apply the patch
> to me.  However I agree, that the simulator's behaviour is overzealous.
> While in violation of the architecture specification this is probably
> similar in spirit as the mode of MIPSsim that was keeping every bit of
> the system as a tristate (0, 1 and uninitialized) which indeed cought a
> number of issues.

 The fundamental problem here is this functional change:

> @@ -87,7 +87,7 @@ static inline void cpu_set_fpu_fcsr_mask(struct cpuinfo_mips
> *c)
>  	write_32bit_cp1_register(CP1_STATUS, fcsr0);
>  	fcsr0 = read_32bit_cp1_register(CP1_STATUS);
>  
> -	fcsr1 = fcsr | ~mask;
> +	fcsr1 = fcsr | (FPU_CSR_COND | FPU_CSR_FS | FPU_CSR_CONDX);
>  	write_32bit_cp1_register(CP1_STATUS, fcsr1);
>  	fcsr1 = read_32bit_cp1_register(CP1_STATUS);
>  

which largely defeats the original commit referred above and certainly 
regresses 2008-NaN support.  And then any type cleanup (which is syntactic 
sugar really anyway, which however I'm absolutely fine with if not 
enthusiastic as long as applied consistently) should be made as a separate 
patch, not along a functional change.

  Maciej
