Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA09081; Tue, 14 May 1996 20:30:16 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA07340 for linux-list; Wed, 15 May 1996 03:28:51 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA07333 for <linux@cthulhu.engr.sgi.com>; Tue, 14 May 1996 20:28:49 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA09037 for <lmlinux@neteng.engr.sgi.com>; Tue, 14 May 1996 20:28:48 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA07320; Tue, 14 May 1996 20:28:48 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id UAA08560; Tue, 14 May 1996 20:28:45 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id XAA00765; Tue, 14 May 1996 23:28:39 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id XAA24278; Tue, 14 May 1996 23:28:38 -0400
Date: Tue, 14 May 1996 23:28:38 -0400
Message-Id: <199605150328.XAA24278@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: lm@gate1-neteng.engr.sgi.com
CC: lmlinux@neteng.engr.sgi.com, torvalds@cs.helsinki.fi,
        sparclinux-cvs@caipfs.rutgers.edu
Subject: numbers...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Two nights of coding, not bad...

This has to be the fastest csum and csum_copy humanly codable on the
Sparc.  Here are some initial results.  On each run the cache was
purposely forced to be cold on each iteration:

sun4m SS10 115mhz hypersparc, 256k cache
measure_csum_partial
csum_partial: sz[1024] 10000 iterations takes 17009430 microseconds
csum_partial: sz[1024] 1 iteration takes <1700 microseconds>==<332 nanoseconds>
csum_partial: sz[2048] 10000 iterations takes 32609649 microseconds
csum_partial: sz[2048] 1 iteration takes <3260 microseconds>==<636 nanoseconds>
csum_partial: sz[3072] 10000 iterations takes 48152422 microseconds
csum_partial: sz[3072] 1 iteration takes <4815 microseconds>==<940 nanoseconds>
csum_partial: sz[4096] 10000 iterations takes 63708679 microseconds
csum_partial: sz[4096] 1 iteration takes <6370 microseconds>==<1244 nanoseconds>

measure_csum_partial_copy
csum_partial_copy: sz[1024] 10000 iterations takes 30865212 microseconds
csum_partial_copy: sz[1024] 1 iteration takes <3086 microseconds>==<602 nanoseconds>

I'm estimating the function call overhead is around 29 nanoseconds to
get into the damn routine, and around 3 or 4 nanoseconds overhead from
the loop constructs etc. in the benchmark.  It seems to scale very
nicely, on this chip you tend eat around 8ns for byte end aligned
buffers and around 5ns for an extraneous halfword at the end of the
buffer.  0.4us/Kbyte for csum, and 0.6us/Kbyte for csum_copy, _really_
impressive.

Here are some figures for small buffers on the same cpu:

