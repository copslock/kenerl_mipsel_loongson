Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Mar 2012 22:15:03 +0200 (CEST)
Received: from e34.co.us.ibm.com ([32.97.110.152]:53827 "EHLO
        e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903631Ab2CaUO5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Mar 2012 22:14:57 +0200
Received: from /spool/local
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 31 Mar 2012 14:14:50 -0600
Received: from d03dlp02.boulder.ibm.com (9.17.202.178)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sat, 31 Mar 2012 14:14:35 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
        by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 439773E40047
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 14:14:34 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
        by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2VKEYFs188468
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 14:14:34 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2VKEXva019300
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 14:14:34 -0600
Received: from paulmck-ThinkPad-W500 (sig-9-49-152-53.mts.ibm.com [9.49.152.53])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q2VKEVcq019272;
        Sat, 31 Mar 2012 14:14:32 -0600
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
        id 143EDE4ABB; Sat, 31 Mar 2012 13:14:23 -0700 (PDT)
Date:   Sat, 31 Mar 2012 13:14:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Linas Vepstas <linasvepstas@gmail.com>
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
Message-ID: <20120331201422.GG2450@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <CAHrUA35Bz68DtP-Znr=-+U+6P9CONXzN=9JdMXRfRwmVV9fy=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrUA35Bz68DtP-Znr=-+U+6P9CONXzN=9JdMXRfRwmVV9fy=Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 12033120-1780-0000-0000-0000046B2E72
X-IBM-ISS-SpamDetectors: 
X-IBM-ISS-DetailInfo:  BY=3.00000264; HX=3.00000186; KW=3.00000007;
 PH=3.00000001; SC=3.00000001; SDB=6.00126880; UDB=6.00030191; UTC=2012-03-31
 20:14:48
X-archive-position: 32840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Mar 31, 2012 at 02:57:46PM -0500, Linas Vepstas wrote:
> Hi,
> 
> I didn't actually try to compile the patch below; it didn't look like C
> code so I wasn't sure what compiler to run it through.  I guess maybe its
> python?  However, I'm very sure that the patches are completely correct,
> because I read them, and I also know that Paul is a trustworthy programmer.
>  Thus, please add my ack
> 
> Ack'ed by: Linas Vepstas <linasvepstas@gmail.com>

It is Linux-kernel Kconfig language, which processed during kernel
builds.  I have added your Acked-by.  ;-)

							Thanx, Paul

