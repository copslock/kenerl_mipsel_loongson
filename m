Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g77FdIRw005974
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 7 Aug 2002 08:39:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g77FdICf005973
	for linux-mips-outgoing; Wed, 7 Aug 2002 08:39:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g77Fd5Rw005963
	for <linux-mips@oss.sgi.com>; Wed, 7 Aug 2002 08:39:06 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA22271;
	Wed, 7 Aug 2002 17:41:30 +0200 (MET DST)
Date: Wed, 7 Aug 2002 17:41:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Stewart Brodie <stewart.brodie@pace.co.uk>
cc: linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS32 implies CONFIG_CPU_HAS_PREFETCH
In-Reply-To: <0de052624b.sbrodie@sbrodie.cam.pace.co.uk>
Message-ID: <Pine.GSO.3.96.1020807172647.18037H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 7 Aug 2002, Stewart Brodie wrote:

> linux_2_4 branch question: In config-shared.in, and previously in config.in,
> whether or not the CPU has prefetch instructions seems to be dependent only
> on whether CONFIG_MIPS32 is y.  However, this causes our kernel builds to die

 Well, what I see is CONFIG_CPU_HAS_PREFETCH is set for the following CPU
selection options:

- CONFIG_CPU_MIPS32,

- CONFIG_CPU_MIPS64,

- CONFIG_CPU_RM7000,

- CONFIG_CPU_SB1,

presumably because they support prefetching instructions.

> when compiling memcpy.S because the compiler is objecting to the pref/prefx
> instructions.  The gcc 2.96 compiler options we are using are -mtune=r4600
> and -mips2.

 Check you have a sufficiently new version of binutils -- the instructions
are guarded by ".set mips4", so they should be assembled just fine
regardless of the options passed to as.  What is the exact error message
printed (the usual first question, sigh...)?

> Is it simply the case that the processors on all the boards supported in the
> MIPS builds all support prefetch?  At the moment, I've just put a specific
> check in for our particular processor to stop CONFIG_CPU_HAS_PREFETCH from
> being set to y and that stops the problem.  In earlier (2.4.17 pre-release)
> kernels, whether or not to define PREF/PREFX as pref/prefx or the empty
> string was determined on a stricter set of criteria based around actual CPU
> types rather than a blanket check on being a 32-bit MIPS.

 Please make sure you have a clean checkout of the CVS tree -- here is an
extract of the relevant part of current config-shared.in from the 2.4
branch:

if [ "$CONFIG_CPU_MIPS32" = "y" ]; then
   define_bool CONFIG_CPU_HAS_PREFETCH y
   bool '  Support for Virtual Tagged I-cache' CONFIG_VTAG_ICACHE
fi

if [ "$CONFIG_CPU_MIPS64" = "y" ]; then
   define_bool CONFIG_CPU_HAS_PREFETCH y
   bool '  Support for Virtual Tagged I-cache' CONFIG_VTAG_ICACHE
fi

if [ "$CONFIG_CPU_RM7000" = "y" ]; then
   define_bool CONFIG_CPU_HAS_PREFETCH y
fi

if [ "$CONFIG_CPU_SB1" = "y" ]; then
   bool '  Workarounds for pass 1 sb1 bugs' CONFIG_SB1_PASS_1_WORKAROUNDS
   bool '  Support for SB1 Cache Error handler' CONFIG_SB1_CACHE_ERROR
   define_bool CONFIG_VTAG_ICACHE y
   define_bool CONFIG_CPU_HAS_PREFETCH y
fi

as you might see there is no CONFIG_MIPS32 dependency anywhere (also the
kernel works for the R3k, which definitely lacks prefetching intructions).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