csum_partial: sz[20] 200000 iterations takes 55822206 microseconds
csum_partial: sz[20] 1 iteration takes <279 microseconds>==<54 nanoseconds>
csum_partial: sz[21] 200000 iterations takes 64016336 microseconds
csum_partial: sz[21] 1 iteration takes <320 microseconds>==<62 nanoseconds>
csum_partial: sz[22] 200000 iterations takes 61093525 microseconds
csum_partial: sz[22] 1 iteration takes <305 microseconds>==<59 nanoseconds>
csum_partial: sz[23] 200000 iterations takes 65481187 microseconds
csum_partial: sz[23] 1 iteration takes <327 microseconds>==<63 nanoseconds>
csum_partial: sz[24] 200000 iterations takes 61168735 microseconds
csum_partial: sz[24] 1 iteration takes <305 microseconds>==<59 nanoseconds>
csum_partial: sz[25] 200000 iterations takes 69001025 microseconds
csum_partial: sz[25] 1 iteration takes <345 microseconds>==<67 nanoseconds>
csum_partial: sz[26] 200000 iterations takes 66418949 microseconds
csum_partial: sz[26] 1 iteration takes <332 microseconds>==<64 nanoseconds>
csum_partial: sz[27] 200000 iterations takes 71029491 microseconds
csum_partial: sz[27] 1 iteration takes <355 microseconds>==<69 nanoseconds>
csum_partial: sz[28] 200000 iterations takes 66360048 microseconds
csum_partial: sz[28] 1 iteration takes <331 microseconds>==<64 nanoseconds>
csum_partial: sz[29] 200000 iterations takes 74353705 microseconds
csum_partial: sz[29] 1 iteration takes <371 microseconds>==<72 nanoseconds>
csum_partial: sz[30] 200000 iterations takes 71737147 microseconds
csum_partial: sz[30] 1 iteration takes <358 microseconds>==<69 nanoseconds>
csum_partial: sz[31] 200000 iterations takes 76436420 microseconds
csum_partial: sz[31] 1 iteration takes <382 microseconds>==<74 nanoseconds>
csum_partial: sz[32] 200000 iterations takes 40741293 microseconds
csum_partial: sz[32] 1 iteration takes <203 microseconds>==<39 nanoseconds>
csum_partial: sz[33] 200000 iterations takes 48651585 microseconds
csum_partial: sz[33] 1 iteration takes <243 microseconds>==<47 nanoseconds>
csum_partial: sz[34] 200000 iterations takes 46065031 microseconds
csum_partial: sz[34] 1 iteration takes <230 microseconds>==<44 nanoseconds>
csum_partial: sz[35] 200000 iterations takes 50451529 microseconds
csum_partial: sz[35] 1 iteration takes <252 microseconds>==<49 nanoseconds>
csum_partial: sz[36] 200000 iterations takes 45143096 microseconds
csum_partial: sz[36] 1 iteration takes <225 microseconds>==<43 nanoseconds>
csum_partial: sz[37] 200000 iterations takes 53111738 microseconds
csum_partial: sz[37] 1 iteration takes <265 microseconds>==<51 nanoseconds>
csum_partial: sz[38] 200000 iterations takes 50421138 microseconds
csum_partial: sz[38] 1 iteration takes <252 microseconds>==<49 nanoseconds>
csum_partial: sz[39] 200000 iterations takes 54893618 microseconds
csum_partial: sz[39] 1 iteration takes <274 microseconds>==<53 nanoseconds>
csum_partial: sz[40] 200000 iterations takes 50453690 microseconds
csum_partial: sz[40] 1 iteration takes <252 microseconds>==<49 nanoseconds>
csum_partial: sz[41] 200000 iterations takes 58411664 microseconds
csum_partial: sz[41] 1 iteration takes <292 microseconds>==<57 nanoseconds>
csum_partial: sz[42] 200000 iterations takes 55732943 microseconds
csum_partial: sz[42] 1 iteration takes <278 microseconds>==<54 nanoseconds>
csum_partial: sz[43] 200000 iterations takes 60187768 microseconds
csum_partial: sz[43] 1 iteration takes <300 microseconds>==<58 nanoseconds>
csum_partial: sz[44] 200000 iterations takes 55766810 microseconds
csum_partial: sz[44] 1 iteration takes <278 microseconds>==<54 nanoseconds>
csum_partial: sz[45] 200000 iterations takes 63732553 microseconds
csum_partial: sz[45] 1 iteration takes <318 microseconds>==<62 nanoseconds>

Now, some other CPU types.

sun4m MicroSparcI, 40mhz, 16k icache 20k dcache (can't remember if
thats right or not...):
measure_csum_partial
csum_partial: sz[1024] 10000 iterations takes 62380730 microseconds
csum_partial: sz[1024] 1 iteration takes <6238 microseconds>==<1218 nanoseconds>
csum_partial: sz[2048] 10000 iterations takes 127199716 microseconds
csum_partial: sz[2048] 1 iteration takes <12719 microseconds>==<2484 nanoseconds>

measure_csum_partial_copy
csum_partial_copy: sz[1024] 10000 iterations takes 180276825 microseconds
csum_partial_copy: sz[1024] 1 iteration takes <18027 microseconds>==<3520 nanoseconds>

Thats around 2.5us/Kbyte for csum, 3.6us/Kbyte for csum_copy, not bad
and could be a bit better with some reworking of the scheduling tuned
for the msI instruction cache to get less stalls.  Probably not worth
it though (I come to this conclusion notably because when Gordon Irlam
reworked the SunOS/Solaris window trap handlers to do an extra window
for each trap for cache reasons it turned out to make no difference
performance wise in the "real world" although the code was indeed more
efficient on the msI).

