Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0ECHV202199
	for linux-mips-outgoing; Mon, 14 Jan 2002 04:17:31 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0ECHMg02193
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 04:17:23 -0800
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g0EBHCt19254;
	Mon, 14 Jan 2002 11:17:12 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.0/8.8.7) id g0EBH8a01395;
	Mon, 14 Jan 2002 11:17:08 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15426.48692.795968.819750@gladsmuir.algor.co.uk>
Date: Mon, 14 Jan 2002 11:17:08 +0000 (GMT)
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
In-Reply-To: <20020113211323.A7115@momenco.com>
References: <20020113211323.A7115@momenco.com>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Matthew,

> As I understand it, 64-bit support is really two different things:
> 64-bit data path (i.e. unsigned long long) and 64-bit addressing
> (for more than 4G of RAM).

Yes: the MIPS architecture is designed so there are lots of different
things which can be "64-bit", and you don't have to go for them all at
once.  This kind of choice can be as much curse as blessing, of course.

Ralf etc have worked (with some sponsorship from SGI) on a full-blown
system where you get:

o A very large physical address space
o Very large virtual address spaces, using 64-bit pointer types.
o C "long" (and perhaps even "int") becomes 64-bit.

In such a 64-bit Linux system, though, you might still want to be able
to run 32-bit applications with 32-bit pointers, int and long - either
for compatibility or economy (32-bit data types make for a smaller
program).  SGI do this in Irix: I don't know whether the 64-bit
Linux/MIPS systems got around to it.

There are other potentially useful combinations:

o A Linux where all machine-supported integer data types are 32-bit,
  but capable of addressing physical memory outside of a 4Gbyte map.
  (In practice, you need to use this kind of system to get outside of
  a 512Mbyte map - so it's urgent).

  Ralf says he has done this: it could be done without using any
  64-bit operations, but it might be easier with them.

o A system using 32-bit pointers and 'long' throughout, but with
  support for 'long long' 64-bit integer data types in registers.
  
o A system using 64-bit addressing within the kernel, but not for
  applications. 

However, it's unlikely to make sense to do all of them!

> I suspect that this is very much a toolchain issue, as I don't think
> gcc will generate 64-bit addressing code.

I suspect that the generic GNU toolchains are pretty buggy when you
switch on 64-bit MIPS operation; but it's bug-fixes which are needed,
not wholesale new features.

Politics: MIPS Technologies' advocacy for their "MIPS32" instruction
set dialect in embedded systems means there are now some quite capable
MIPS CPUs (eg Alchemy's 500Mhz integrated CPUs) which don't have
64-bit datapaths or arithmetic.  So casual dependence on 64-bit
operations should probably be avoided.

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / home: +44 20 7226 0032
http://www.algor.co.uk
