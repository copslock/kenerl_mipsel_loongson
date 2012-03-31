Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Mar 2012 18:55:06 +0200 (CEST)
Received: from e37.co.us.ibm.com ([32.97.110.158]:59807 "EHLO
        e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903628Ab2CaQzB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Mar 2012 18:55:01 +0200
Received: from /spool/local
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 31 Mar 2012 10:54:54 -0600
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
        by e37.co.us.ibm.com (192.168.1.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sat, 31 Mar 2012 10:54:13 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
        by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4265F19D8048
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 10:54:05 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
        by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2VGsCiu162558
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 10:54:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2VGsBSI008773
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 10:54:12 -0600
Received: from paulmck-ThinkPad-W500 (sig-9-49-152-53.mts.ibm.com [9.49.152.53])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q2VGsANj008727;
        Sat, 31 Mar 2012 10:54:10 -0600
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
        id 73E33E4ABB; Sat, 31 Mar 2012 09:54:01 -0700 (PDT)
Date:   Sat, 31 Mar 2012 09:54:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
        linux390@de.ibm.com, x86@kernel.org, cmetcalf@tilera.com,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Message-ID: <20120331165401.GD2450@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <CAMuHMdWTB+_AtqM6JixY=Oo_zmzX_dNxnivpARBYSbPJzp4t6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWTB+_AtqM6JixY=Oo_zmzX_dNxnivpARBYSbPJzp4t6A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 12033116-7408-0000-0000-000003DE13A8
X-archive-position: 32838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Mar 31, 2012 at 06:40:30PM +0200, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Sat, Mar 31, 2012 at 18:33, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > Although there have been numerous complaints about the complexity of
> > parallel programming (especially over the past 5-10 years), the plain
> > truth is that the incremental complexity of parallel programming over
> > that of sequential programming is not as large as is commonly believed.
> > Despite that you might have heard, the mind-numbing complexity of modern
> > computer systems is not due so much to there being multiple CPUs, but
> > rather to there being any CPUs at all. �In short, for the ultimate in
> > computer-system simplicity, the optimal choice is NR_CPUS=0.
> >
> > This commit therefore limits kernel builds to zero CPUs. �This change
> > has the beneficial side effect of rendering all kernel bugs harmless.
> > Furthermore, this commit enables additional beneficial changes, for
> > example, the removal of those parts of the kernel that are not needed
> > when there are zero CPUs.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >
> > �alpha/Kconfig � � � � � � � � � � | � 11 ++++++-----
> > �arm/Kconfig � � � � � � � � � � � | � �6 +++---
> > �blackfin/Kconfig � � � � � � � � �| � �3 ++-
> > �hexagon/Kconfig � � � � � � � � � | � �9 +++++----
> > �ia64/Kconfig � � � � � � � � � � �| � �9 +++++----
> > �m32r/Kconfig � � � � � � � � � � �| � 10 ++++++----
> > �mips/Kconfig � � � � � � � � � � �| � 21 +++++++++++----------
> > �mn10300/Kconfig � � � � � � � � � | � �3 ++-
> > �parisc/Kconfig � � � � � � � � � �| � �6 +++---
> > �powerpc/platforms/Kconfig.cputype | � �8 ++++----
> > �s390/Kconfig � � � � � � � � � � �| � 12 +++++++-----
> > �sh/Kconfig � � � � � � � � � � � �| � 11 ++++++-----
> > �sparc/Kconfig � � � � � � � � � � | � �8 ++++----
> > �tile/Kconfig � � � � � � � � � � �| � �9 +++++----
> > �x86/Kconfig � � � � � � � � � � � | � 16 +++++++++-------
> > �15 files changed, 78 insertions(+), 64 deletions(-)
> 
> You forgot to fix half of the architectures, a.o. m68k?

I must confess that I fixed only the SMP-capable architectures.

I of course would welcome additions for UP-only architectures.

							Thanx, Paul
