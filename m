Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DHYnB14299
	for linux-mips-outgoing; Mon, 13 Aug 2001 10:34:49 -0700
Received: from web11901.mail.yahoo.com (web11901.mail.yahoo.com [216.136.172.185])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DHYkj14296
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 10:34:47 -0700
Message-ID: <20010813173446.61234.qmail@web11901.mail.yahoo.com>
Received: from [209.243.184.191] by web11901.mail.yahoo.com; Mon, 13 Aug 2001 10:34:46 PDT
Date: Mon, 13 Aug 2001 10:34:46 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Benchmark performance
To: linux-mips@oss.sgi.com
In-Reply-To: <20010809215522.A1958@lucon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have been running the nbench-byte-2.1 benchmark on a
mips r4k processor with various combinations of kernel
and distribution packages. I initially started with a
2.4.2 kernel using the redhat 5.1 distribution found
on the SGI mips site. I compiled nbench native on the
target with redhat mounted via nfs. I used this as my
base.

I then ran a 2.4.6 kernel on the same mips 4k
processor, but this time with the redhat 7.0
distribution. I compiled native using the
distributions compiler. This resulted in :

a 3 % reduction in the Memory Index benchmark
a 2 % increase in the Integer Index benchmark
a 23 % reduction in the Floating Point Index benchmark


Using the same 2.4.6 kernel on the same mips 4k
processor, with the redhat 7.1 distribution (compiling
native with the distribution's compiler ) I got :

a 5.7 % reduction in the Memory Index benchmark
a 1.5 % reduction in the Integer Index benchmark
a 27 % reduction in the Floating point Index benchmark

Also as a test I ran the redhat 5.1 native compiled
nbench executable on the 2.4.6 / redhat 7.0 setup and
again saw reduced performance :

a 4.8 % reduction in the Memory Index benchmark
a 1.5 % increase in the Integer Index benchmark
a 26  % reduction in the floating point benchmark

Although I tried various compiler switches to acheive
the highest index I could on a per kernel / per
distribution basis ( they weren't always the same ).
My basic CFLAGS settings were :

CFLAGS = -s -static -Wall -O2 -fomit-frame-pointer
-funroll-all-loops -mips2 -finline-functions.


>From the above tests it seems that newer does not in
fact mean faster. I can only speculate as to why, and
so I would appreciate hearing from anyone who :

a, has suggestions on how to optimize compiler
performance.

b, may know why performance seems to degrade with a
newer kernel and with a newer distribution ? newer
compiler ?

c, any other tips for improving kernel / application
performance.

Wayne

__________________________________________________
Do You Yahoo!?
Send instant messages & get email alerts with Yahoo! Messenger.
http://im.yahoo.com/