> On 31 March 2012 11:33, Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
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
> >
> >  alpha/Kconfig                     |   11 ++++++-----
> >  arm/Kconfig                       |    6 +++---
> >  blackfin/Kconfig                  |    3 ++-
> >  hexagon/Kconfig                   |    9 +++++----
> >  ia64/Kconfig                      |    9 +++++----
> >  m32r/Kconfig                      |   10 ++++++----
> >  mips/Kconfig                      |   21 +++++++++++----------
> >  mn10300/Kconfig                   |    3 ++-
> >  parisc/Kconfig                    |    6 +++---
> >  powerpc/platforms/Kconfig.cputype |    8 ++++----
> >  s390/Kconfig                      |   12 +++++++-----
> >  sh/Kconfig                        |   11 ++++++-----
> >  sparc/Kconfig                     |    8 ++++----
> >  tile/Kconfig                      |    9 +++++----
> >  x86/Kconfig                       |   16 +++++++++-------
> >  15 files changed, 78 insertions(+), 64 deletions(-)
> >
> > diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> > index 56a4df9..1766b4a 100644
> > --- a/arch/alpha/Kconfig
> > +++ b/arch/alpha/Kconfig
> > @@ -541,14 +541,15 @@ config HAVE_DEC_LOCK
> >        default y
> >
> >  config NR_CPUS
> > -       int "Maximum number of CPUs (2-32)"
> > -       range 2 32
> > +       int "Maximum number of CPUs (0-0)"
> > +       range 0 0
> >        depends on SMP
> > -       default "32" if ALPHA_GENERIC || ALPHA_MARVEL
> > -       default "4" if !ALPHA_GENERIC && !ALPHA_MARVEL
> > +       default "0" if ALPHA_GENERIC || ALPHA_MARVEL
> > +       default "0" if !ALPHA_GENERIC && !ALPHA_MARVEL
> >        help
> >          MARVEL support can handle a maximum of 32 CPUs, all the others
> > -          with working support have a maximum of 4 CPUs.
> > +          with working support have a maximum of 4 CPUs.  But why take
> > +         chances?  Just stick with zero CPUs.
> >
> >  config ARCH_DISCONTIGMEM_ENABLE
> >        bool "Discontiguous Memory Support (EXPERIMENTAL)"
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index a48aecc..1f07a3a 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1551,10 +1551,10 @@ config PAGE_OFFSET
> >        default 0xC0000000
> >
> >  config NR_CPUS
> > -       int "Maximum number of CPUs (2-32)"
> > -       range 2 32
> > +       int "Maximum number of CPUs (0-0)"
> > +       range 0 0
> >        depends on SMP
> > -       default "4"
> > +       default "0"
> >
> >  config HOTPLUG_CPU
> >        bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> > diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
> > index abe5a9e..6a78549 100644
> > --- a/arch/blackfin/Kconfig
> > +++ b/arch/blackfin/Kconfig
> > @@ -241,7 +241,8 @@ config SMP
> >  config NR_CPUS
> >        int
> >        depends on SMP
> > -       default 2 if BF561
> > +       range 0 0
> > +       default 0 if BF561
> >
> >  config HOTPLUG_CPU
> >        bool "Support for hot-pluggable CPUs"
> > diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> > index 9059e39..daab009 100644
> > --- a/arch/hexagon/Kconfig
> > +++ b/arch/hexagon/Kconfig
> > @@ -158,13 +158,14 @@ config SMP
> >
> >  config NR_CPUS
> >        int "Maximum number of CPUs" if SMP
> > -       range 2 6 if SMP
> > -       default "1" if !SMP
> > -       default "6" if SMP
> > +       range 0 0 if SMP
> > +       default "0" if !SMP
> > +       default "0" if SMP
> >        ---help---
> >          This allows you to specify the maximum number of CPUs which this
> >          kernel will support.  The maximum supported value is 6 and the
> > -         minimum value which makes sense is 2.
> > +         minimum value which makes sense is 2.  But a limit of zero is
> > +         so much safer!
> >
> >          This is purely to save memory - each supported CPU adds
> >          approximately eight kilobytes to the kernel image.
> > diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> > index bd72669..fea0e6d 100644
> > --- a/arch/ia64/Kconfig
> > +++ b/arch/ia64/Kconfig
> > @@ -373,16 +373,17 @@ config SMP
> >          If you don't know what to do here, say N.
> >
> >  config NR_CPUS
> > -       int "Maximum number of CPUs (2-4096)"
> > -       range 2 4096
> > +       int "Maximum number of CPUs (0-0)"
> > +       range 0 0
> >        depends on SMP
> > -       default "4096"
> > +       default "0"
> >        help
> >          You should set this to the number of CPUs in your system, but
> >          keep in mind that a kernel compiled for, e.g., 2 CPUs will boot
> > but
> >          only use 2 CPUs on a >2 CPU system.  Setting this to a value
> > larger
> >          than 64 will cause the use of a CPU mask array, causing a small
> > -         performance hit.
> > +         performance hit.  And setting it larger than zero risks all
> > +         manner of software bugs, so we just play it safe.
> >
> >  config HOTPLUG_CPU
> >        bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> > diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
> > index ef80a65..68b9e88 100644
> > --- a/arch/m32r/Kconfig
> > +++ b/arch/m32r/Kconfig
> > @@ -300,14 +300,16 @@ config CHIP_M32700_TS1
> >        default n
> >
> >  config NR_CPUS
> > -       int "Maximum number of CPUs (2-32)"
> > -       range 2 32
> > +       int "Maximum number of CPUs (0-0)"
> > +       range 0 0
> >        depends on SMP
> > -       default "2"
> > +       default "0"
> >        help
> >          This allows you to specify the maximum number of CPUs which this
> >          kernel will support.  The maximum supported value is 32 and the
> > -         minimum value which makes sense is 2.
> > +         minimum value which makes sense is 2.  Zero may not make sense,
> > +         but given that there is much in this world that does not make
> > +         sense, zero it is!
> >
> >          This is purely to save memory - each supported CPU adds
> >          approximately eight kilobytes to the kernel image.
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 5ab6e89..3d7d06c 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -2192,16 +2192,16 @@ config NR_CPUS_DEFAULT_64
> >        bool
> >
> >  config NR_CPUS
> > -       int "Maximum number of CPUs (2-64)"
> > -       range 1 64 if NR_CPUS_DEFAULT_1
> > +       int "Maximum number of CPUs (0-0)"
> > +       range 0 0 if NR_CPUS_DEFAULT_1
> >        depends on SMP
> > -       default "1" if NR_CPUS_DEFAULT_1
> > -       default "2" if NR_CPUS_DEFAULT_2
> > -       default "4" if NR_CPUS_DEFAULT_4
> > -       default "8" if NR_CPUS_DEFAULT_8
> > -       default "16" if NR_CPUS_DEFAULT_16
> > -       default "32" if NR_CPUS_DEFAULT_32
> > -       default "64" if NR_CPUS_DEFAULT_64
> > +       default "0" if NR_CPUS_DEFAULT_1
> > +       default "0" if NR_CPUS_DEFAULT_2
> > +       default "0" if NR_CPUS_DEFAULT_4
> > +       default "0" if NR_CPUS_DEFAULT_8
> > +       default "0" if NR_CPUS_DEFAULT_16
> > +       default "0" if NR_CPUS_DEFAULT_32
> > +       default "0" if NR_CPUS_DEFAULT_64
> >        help
> >          This allows you to specify the maximum number of CPUs which this
> >          kernel will support.  The maximum supported value is 32 for 32-bit
> > @@ -2212,7 +2212,8 @@ config NR_CPUS
> >          This is purely to save memory - each supported CPU adds
> >          approximately eight kilobytes to the kernel image.  For best
> >          performance should round up your number of processors to the next
> > -         power of two.
> > +         power of two.  And just think how much more memory we will
> > +         save by setting the limit to zero!
> >
> >  source "kernel/time/Kconfig"
> >
> > diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
> > index 8f1c40d..85fc112 100644
> > --- a/arch/mn10300/Kconfig
> > +++ b/arch/mn10300/Kconfig
> > @@ -201,7 +201,8 @@ config SMP
> >  config NR_CPUS
> >        int
> >        depends on SMP
> > -       default "2"
> > +       range 0 0
> > +       default "0"
> >
> >  source "kernel/Kconfig.preempt"
> >
> > diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> > index 242a1b7..358eaf8 100644
> > --- a/arch/parisc/Kconfig
> > +++ b/arch/parisc/Kconfig
> > @@ -254,10 +254,10 @@ config HPUX
> >        depends on !64BIT
> >
> >  config NR_CPUS
> > -       int "Maximum number of CPUs (2-32)"
> > -       range 2 32
> > +       int "Maximum number of CPUs (0-0)"
> > +       range 0 0
> >        depends on SMP
> > -       default "32"
> > +       default "0"
> >
> >  endmenu
> >
> > diff --git a/arch/powerpc/platforms/Kconfig.cputype
> > b/arch/powerpc/platforms/Kconfig.cputype
> > index 425db18..5e607e0 100644
> > --- a/arch/powerpc/platforms/Kconfig.cputype
> > +++ b/arch/powerpc/platforms/Kconfig.cputype
> > @@ -356,11 +356,11 @@ config SMP
> >          If you don't know what to do here, say N.
> >
> >  config NR_CPUS
> > -       int "Maximum number of CPUs (2-8192)"
> > -       range 2 8192
> > +       int "Maximum number of CPUs (0-0)"
> > +       range 0 0
> >        depends on SMP
> > -       default "32" if PPC64
> > -       default "4"
> > +       default "0" if PPC64
> > +       default "0"
> >
> >  config NOT_COHERENT_CACHE
> >        bool
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index d172758..f9bc067 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -169,15 +169,17 @@ config SMP
> >          Even if you don't know what to do here, say Y.
> >
> >  config NR_CPUS
> > -       int "Maximum number of CPUs (2-64)"
> > -       range 2 64
> > +       int "Maximum number of CPUs (0-0)"
> > +       range 0 0
> >        depends on SMP
> > -       default "32" if !64BIT
> > -       default "64" if 64BIT
> > +       default "0" if !64BIT
> > +       default "0" if 64BIT
> >        help
> >          This allows you to specify the maximum number of CPUs which this
> >          kernel will support.  The maximum supported value is 64 and the
> > -         minimum value which makes sense is 2.
> > +         minimum value which makes sense is 2.  The minimal value that
> > +         makes sense might well be 2, but we all know that the only
> > +         -sane- value is zero!
> >
> >          This is purely to save memory - each supported CPU adds
> >          approximately sixteen kilobytes to the kernel image.
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index 713fb58..5ddc7c0 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -705,18 +705,19 @@ config SMP
> >          If you don't know what to do here, say N.
> >
> >  config NR_CPUS
> > -       int "Maximum number of CPUs (2-32)"
> > -       range 2 32
> > +       int "Maximum number of CPUs (0-0)"
> > +       range 0 0
> >        depends on SMP
> > -       default "4" if CPU_SUBTYPE_SHX3
> > -       default "2"
> > +       default "0" if CPU_SUBTYPE_SHX3
> > +       default "0"
> >        help
> >          This allows you to specify the maximum number of CPUs which this
> >          kernel will support.  The maximum supported value is 32 and the
> >          minimum value which makes sense is 2.
> >
> >          This is purely to save memory - each supported CPU adds
> > -         approximately eight kilobytes to the kernel image.
> > +         approximately eight kilobytes to the kernel image.  Debloating
> > +         is the way, NR_CPUS to zero today!!!
> >
> >  config HOTPLUG_CPU
> >        bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> > diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> > index ca5580e..0de9f0f 100644
> > --- a/arch/sparc/Kconfig
> > +++ b/arch/sparc/Kconfig
> > @@ -177,10 +177,10 @@ config SMP
> >  config NR_CPUS
> >        int "Maximum number of CPUs"
> >        depends on SMP
> > -       range 2 32 if SPARC32
> > -       range 2 1024 if SPARC64
> > -       default 32 if SPARC32
> > -       default 64 if SPARC64
> > +       range 0 0 if SPARC32
> > +       range 0 0 if SPARC64
> > +       default 0 if SPARC32
> > +       default 0 if SPARC64
> >
> >  source kernel/Kconfig.hz
> >
> > diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
> > index 11270ca..a05112c 100644
> > --- a/arch/tile/Kconfig
> > +++ b/arch/tile/Kconfig
> > @@ -126,14 +126,15 @@ source "init/Kconfig"
> >  menu "Tilera-specific configuration"
> >
> >  config NR_CPUS
> > -       int "Maximum number of tiles (2-255)"
> > -       range 2 255
> > +       int "Maximum number of tiles (0-0)"
> > +       range 0 0
> >        depends on SMP
> > -       default "64"
> > +       default "0"
> >        ---help---
> >          Building with 64 is the recommended value, but a slightly
> >          smaller kernel memory footprint results from using a smaller
> > -         value on chips with fewer tiles.
> > +         value on chips with fewer tiles.  To minimize both memory
> > +         footprint and bugs, use zero and only zero.
> >
> >  source "kernel/time/Kconfig"
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 5bed94e..a6977f2 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -773,19 +773,21 @@ config MAXSMP
> >
> >  config NR_CPUS
> >        int "Maximum number of CPUs" if SMP && !MAXSMP
> > -       range 2 8 if SMP && X86_32 && !X86_BIGSMP
> > -       range 2 512 if SMP && !MAXSMP
> > -       default "1" if !SMP
> > -       default "4096" if MAXSMP
> > -       default "32" if SMP && (X86_NUMAQ || X86_SUMMIT || X86_BIGSMP ||
> > X86_ES7000)
> > -       default "8" if SMP
> > +       range 0 0 if SMP && X86_32 && !X86_BIGSMP
> > +       range 0 0 if SMP && !MAXSMP
> > +       default "0" if !SMP
> > +       default "0" if MAXSMP
> > +       default "0" if SMP && (X86_NUMAQ || X86_SUMMIT || X86_BIGSMP ||
> > X86_ES7000)
> > +       default "0" if SMP
> >        ---help---
> >          This allows you to specify the maximum number of CPUs which this
> >          kernel will support.  The maximum supported value is 512 and the
> >          minimum value which makes sense is 2.
> >
> >          This is purely to save memory - each supported CPU adds
> > -         approximately eight kilobytes to the kernel image.
> > +         approximately eight kilobytes to the kernel image.  But
> > +         the first supported CPU brings a lot of bugs with it, so
> > +         for ultimate reliability, set the number of CPUs to zero.
> >
> >  config SCHED_SMT
> >        bool "SMT (Hyperthreading) scheduler support"
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-hexagon" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
