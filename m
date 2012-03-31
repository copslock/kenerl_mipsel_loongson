Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Apr 2012 00:34:37 +0200 (CEST)
Received: from e39.co.us.ibm.com ([32.97.110.160]:49237 "EHLO
        e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903631Ab2CaWec (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Apr 2012 00:34:32 +0200
Received: from /spool/local
        by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 31 Mar 2012 16:34:24 -0600
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
        by e39.co.us.ibm.com (192.168.1.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sat, 31 Mar 2012 16:34:21 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
        by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9B55719D8048
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 16:34:13 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
        by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2VMYLDs187470
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 16:34:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2VMYJBL024491
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 16:34:21 -0600
Received: from paulmck-ThinkPad-W500 (sig-9-49-152-53.mts.ibm.com [9.49.152.53])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q2VMYIOw024480;
        Sat, 31 Mar 2012 16:34:18 -0600
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
        id 69335E4ABB; Sat, 31 Mar 2012 15:34:09 -0700 (PDT)
Date:   Sat, 31 Mar 2012 15:34:09 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Lorenz Kolb <linuxppcemb@lkmail.de>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        dhowells@redhat.com, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-am33-list@redhat.com,
        linux@arm.linux.org.uk, linux-hexagon@vger.kernel.org,
        x86@kernel.org, jejb@parisc-linux.org, cmetcalf@tilera.com,
        uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux390@de.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Message-ID: <20120331223409.GM2450@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <1333227608.2325.4054.camel@edumazet-glaptop>
 <20120331212149.GI2450@linux.vnet.ibm.com>
 <4F7782ED.7050407@lkmail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F7782ED.7050407@lkmail.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 12033122-4242-0000-0000-000001369589
X-archive-position: 32848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Apr 01, 2012 at 12:19:25AM +0200, Lorenz Kolb wrote:
> With that patchset in mind, I am working on a really huge patch,
> which will greatly simplify the Linux kernel  for the real problem
> of having that number of CPUs.
> 
> That patch will have a lot of changes all over the architectures, so
> what will be the best way to post it? Should I split it architecture
> dependend and into one generic part.
> 
> Currently it is a large blob of millions of changes, but will
> greatly simplify the Linux kernel.

Perhaps a branch on a public git tree?  If you are doing what I suspect
you are, you will end up with a very large patch set.  ;-)

							Thanx, Paul

> Regards,
> 
> Lorenz Kolb
> 
> Am 31.03.2012 23:21, schrieb Paul E. McKenney:
> >On Sat, Mar 31, 2012 at 11:00:08PM +0200, Eric Dumazet wrote:
> >>On Sun, 2012-04-01 at 00:33 +0800, Paul E. McKenney wrote:
> >>>Although there have been numerous complaints about the complexity of
> >>>parallel programming (especially over the past 5-10 years), the plain
> >>>truth is that the incremental complexity of parallel programming over
> >>>that of sequential programming is not as large as is commonly believed.
> >>>Despite that you might have heard, the mind-numbing complexity of modern
> >>>computer systems is not due so much to there being multiple CPUs, but
> >>>rather to there being any CPUs at all.  In short, for the ultimate in
> >>>computer-system simplicity, the optimal choice is NR_CPUS=0.
> >>>
> >>>This commit therefore limits kernel builds to zero CPUs.  This change
> >>>has the beneficial side effect of rendering all kernel bugs harmless.
> >>>Furthermore, this commit enables additional beneficial changes, for
> >>>example, the removal of those parts of the kernel that are not needed
> >>>when there are zero CPUs.
> >>>
> >>>Signed-off-by: Paul E. McKenney<paulmck@linux.vnet.ibm.com>
> >>>Reviewed-by: Thomas Gleixner<tglx@linutronix.de>
> >>>---
> >>Hmm... I believe you could go one step forward and allow negative values
> >>as well. Antimatter was proven to exist after all.
> >>
> >>Hint : nr_cpu_ids is an "int", not an "unsigned int"
> >>
> >>Bonus: Existing bugs become "must have" features.
> >;-) ;-) ;-)
> >
> >>Of course there is no hurry and this can wait 365 days.
> >James Bottomley suggested imaginary numbers of CPUs some time back,
> >and I suppose there is no reason you cannot have fractional numbers of
> >CPUs, and perhaps irrational numbers as well.  Of course, these last two
> >would require use of floating-point arithmetic (or something similar)
> >in the kernel.  So I guess we have at several years worth.  Over to you
> >for the negative numbers.  ;-)
> >
> >							Thanx, Paul
> >
> >_______________________________________________
> >Linuxppc-dev mailing list
> >Linuxppc-dev@lists.ozlabs.org
> >https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
