Received:  by oss.sgi.com id <S42312AbQHVLWi>;
	Tue, 22 Aug 2000 04:22:38 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:54276 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42304AbQHVLWU>;
	Tue, 22 Aug 2000 04:22:20 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8BD7E7DD; Tue, 22 Aug 2000 13:25:38 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0A5AC8FF5; Tue, 22 Aug 2000 13:21:48 +0200 (CEST)
Date:   Tue, 22 Aug 2000 13:21:47 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: VCE exception
Message-ID: <20000822132147.D6784@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
i am still seeing a lot of VCE exceptions on my R4k Decstations
and on the SGI Indigo2 - On my Decstation 5000/260 there are
around 300 VCEI exceptions a second which is VERY much.

I am now trying to understand the cause of these Exceptions.

As i understand from the Books a VCE is taken when on an
access to the Second level cache its detected that there is already
a copy of this data in the Primary Cache but its accessed through
a different P-Cache line as its Virtually indexed and the same
data is accessed through a different Virtual address.

As i understand this correct isnt it normal to have this kind
of exception (for instructions) as we are dealing with shared
librarys which might be mapped to different virtual addresses for each
process.

The books now say - We should delete/invalidate the old location
on the Primary cache and update the PIdx in the Second level cache.

[builder@resume builder]$ uptime
11:07am  up 20:51,  1 user,  load average: 1.01, 1.10, 1.10
[builder@resume builder]$ cat /proc/cpuinfo 
cpu			: MIPS
cpu model		: R4000SC V6.0
system type		: SGI Indy
BogoMIPS		: 124.93
byteorder		: big endian
unaligned accesses	: 97
wait instruction	: no
microsecond timers	: no
extra interrupt vector	: no
hardware watchpoint	: yes
VCED exceptions		: 17367628
VCEI exceptions		: 10243032

This is an uptime of 75060 seconds - 136 VCEI/s and 231 VCED/s

builder@repeat:~$ uptime
cat   7:59am  up 3 days, 19:26,  1 user,  load average: 1.17, 1.06, 1.08
builder@repeat:~$ cat /proc/cpuinfo 
cpu			: MIPS
cpu model		: R4000SC V3.0
system type		: Digital DECstation 5000/1xx
BogoMIPS		: 49.81
byteorder		: little endian
unaligned accesses	: 45
wait instruction	: no
microsecond timers	: yes
extra interrupt vector	: no
hardware watchpoint	: yes
VCED exceptions		: 56724062
VCEI exceptions		: 36117905

329160 seconds uptime - 172 VCED/s and 109 VCEI/s 

Both machines were busy nearly all there uptime compiling debian packages.

[flo@reconfig flo]$ cat /proc/cpuinfo 
cpu			: MIPS
cpu model		: R4400SC V4.0
system type		: Digital DECstation 5000/2x0
BogoMIPS		: 59.90
byteorder		: little endian
unaligned accesses	: 0
wait instruction	: no
microsecond timers	: yes
extra interrupt vector	: no
hardware watchpoint	: yes
VCED exceptions		: 753186
VCEI exceptions		: 1557460
[flo@reconfig flo]$ uptime
  6:55pm  up 12:04,  2 users,  load average: 1.08, 1.06, 1.05
[flo@reconfig flo]$ 

43440 Seconds uptime  - 35 VCEI/s - 17 VCED/s  - On this last
machine i have seen >300 VCEI/s second on an mostly idle machine.
This last machine was idle for most of the uptime ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
