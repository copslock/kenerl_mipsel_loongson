Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA27117 for <linux-archive@neteng.engr.sgi.com>; Sun, 2 May 1999 19:14:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA78340
	for linux-list;
	Sun, 2 May 1999 19:11:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA34308
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 2 May 1999 19:11:31 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (pr250.pheasantrun.net [208.140.225.250]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA04592
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 May 1999 22:11:24 -0400 (EDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (clepple@sprocket.foo.tho.org [206.223.45.3])
	by foo.tho.org (8.8.7/8.8.7) with ESMTP id WAA29295;
	Sun, 2 May 1999 22:10:49 -0400
Message-ID: <372D05A8.F3EB83D9@foo.tho.org>
Date: Mon, 03 May 1999 02:10:48 +0000
From: Charles Lepple <clepple@foo.tho.org>
X-Mailer: Mozilla 4.5 [en] (X11; U; Linux 2.0.36 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: Linux/SGI <linux@cthulhu.engr.sgi.com>
Subject: strace issues [was Re: am-utils and NIS]
References: <371FE405.2F817623@foo.tho.org> <19990422233451.A12932@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[I'm cc'ing this to the list in case anyone else has seen this behaviour
in strace]

Ralf Baechle wrote:
[stuff about ypcat failing]
> Can you send me the strace output of the failing command?

One of these days I'll manage to compile something without incident...

I grabbed the strace CVS module, and tried to build it. Configure
identified a 'mips-unknown-linux', and things went fine until time.c:

>>>>
gcc -Wall -DHAVE_CONFIG_H   -I. -Ilinux/mips -I./linux/mips -Ilinux
-I./linux -g -O2 -c time.c
/usr/include/asm/timex.h: In function `get_cycles':
In file included from /usr/include/linux/timex.h:138,
                 from time.c:36:
/usr/include/asm/timex.h:36: warning: implicit declaration of function
`read_32bit_cp0_register'
/usr/include/asm/timex.h:36: `CP0_COUNT' undeclared (first use this
function)
/usr/include/asm/timex.h:36: (Each undeclared identifier is reported
only once
/usr/include/asm/timex.h:36: for each function it appears in.)
make: *** [time.o] Error 1
<<<<

So I looked up the offending function, and added '#include
<asm/mipsregs.h>' before the other Linux-specific includes. This
produced an executable, but when I ran 'strace -o /tmp/ypcat -f ypcat
group', the strace output ended like this:

>>>>
6341  gettimeofday({925689555, 977502}, NULL) = 0
6341  getpid()                          = 6341
6341  socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 4
6341  getpid()                          = 6341
6341  bind(4, {sin_family=AF_INET, sin_port=htons(1005),
sin_addr=inet_addr("0.0
.0.0")}, 16) = 0
6341  ioctl(4, 0x667e, 0x7ffffb18)      = 0
<<<<

No exit indication, and no output from the ypcat program, either. The
error code from strace was zero.

The kernel source and strace were both pulled from CVS about an hour
ago.

Any ideas?

-- 
Charles Lepple
System Administrator, Virginia Tech EE Workstation Labs
clepple@ee.vt.edu || http://www.foo.tho.org/charles/
