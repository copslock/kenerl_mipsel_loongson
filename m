Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g77FNjRw005525
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 7 Aug 2002 08:23:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g77FNjdx005524
	for linux-mips-outgoing; Wed, 7 Aug 2002 08:23:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft19-f76.dialo.tiscali.de [62.246.19.76])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g77FNcRw005515
	for <linux-mips@oss.sgi.com>; Wed, 7 Aug 2002 08:23:39 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g77FPV716777;
	Wed, 7 Aug 2002 17:25:31 +0200
Date: Wed, 7 Aug 2002 17:25:31 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Stewart Brodie <stewart.brodie@pace.co.uk>
Cc: linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS32 implies CONFIG_CPU_HAS_PREFETCH
Message-ID: <20020807172531.A16609@dea.linux-mips.net>
References: <0de052624b.sbrodie@sbrodie.cam.pace.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0de052624b.sbrodie@sbrodie.cam.pace.co.uk>; from stewart.brodie@pace.co.uk on Wed, Aug 07, 2002 at 04:04:16PM +0100
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 07, 2002 at 04:04:16PM +0100, Stewart Brodie wrote:

> linux_2_4 branch question: In config-shared.in, and previously in config.in,
> whether or not the CPU has prefetch instructions seems to be dependent only
> on whether CONFIG_MIPS32 is y.  However, this causes our kernel builds to die
> when compiling memcpy.S because the compiler is objecting to the pref/prefx
> instructions.  The gcc 2.96 compiler options we are using are -mtune=r4600
> and -mips2.
> 
> Is it simply the case that the processors on all the boards supported in the
> MIPS builds all support prefetch?  At the moment, I've just put a specific
> check in for our particular processor to stop CONFIG_CPU_HAS_PREFETCH from
> being set to y and that stops the problem.  In earlier (2.4.17 pre-release)
> kernels, whether or not to define PREF/PREFX as pref/prefx or the empty
> string was determined on a stricter set of criteria based around actual CPU
> types rather than a blanket check on being a 32-bit MIPS.

The MIPS32 architecture specifies a prefetch instruction.  So it's correct
(though not necessarily alway the most efficient thing) to assume your
system has this instruction available.  The compiler option -mips2 which
you're specifying however tells the tools that you do not have that
instruction, so is wrong.

  Ralf
