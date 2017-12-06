Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2017 18:42:50 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:60138 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLFRmk2jtN9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2017 18:42:40 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 06 Dec 2017 17:42:34 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Wed, 6 Dec 2017 09:42:15 -0800
Date:   Wed, 6 Dec 2017 09:43:01 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: CM: Drop WARN_ON(vp != 0)
Message-ID: <20171206174301.oup2hcxrbm72s34x@pburton-laptop>
References: <20171205222822.15034-1-james.hogan@mips.com>
 <20171206135745.GD5238@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171206135745.GD5238@linux-mips.org>
User-Agent: NeoMutt/20171013
X-BESS-ID: 1512582152-298552-12292-8028-7
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187685
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Ralf,

On Wed, Dec 06, 2017 at 02:57:45PM +0100, Ralf Baechle wrote:
> On Tue, Dec 05, 2017 at 10:28:22PM +0000, James Hogan wrote:
> 
> > Since commit 68923cdc2eb3 ("MIPS: CM: Add cluster & block args to
> > mips_cm_lock_other()"), mips_smp_send_ipi_mask() has used
> > mips_cm_lock_other_cpu() with each CPU number, rather than
> > mips_cm_lock_other() with the first VPE in each core. Prior to r6,
> > multicore multithreaded systems such as dual-core dual-thread
> > interAptivs with CPU Idle enabled (e.g. MIPS Creator Ci40) results in
> > mips_cm_lock_other() repeatedly hitting WARN_ON(vp != 0).
> > 
> > There doesn't appear to be anything fundamentally wrong about passing a
> > non-zero VP/VPE number, even if it is a core's region that is locked
> > into the other region before r6, so remove that particular WARN_ON().
> > 
> > Fixes: 68923cdc2eb3 ("MIPS: CM: Add cluster & block args to mips_cm_lock_other()")
> > Signed-off-by: James Hogan <jhogan@kernel.org>
> > Reviewed-by: Paul Burton <paul.burton@mips.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: <stable@vger.kernel.org> # 4.14+
> > ---
> >  arch/mips/kernel/mips-cm.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
> > index dd5567b1e305..8f5bd04f320a 100644
> > --- a/arch/mips/kernel/mips-cm.c
> > +++ b/arch/mips/kernel/mips-cm.c
> > @@ -292,7 +292,6 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
> >  				  *this_cpu_ptr(&cm_core_lock_flags));
> >  	} else {
> >  		WARN_ON(cluster != 0);
> > -		WARN_ON(vp != 0);
> 
> I think the reason is that for a while the combination of SMP/CMP with
> MT was at the bottom of priorities and nobody really cared about it so
> a WARN_ON was thrown in.  Which in this case might well itself be a bug!
> 
>   Ralf

Well, the WARN_ON came about because:

 - Originally mips_cm_lock_other() had no VP argument, because the CM
   "other" register in CM < 3 has no VP field. ie. the CM "other" region
   always accesses registers associated with a core rather than a VP(E).

 - With CM >= 3 the "other" register (renamed "redirect") gained a VP
   field & the ability to control the CPC & GIC redirect regions, which
   were formerly controlled by separate "other" registers in the CPC &
   GIC register interfaces. In the GIC case the other/redirect region
   actually targets a VP, not a core.

 - Since the CM < 3 other register has no VP field the WARN_ON made
   sense - if code is actually trying to access registers associated
   with a particular VP then that's a bug because that's simply not
   possible. The warning called out those cases by requiring CM < 3
   paths to explicitly pass VP=0.

That was all well & good until I added the mips_cm_lock_other_cpu()
wrapper for convenience. It passes the CPUs cluster, core & VP(E)
numbers to mips_cm_lock_other() which is problematic if it's used in
paths that may run on CM < 3. There is only one such case right now, in
mips_smp_send_ipi_mask() when powering up a CPU in a non-coherent idle
state. So effectively you have to have the CPS cpuidle driver enabled to
hit this.

A potential alternative to this patch would be to have
mips_cm_lock_other_cpu() check the CM version & use VP=0 for CM < 3, but
I think the utility of that is questionable so dropping the WARN_ON as
James has done seems reasonable.

We actually do test mainline, mips-for-linux-next & our internal kernel
branches a bunch on affected systems, most notably interAptiv in the
context of either the Boston or Ci40 platforms. Unfortunately that
didn't catch the bug here because the cpuidle driver isn't enabled in
the kernel configs that our CI system builds. That's something we'll
change. If that weren't the case then we ought to have caught this once
it hit -next. The patchset for multi-cluster support has also shrunk
quite a lot with the merging of the initial set, so our internal
branches are now closer to what will next be submitted which also helps
since we might spot issues even earlier in tests of those internal
branches.

Having the mips-for-linux-next branch updated regularly throughout the
cycle would help immensely in giving us the best chance of catching bugs
like this in a timely fashion, since when it all happens right before
the merge window we don't get much testing time on the code actually
hitting mainline until after it has gone in.

Anyway, hopefully that post-mortem shines some light on what went wrong
here!

Thanks,
    Paul
