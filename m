Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 17:51:22 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:58627 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012635AbbHFPvUTR017 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 17:51:20 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZNNRv-00032N-Bl; Thu, 06 Aug 2015 15:51:19 +0000
Message-ID: <1438876276.12629.5.camel@fourier>
Subject: Re: [3.19.y-ckt stable] Patch "MIPS: kernel: cps-vec: Replace
 mips32r2 ISA level with mips64r2" has been added to staging queue
From:   Kamal Mostafa <kamal@canonical.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        kernel-team@lists.ubuntu.com
Date:   Thu, 06 Aug 2015 08:51:16 -0700
In-Reply-To: <20150805224934.GE2057@NP-P-BURTON>
References: <1438811234-29408-1-git-send-email-kamal@canonical.com>
         <20150805224934.GE2057@NP-P-BURTON>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

On Wed, 2015-08-05 at 15:49 -0700, Paul Burton wrote:
> On Wed, Aug 05, 2015 at 02:47:14PM -0700, Kamal Mostafa wrote:
> > This is a note to let you know that I have just added a patch titled
> >     MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
> > to the linux-3.19.y-queue 

> Hi Kamal,
> 
> This patch breaks the boot of SMP kernels on Imagination's current
> MIPS32 systems. This & the other MIPS64 related patches that were
> submitted as part of the same series do not improve things for any CPUs
> that Linux supports even as of the v4.2 cycle, so I do not believe they
> should have been marked for backport.
> 
> So please either drop this patch (& preferrably the other MIPS64 CPS SMP
> ones too)


Hi Paul-

Thanks for the heads-up!  Please confirm that these are the specific
commits to be dropped / not-applied to stable:

b677bc0 MIPS: cps-vec: Use macros for various arithmetics and memory operations
717f142 MIPS: kernel: cps-vec: Replace KSEG0 with CKSEG0
0586ac7 MIPS: kernel: cps-vec: Use ta0-ta3 pseudo-registers for 64-bit
977e043 MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
81a02e3 MIPS: kernel: cps-vec: Replace 'la' macro with PTR_LA
fd5ed30 MIPS: kernel: smp-cps: Fix 64-bit compatibility errors due to pointer casting

 -Kamal


>  or also backport the series I've just submitted:
> 
>     http://marc.info/?l=linux-mips&m=143881461431570&w=2
> 
> My preference would be for not backporting any of them.
> 
> Thanks,
>     Paul
> 
> > For more information about the 3.19.y-ckt tree, see
> > https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable
> > 
> > Thanks.
> > -Kamal
> > 
> > ------
> > 
> > From 22a7e30c46134b8c9978a237c6d143b59b66609a Mon Sep 17 00:00:00 2001
> > From: Markos Chandras <markos.chandras@imgtec.com>
> > Date: Wed, 1 Jul 2015 09:13:30 +0100
> > Subject: MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
> > 
> > commit 977e043d5ea1270ce985e4c165724ff91dc3c3e2 upstream.
> > 
> > mips32r2 is a subset of mips64r2, so we replace mips32r2 with mips64r2
> > in preparation for 64-bit CPS support.
> > 
> > Reviewed-by: Paul Burton <paul.burton@imgtec.com>
> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > Cc: linux-mips@linux-mips.org
> > Patchwork: https://patchwork.linux-mips.org/patch/10588/
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> > ---
> >  arch/mips/kernel/cps-vec.S | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
> > index a4b2d81..bbbd88e 100644
> > --- a/arch/mips/kernel/cps-vec.S
> > +++ b/arch/mips/kernel/cps-vec.S
> > @@ -229,7 +229,7 @@ LEAF(mips_cps_core_init)
> >  	 nop
> > 
> >  	.set	push
> > -	.set	mips32r2
> > +	.set	mips64r2
> >  	.set	mt
> > 
> >  	/* Only allow 1 TC per VPE to execute... */
> > @@ -346,7 +346,7 @@ LEAF(mips_cps_boot_vpes)
> >  	 nop
> > 
> >  	.set	push
> > -	.set	mips32r2
> > +	.set	mips64r2
> >  	.set	mt
> > 
> >  1:	/* Enter VPE configuration state */
> > --
> > 1.9.1
> > 
> 
