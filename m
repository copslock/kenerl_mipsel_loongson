Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Apr 2012 00:33:44 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53973 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903631Ab2CaWdk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Apr 2012 00:33:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=hBaV9W9sNKgUd6Ul4Hvq0QZAqdOZdWtEgmbnoBVlZcw=;
        b=Lbb3zPOt5jMZjSnpH/K+UAXPqkdbREsb8ISmC+5PTT2USoyX4S1oxGhAe0gLBDnMjhwkNH2KAtpt8ykrgT5IhiAjNkfnF/DeFQEahPDGAHP0sY1c1aJqW3qkTs4gubrUdWkjWHETR60lirSRKyTk+8GWM+BnvW1kTSkJYDU49mg=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:45501)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1SE6q2-0006nQ-SJ; Sat, 31 Mar 2012 23:32:03 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1SE6q1-0003L5-7f; Sat, 31 Mar 2012 23:32:01 +0100
Date:   Sat, 31 Mar 2012 23:32:00 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
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
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state
        space
Message-ID: <20120331223200.GA32482@n2100.arm.linux.org.uk>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120331163321.GA15809@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 32847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Apr 01, 2012 at 12:33:21AM +0800, Paul E. McKenney wrote:
> Although there have been numerous complaints about the complexity of
> parallel programming (especially over the past 5-10 years), the plain
> truth is that the incremental complexity of parallel programming over
> that of sequential programming is not as large as is commonly believed.
> Despite that you might have heard, the mind-numbing complexity of modern
> computer systems is not due so much to there being multiple CPUs, but
> rather to there being any CPUs at all.  In short, for the ultimate in
> computer-system simplicity, the optimal choice is NR_CPUS=0.
> 
> This commit therefore limits kernel builds to zero CPUs.  This change
> has the beneficial side effect of rendering all kernel bugs harmless.
> Furthermore, this commit enables additional beneficial changes, for
> example, the removal of those parts of the kernel that are not needed
> when there are zero CPUs.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Great work, but I don't think you've gone far enough with this.

What would really help is if you could consolidate all these NR_CPUS
definitions into one place so we don't have essentially the same thing
scattered across all these architectures.  We're already doing this on
ARM across our platforms, and its about time such an approach was taken
across the entire kernel tree.

It looks like the MIPS solution would be the best one to pick.
Could you rework your patch to do this please?

While you're at it, you might like to consider that having zero CPUs
makes all this architecture support redundant, so maybe you've missed
a trick there - according to my count, we could get rid of almost 3
million lines of code from arch.  We could replace all that with a
single standard implementation.

Bah, maybe I shouldn't have pushed that bpf_jit code for ARM after all...
