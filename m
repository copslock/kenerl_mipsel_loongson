Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Apr 2012 03:22:40 +0200 (CEST)
Received: from e33.co.us.ibm.com ([32.97.110.151]:60986 "EHLO
        e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903702Ab2DABWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Apr 2012 03:22:35 +0200
Received: from /spool/local
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 31 Mar 2012 19:22:28 -0600
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sat, 31 Mar 2012 19:22:26 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AA9A71FF004A
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 19:22:23 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
        by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q311MNZR144190
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 19:22:24 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q311MMRm022984
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 19:22:23 -0600
Received: from paulmck-ThinkPad-W500 (sig-9-49-152-53.mts.ibm.com [9.49.152.53])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q311ML7p022961;
        Sat, 31 Mar 2012 19:22:22 -0600
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
        id B5E0BE4ABB; Sat, 31 Mar 2012 18:22:12 -0700 (PDT)
Date:   Sat, 31 Mar 2012 18:22:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, jejb@parisc-linux.org, linux390@de.ibm.com,
        x86@kernel.org, cmetcalf@tilera.com
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state        space
Message-ID: <20120401012212.GP2450@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <20120331223200.GA32482@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120331223200.GA32482@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 12040101-2398-0000-0000-0000057BFD9B
X-archive-position: 32849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Mar 31, 2012 at 11:32:00PM +0100, Russell King - ARM Linux wrote:
> On Sun, Apr 01, 2012 at 12:33:21AM +0800, Paul E. McKenney wrote:
> > Although there have been numerous complaints about the complexity of
> > parallel programming (especially over the past 5-10 years), the plain
> > truth is that the incremental complexity of parallel programming over
> > that of sequential programming is not as large as is commonly believed.
> > Despite that you might have heard, the mind-numbing complexity of modern
> > computer systems is not due so much to there being multiple CPUs, but
> > rather to there being any CPUs at all.  In short, for the ultimate in
> > computer-system simplicity, the optimal choice is NR_CPUS=0.
> > 
> > This commit therefore limits kernel builds to zero CPUs.  This change
> > has the beneficial side effect of rendering all kernel bugs harmless.
> > Furthermore, this commit enables additional beneficial changes, for
> > example, the removal of those parts of the kernel that are not needed
> > when there are zero CPUs.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Great work, but I don't think you've gone far enough with this.
> 
> What would really help is if you could consolidate all these NR_CPUS
> definitions into one place so we don't have essentially the same thing
> scattered across all these architectures.  We're already doing this on
> ARM across our platforms, and its about time such an approach was taken
> across the entire kernel tree.
> 
> It looks like the MIPS solution would be the best one to pick.
> Could you rework your patch to do this please?
> 
> While you're at it, you might like to consider that having zero CPUs
> makes all this architecture support redundant, so maybe you've missed
> a trick there - according to my count, we could get rid of almost 3
> million lines of code from arch.  We could replace all that with a
> single standard implementation.
> 
> Bah, maybe I shouldn't have pushed that bpf_jit code for ARM after all...

;-) ;-) ;-)

							Thanx, Paul
