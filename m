Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 00:33:28 +0000 (GMT)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:36526
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225302AbVBWAdM>;
	Wed, 23 Feb 2005 00:33:12 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN jim, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Tue, 22 Feb 2005 16:33:10 -0800
  id 00008479.421BCF46.00000289
Message-ID: <421BCF34.90308@jg555.com>
Date:	Tue, 22 Feb 2005 16:32:52 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Building GLIBC 2.3.4 on MIPS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

I'm trying to build the current glibc with my RaQ2, everything builds 
ok, until I start compiling strace.

syscall.c: In function `dumpio':
syscall.c:449: error: `SYS_read' undeclared (first use in this function)
syscall.c:449: error: (Each undeclared identifier is reported only once
syscall.c:449: error: for each function it appears in.)
syscall.c:465: error: `SYS_write' undeclared (first use in this function)
syscall.c: In function `syscall_fixup':
syscall.c:1265: warning: unused variable `pid'
syscall.c: In function `trace_syscall':
syscall.c:2481: error: `SYS_exit' undeclared (first use in this function)
make[1]: *** [syscall.o] Error 1
make[1]: Leaving directory `/usr/src/strace-4.5.9'
make: *** [all] Error 2

Which leads me to check syscall.h, then I noticed a big difference from 
my x86 version to this version, all the SYS_ entries are missing.  Did I 
build it wrong or is this a glibc issue, due to the addition of the 
mips32 and mips64 directories.

Here is my bug report with the glibc folks for everyone's reference.
http://sources.redhat.com/bugzilla/show_bug.cgi?id=758

-- 
----
Jim Gifford
maillist@jg555.com