sun4m SS10 Viking/MXCC, 50Mhz, 1mb physical cache, 16k icache
20k dcache (again, correct me here if I am wrong on the i/d sizes):
measure_csum_partial
csum_partial: sz[1024] 10000 iterations takes 31893405 microseconds
csum_partial: sz[1024] 1 iteration takes <3189 microseconds>==<622 nanoseconds>
csum_partial: sz[2048] 10000 iterations takes 60608539 microseconds
csum_partial: sz[2048] 1 iteration takes <6060 microseconds>==<1183 nanoseconds>
csum_partial: sz[3072] 10000 iterations takes 89327514 microseconds
csum_partial: sz[3072] 1 iteration takes <8932 microseconds>==<1744 nanoseconds>
csum_partial: sz[4096] 10000 iterations takes 118067205 microseconds
csum_partial: sz[4096] 1 iteration takes <11806 microseconds>==<2305 nanoseconds>

measure_csum_partial_copy
csum_partial_copy: sz[1024] 10000 iterations takes 45946764 microseconds
csum_partial_copy: sz[1024] 1 iteration takes <4594 microseconds>==<897 nanoseconds>
csum_partial_copy: sz[2048] 10000 iterations takes 88614537 microseconds
csum_partial_copy: sz[2048] 1 iteration takes <8861 microseconds>==<1730 nanoseconds>
csum_partial_copy: sz[3072] 10000 iterations takes 131338863 microseconds
csum_partial_copy: sz[3072] 1 iteration takes <13133 microseconds>==<2565 nanoseconds>

The huge physical cache certainly seems to make a difference, although
I think it is also noticable that the on-chip insn cache would do
better with my algorithm if it were just a tad bigger.  Ho hum...
Note also how it doesn't scale as linearly as on the Hyper and the
msI, again this puzzles me bacaus the icache is smaller on msI.

sun4c SLC, 20MHZ, 64k I/D combined L2 virtual cache:
measure_csum_partial
csum_partial: sz[1024] 10000 iterations takes 227199286 microseconds
csum_partial: sz[1024] 1 iteration takes <22719 microseconds>==<4437 nanoseconds>

measure_csum_partial_copy
csum_partial_copy: sz[1024] 10000 iterations takes 539569714 microseconds
csum_partial_copy: sz[1024] 1 iteration takes <53956 microseconds>==<10538 nanoseconds>

Not too bad for this piece of garbage, the pure virtual 64k cache is
probably the real helper here.  I see no other factor that can get
numbers like this on such a shit cpu.  4.5ms/Kbyte for csum, and
10.6ms/Kbyte for csum/copy... shit Jacobsons m68k algorithm only gets
134us/Kbyte on a 20MHZ 68020.

sun4c IPX, 40MHZ, 64k I/D combined L2 virtual cache:
measure_csum_partial
csum_partial: sz[1024] 10000 iterations takes 112377730 microseconds
csum_partial: sz[1024] 1 iteration takes <11237 microseconds>==<2194 nanoseconds>
csum_partial: sz[2048] 10000 iterations takes 223668577 microseconds
csum_partial: sz[2048] 1 iteration takes <22366 microseconds>==<4368 nanoseconds>

measure_csum_partial_copy
csum_partial_copy: sz[1024] 10000 iterations takes 345064536 microseconds
csum_partial_copy: sz[1024] 1 iteration takes <34506 microseconds>==<6739 nanoseconds>

A little more than twice as fast as the SLC, again the 64k virtual
cache is the performance factor even here and it seems the cache can
keep up with this cpu when it's hot.  2.2us/Kbyte for csum, and
6.8us/Kbyte for csum_copy, not bad at all.

I've verified all of my new code with a very extensive "cksum_helper"
program I wrote which also ran the above benchmarks after the
verification suite completed successfully.  Now I just have to stick
this shit into the kernel and see if it goes ok.  If all goes well we
might end up being able to beat Solaris on those TCP lmbench bandwidth
numbers, no promises.

Later,
David S. Miller
davem@caip.rutgers.edu
