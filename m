Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g77F2lRw004914
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 7 Aug 2002 08:02:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g77F2lqi004913
	for linux-mips-outgoing; Wed, 7 Aug 2002 08:02:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sbrodie.cam.pace.co.uk (host-33-223.pace.co.uk [136.170.33.223])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g77F2gRw004901
	for <linux-mips@oss.sgi.com>; Wed, 7 Aug 2002 08:02:43 -0700
Received: from loopback ([127.0.0.1]) by sbrodie.cam.pace.co.uk with SMTP; Wed, 07 Aug 2002 15:04:42 GMT
Date: Wed, 07 Aug 2002 16:04:16 +0100
From: Stewart Brodie <stewart.brodie@pace.co.uk>
To: linux-mips@oss.sgi.com
Message-ID: <0de052624b.sbrodie@sbrodie.cam.pace.co.uk>
X-Organization: Pace Micro Technology plc
User-Agent: Messenger-Pro/2.59beta2 (Newsbase/0.61b) (RISC-OS/4.00-Ursula002f)
Subject: CONFIG_MIPS32 implies CONFIG_CPU_HAS_PREFETCH
X-Editor: Zap, using ZapEmail 0.22 (27 Nov 1998) patch-3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Posting-Agent: RISC OS Newsbase 0.61b
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

linux_2_4 branch question: In config-shared.in, and previously in config.in,
whether or not the CPU has prefetch instructions seems to be dependent only
on whether CONFIG_MIPS32 is y.  However, this causes our kernel builds to die
when compiling memcpy.S because the compiler is objecting to the pref/prefx
instructions.  The gcc 2.96 compiler options we are using are -mtune=r4600
and -mips2.

Is it simply the case that the processors on all the boards supported in the
MIPS builds all support prefetch?  At the moment, I've just put a specific
check in for our particular processor to stop CONFIG_CPU_HAS_PREFETCH from
being set to y and that stops the problem.  In earlier (2.4.17 pre-release)
kernels, whether or not to define PREF/PREFX as pref/prefx or the empty
string was determined on a stricter set of criteria based around actual CPU
types rather than a blanket check on being a 32-bit MIPS.

-- 
Stewart Brodie, Senior Software Engineer
Pace Micro Technology PLC
645 Newmarket Road
Cambridge, CB5 8PB, United Kingdom         WWW: http://www.pacemicro.com/
