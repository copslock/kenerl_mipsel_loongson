Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Mar 2012 23:23:18 +0200 (CEST)
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46555 "EHLO e1.ny.us.ibm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903702Ab2CaVXG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 31 Mar 2012 23:23:06 +0200
Received: from /spool/local
        by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 31 Mar 2012 17:23:00 -0400
Received: from d01dlp01.pok.ibm.com (9.56.224.56)
        by e1.ny.us.ibm.com (192.168.1.101) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sat, 31 Mar 2012 17:22:02 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
        by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 28E1238C8054
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 17:22:01 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
        by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2VLM0WN341192
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 17:22:01 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2VLLxvj015851
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 15:22:00 -0600
Received: from paulmck-ThinkPad-W500 (sig-9-49-152-53.mts.ibm.com [9.49.152.53])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q2VLLwuW015844;
        Sat, 31 Mar 2012 15:21:58 -0600
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
        id 235E9E4ABB; Sat, 31 Mar 2012 14:21:49 -0700 (PDT)
Date:   Sat, 31 Mar 2012 14:21:49 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tglx@linutronix.de,
        linux@arm.linux.org.uk, dhowells@redhat.com, jejb@parisc-linux.org,
        linux390@de.ibm.com, x86@kernel.org, cmetcalf@tilera.com
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Message-ID: <20120331212149.GI2450@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <1333227608.2325.4054.camel@edumazet-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1333227608.2325.4054.camel@edumazet-glaptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 12033121-6078-0000-0000-0000099B4817
X-archive-position: 32845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Mar 31, 2012 at 11:00:08PM +0200, Eric Dumazet wrote:
> On Sun, 2012-04-01 at 00:33 +0800, Paul E. McKenney wrote:
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
> > ---
> 
> Hmm... I believe you could go one step forward and allow negative values
> as well. Antimatter was proven to exist after all.
> 
> Hint : nr_cpu_ids is an "int", not an "unsigned int"
> 
> Bonus: Existing bugs become "must have" features.

;-) ;-) ;-)

> Of course there is no hurry and this can wait 365 days.

James Bottomley suggested imaginary numbers of CPUs some time back,
and I suppose there is no reason you cannot have fractional numbers of
CPUs, and perhaps irrational numbers as well.  Of course, these last two
would require use of floating-point arithmetic (or something similar)
in the kernel.  So I guess we have at several years worth.  Over to you
for the negative numbers.  ;-)

							Thanx, Paul
