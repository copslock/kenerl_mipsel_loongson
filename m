Received:  by oss.sgi.com id <S42234AbQG2QHO>;
	Sat, 29 Jul 2000 09:07:14 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:60797 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42222AbQG2QGx>;
	Sat, 29 Jul 2000 09:06:53 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA26941
	for <linux-mips@oss.sgi.com>; Sat, 29 Jul 2000 08:59:19 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA69465
	for <linux@engr.sgi.com>;
	Sat, 29 Jul 2000 09:06:35 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA03615
	for <linux@engr.sgi.com>; Sat, 29 Jul 2000 09:06:34 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id JAA09178;
	Sat, 29 Jul 2000 09:05:57 -0700
Message-ID: <398300E5.143F5370@mvista.com>
Date:   Sat, 29 Jul 2000 09:05:57 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
CC:     jpuhlman@mvista.com
Subject: Bus error of gdb 5.0 with MIPS patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,

I started to play with gdb 5.0 + the MIPS patch at
http://www.ds2.pg.gda.pl/~macro/gdb-5.0/, but I am having a bus error if
I want to do 'next step'.  Setting breakpoints and continuing running
seem to be fine.

The gdb 4.17 rpm from oss.sgi.com does not have this problem.

Any idea?

Jun

---------------

sh-2.03# ./gdb hello
GNU gdb 5.0 (UI_OUT)
Copyright 2000 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you
are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for
details.
This GDB was configured as "mipsel-hardhat-linux"...
(gdb) n
The program is not being run.
(gdb) b main
Breakpoint 1 at 0x400c24: file hello.c, line 5.
(gdb) r
Starting program: /tmp/hello 
[tcsetpgrp failed in terminal_inferior: Not a typewriter]
[tcsetpgrp failed in terminal_inferior: Not a typewriter]
[tcsetpgrp failed in terminal_inferior: Not a typewriter]

Breakpoint 1, main () at hello.c:5
5         printf("hello, world\n");
(gdb) n
[tcsetpgrp failed in terminal_inferior: Not a typewriter]
Bus error

-----------

P.S., Does anybody know how to fix "tcsetpgrp ..." error?
