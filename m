Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 01:02:35 +0000 (GMT)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:5975
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225329AbVBWBCU>;
	Wed, 23 Feb 2005 01:02:20 +0000
Received: from [192.168.0.35] ([192.168.0.35] unverified) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 22 Feb 2005 17:02:17 -0800
Message-ID: <421BD616.4030101@avtrex.com>
Date:	Tue, 22 Feb 2005 17:02:14 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jim Gifford <maillist@jg555.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
References: <421BCF34.90308@jg555.com>
In-Reply-To: <421BCF34.90308@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2005 01:02:17.0733 (UTC) FILETIME=[51E40B50:01C51943]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
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
> 


It seems that you might need some (but not all) of the patch I posted here:

http://www.linux-mips.org/archives/linux-mips/2004-10/msg00068.html

Specifically I think you will need at least the parts that add

#include <sgidefs.h>

To many of the .h files.  Basically any file that uses the symbol 
_MIPS_SIM and friends needs to either directly or indirectly include 
sgidefs.h

You may also need:

http://www.linux-mips.org/archives/linux-mips/2004-10/msg00142.html

And something like this:

http://sources.redhat.com/ml/libc-alpha/2004-11/msg00165.html


David Daney.
