Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 18:03:06 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:34393 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007992AbbCTRDEUkP4K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 18:03:04 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1YZ0K5-0002Qd-Uk; Fri, 20 Mar 2015 17:03:02 +0000
Message-ID: <1426870978.13401.7.camel@fourier>
Subject: Re: [PATCH 3.13.y-ckt 71/80] MIPS: Fix C0_Pagegrain[IEC] support.
From:   Kamal Mostafa <kamal@canonical.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com, David Daney <david.daney@cavium.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Date:   Fri, 20 Mar 2015 10:02:58 -0700
In-Reply-To: <550B575D.8090908@caviumnetworks.com>
References: <1426804568-2907-1-git-send-email-kamal@canonical.com>
         <1426804568-2907-72-git-send-email-kamal@canonical.com>
         <550B575D.8090908@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46482
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

On Thu, 2015-03-19 at 16:10 -0700, David Daney wrote:
> On 03/19/2015 03:35 PM, Kamal Mostafa wrote:
> > 3.13.11-ckt17 -stable review patch.  If anyone has any objections, please let me know.
> >
> 
> Read the patch commentary.  It should only be applied to 3.17 and later.
> 
> So:  NACK.
> 

Thanks very much for reviewing this, David.  Dropped from 3.13-stable.

Also FYI, if you append e.g. "# 3.17+" to your Cc: stable line, that
will help the stable maintainers (more specifically, will help our
automated tools ;-) recognize where the patch should and shouldn't be
applied.  Example:

    Cc: <stable@vger.kernel.org> # 3.17+

 -Kamal


> > ------------------
> >
> > From: David Daney <david.daney@cavium.com>
> >
> > commit 9ead8632bbf454cfc709b6205dc9cd8582fb0d64 upstream.
> >
> > The following commits:
> >
> >    5890f70f15c52d (MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions)
> >    6575b1d4173eae (MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions)
> >
> > break the kernel for *all* existing MIPS CPUs that implement the
> > CP0_PageGrain[IEC] bit.  They cause the TLB exception handlers to be
> > generated without the legacy execute-inhibit handling, but never set
> > the CP0_PageGrain[IEC] bit to activate the use of dedicated exception
> > vectors for execute-inhibit exceptions.  The result is that upon
> > detection of an execute-inhibit violation, we loop forever in the TLB
> > exception handlers instead of sending SIGSEGV to the task.
> >
> > If we are generating TLB exception handlers expecting separate
> > vectors, we must also enable the CP0_PageGrain[IEC] feature.
> >
> > The bug was introduced in kernel version 3.17.
> >
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> > Cc: linux-mips@linux-mips.org
> > Patchwork: http://patchwork.linux-mips.org/patch/8880/
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> > ---
> >   arch/mips/mm/tlb-r4k.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> > index da3b0b9..d04fe4e 100644
> > --- a/arch/mips/mm/tlb-r4k.c
> > +++ b/arch/mips/mm/tlb-r4k.c
> > @@ -429,6 +429,8 @@ void tlb_init(void)
> >   #ifdef CONFIG_64BIT
> >   		pg |= PG_ELPA;
> >   #endif
> > +		if (cpu_has_rixiex)
> > +			pg |= PG_IEC;
> >   		write_c0_pagegrain(pg);
> >   	}
> >
> >
> 
