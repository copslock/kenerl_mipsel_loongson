Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 00:55:00 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:38072 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225329AbVBWAyp>; Wed, 23 Feb 2005 00:54:45 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (sccrmhc11) with ESMTP
          id <2005022300543801100t35ete>; Wed, 23 Feb 2005 00:54:39 +0000
Message-ID: <421BD427.5000902@gentoo.org>
Date:	Tue, 22 Feb 2005 19:53:59 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jim Gifford <maillist@jg555.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
References: <421BCF34.90308@jg555.com>
In-Reply-To: <421BCF34.90308@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Jim Gifford wrote:
> I'm trying to build the current glibc with my RaQ2, everything builds 
> ok, until I start compiling strace.
> 
> syscall.c: In function `dumpio':
> syscall.c:449: error: `SYS_read' undeclared (first use in this function)
> syscall.c:449: error: (Each undeclared identifier is reported only once
> syscall.c:449: error: for each function it appears in.)
> syscall.c:465: error: `SYS_write' undeclared (first use in this function)
> syscall.c: In function `syscall_fixup':
> syscall.c:1265: warning: unused variable `pid'
> syscall.c: In function `trace_syscall':
> syscall.c:2481: error: `SYS_exit' undeclared (first use in this function)
> make[1]: *** [syscall.o] Error 1
> make[1]: Leaving directory `/usr/src/strace-4.5.9'
> make: *** [all] Error 2
> 
> Which leads me to check syscall.h, then I noticed a big difference from 
> my x86 version to this version, all the SYS_ entries are missing.  Did I 
> build it wrong or is this a glibc issue, due to the addition of the 
> mips32 and mips64 directories.
> 
> Here is my bug report with the glibc folks for everyone's reference.
> http://sources.redhat.com/bugzilla/show_bug.cgi?id=758

We've bumped into this on the gentoo-side of things.  The fix we're using (for 
now) is this a modified version of this patch here: 
http://lists.debian.org/debian-mips/2004/01/msg00036.html

The above patch wasn't intended for 2.3.4 by default I believe, so it doesn't 
apply cleanly.  It had to be re-diffed for 2.3.4.  You can find this version 
here: http://dev.gentoo.org/~kumba/tmp/6630_mips_fix-syscall_h-again.patch

The resulting bits/syscall.h isn't the cleanest thing, but strace will build 
against it and it does appear to work.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
