Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g223PvI15375
	for linux-mips-outgoing; Fri, 1 Mar 2002 19:25:57 -0800
Received: from paul.rutgers.edu (paul.rutgers.edu [128.6.5.53])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g223Pp915367
	for <linux-mips@oss.sgi.com>; Fri, 1 Mar 2002 19:25:51 -0800
Received: (from muthur@localhost)
	by paul.rutgers.edu (8.10.2+Sun/8.8.8) id g222PnF06013;
	Fri, 1 Mar 2002 21:25:49 -0500 (EST)
Date: Fri, 1 Mar 2002 21:25:49 -0500 (EST)
From: Muthukumar Ratty <muthur@paul.rutgers.edu>
To: linux-mips@oss.sgi.com
Subject: Cross toolchain problem??
Message-ID: <Pine.SOL.4.10.10203012040460.3830-100000@paul.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,

My toolchain information
Host : redhat linux 7.1 in a i386 PC

Tool chains built as per Brad LaRonde's writeup. 
 (Building a Modern MIPS Cross-Toolchain for Linux)
gcc: version 3.0.3
binutils : version 2.11.92.0.7 20011016
glibc: version 2.2.3 with linux threads patch and mips-base-addr patch
	from Brad.

I was able to build kernel 2.4.3, I got from oss.sgi.com and it works fine
(thanks to everyone). So I assumed my toolchain is working fine. Next I
modified the yamon startup code (just used reset.S, gt64120.S, link.xn and
did some cleaning to get it compiled). When I tried to run srecconv.pl
util, I got error message "Out of memory!" (I wanto convert it into flash
format to download. The strange thing is, I have an Algorithmics toolchain
version egcs-2.90.23 980102, GNU ld 2.9.1/sde-4.0.3, and the srec I got
from it doesnt havethis problem)

I tried to trace down and found that the srec generated has load
address 0x80001000 for data and 0xbfc00000 for the startup code (this is
because the link.xn is defined this way). So when an associative array is
used in perl script srecconv.pl, it runs out of memory.  I dont know perl
and I am stuck here. Can somebody point me how to proceed? thanks a lot.
(i really want to have the data loaded at 0x80001000 but it should be
initially in flash).

So I changed the data load address to 0xbfc01000 and now the srecconv
works fine and I got a .fl image. But my "jal gt64120_init" is assembled
to use _gp and I dont think I set the _gp properly ( I am still in the
process of reading Dominics book:). so the code is not at all entering in
to the gt64120_init function. but when I change it to "j gt64120_init"
it works fine. (Cant I use "jal" here?)

Any help would be appreciated and sorry for this long mail,
Thanks,
Muthu
