Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Apr 2012 20:11:41 +0200 (CEST)
Received: from e39.co.us.ibm.com ([32.97.110.160]:51223 "EHLO
        e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903724Ab2DASLg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Apr 2012 20:11:36 +0200
Received: from /spool/local
        by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 1 Apr 2012 12:11:29 -0600
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
        by e39.co.us.ibm.com (192.168.1.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sun, 1 Apr 2012 12:11:27 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
        by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 64DC819D8048
        for <linux-mips@linux-mips.org>; Sun,  1 Apr 2012 12:11:19 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
        by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q31IBR0n189660
        for <linux-mips@linux-mips.org>; Sun, 1 Apr 2012 12:11:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q31IBPGX024210
        for <linux-mips@linux-mips.org>; Sun, 1 Apr 2012 12:11:26 -0600
Received: from paulmck-ThinkPad-W500 (sig-9-49-152-53.mts.ibm.com [9.49.152.53])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q31IBO59024187;
        Sun, 1 Apr 2012 12:11:25 -0600
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
        id 0E3C3E4ABB; Sun,  1 Apr 2012 11:11:15 -0700 (PDT)
Date:   Sun, 1 Apr 2012 11:11:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
Message-ID: <20120401181114.GY2450@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <20120401100448.GD14848@liondog.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120401100448.GD14848@liondog.tnic>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 12040118-4242-0000-0000-00000137C7FF
X-archive-position: 32854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Apr 01, 2012 at 12:04:48PM +0200, Borislav Petkov wrote:
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
> Looks good, thanks for doing that.
> 
> Btw, I just got confirmation from hw folk that we can actually give you
> hardware support for that code with an upcoming CPU which has NR_CPUS=0
> cores.
> 
> Oh, and additionally, we can disable some of those so getting into the
> negative is also doable from the hw perspective, so feel free to explore
> that side of the problem too.
> 
> ACK.

Cute!  ;-)

							Thanx, Paul
