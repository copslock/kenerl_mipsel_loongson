Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3GJ7I001260
	for linux-mips-outgoing; Mon, 16 Apr 2001 12:07:18 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3GJ7HM01257
	for <linux-mips@oss.sgi.com>; Mon, 16 Apr 2001 12:07:17 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id OAA25586
	for <linux-mips@oss.sgi.com>; Mon, 16 Apr 2001 14:07:06 -0500
Message-ID: <3ADB5181.BCE02A9@cotw.com>
Date: Mon, 16 Apr 2001 13:09:37 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Link problems with 2.4.3 kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Using Hardhat linux targeting a NEC VR5432 and a 2.4.0-test 5 kernel I
get an image that looks like the following:

vmlinux:     file format elf32-littlemips

Disassembly of section .text:

0000000080001000 <_ftext>:
 ...
    80002000: 6e 01 00 10 00 00 00 00 00 00 00 00 00 00 00 00
n...............
 ...

0000000080002288 <except_vec0_r4000>:
....
00000000800025bc <kernel_entry>:

--------------------------------------
using the cvs 2.4.3 kernel (about a week old) and the same tool chain I
get an image that looks like:
Using a loadaddr of 8000000

vmlinux:     file format elf32-littlemips

Disassembly of section .text:

0000000080000000 <_ftext>:
    80000000: 6b 01 00 10 00 00 00 00 00 00 00 00 00 00 00 00
k...............
 ...

0000000080000288 <except_vec0_r4000>:
....
00000000800005b0 <kernel_entry>:
 ...

--------------------------------------
If I change the loadaddr to 80001000 I get:

vmlinux:     file format elf32-littlemips

Disassembly of section .text:

0000000080002000 <_ftext>:
    80002000: 6b 01 00 10 00 00 00 00 00 00 00 00 00 00 00 00
k...............
 ...

0000000080002288 <except_vec0_r4000>:
....

00000000800025b0 <kernel_entry>:


-------------------------------------

No matter what I do I can not get _ftext to appear at 80001000. I use
identical ld.scripts for bother kernels.
At first I thought it was my binutils so I switched to the same tools
that I used with my 2.4.0-test5 kernel.

Addresses appear to be off by 0x1000.  Which is why my 2.4.3 kernel dies
on the jump to init_arch out of kernel_entry.

Any thoughts about what I might be doing wrong?


Thanks,
Scott
