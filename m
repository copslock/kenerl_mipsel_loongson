Received:  by oss.sgi.com id <S553661AbRCNNr1>;
	Wed, 14 Mar 2001 05:47:27 -0800
Received: from NEVYN.RES.CMU.EDU ([128.2.145.225]:50852 "EHLO nevyn.them.org")
	by oss.sgi.com with ESMTP id <S553675AbRCNNrD>;
	Wed, 14 Mar 2001 05:47:03 -0800
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14dBbl-0006gk-00
	for <linux-mips@oss.sgi.com>; Wed, 14 Mar 2001 08:46:33 -0500
Date:   Wed, 14 Mar 2001 08:46:33 -0500
From:   Daniel Jacobowitz <dan@debian.org>
To:     linux-mips@oss.sgi.com
Subject: Can't build a CONFIG_CPU_NEVADA kernel
Message-ID: <20010314084633.A25674@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I've been trying for a couple of days now to build a MIPS kernel with
CONFIG_CPU_NEVADA, and I can't get it to work.  r4k_switch.S produces a
pile of "opcode not supported by processor" errors.

First, I figured out where the problem is coming from:

r4k_switch.S is included for all processors but the r3000 and r3912. 
Is that really correct?  Then, it references FPU_SAVE_DOUBLE, which
includes:

        cfc1    tmp,  fcr31;                    \
        sdc1    $f0,  (THREAD_FPU + 0x000)(thread); \
        sdc1    $f2,  (THREAD_FPU + 0x010)(thread); \


The sdc1 instruction in binutils is flagged like this:
      if (mips_cpu == CPU_R4650)
        {
          as_bad (_("opcode not supported on this processor"));
          return;
        }

And the IVR sets CONFIG_CPU_NEVADA, which produces
ifdef CONFIG_CPU_NEVADA
GCCFLAGS        += -mcpu=r8000 -mips2 -Wa,--trap -mmad
endif

and -mmad becomes -m4650 to the assembler.


Something is fishy here.  Anyone know what?  I have a suspicion that we
need to change the way we invoke binutils.  Making -mmad imply -m4650
just seems lame, since -m4650 also implies -msingle-float, and I don't
think that's right for the r8000.

I worked back in time in gcc, binutils, and kernel sources and I
couldn't figure out what's changed - I'm sure this worked at some
point.

Any ideas?

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
                         "I am croutons!"
