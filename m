Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Nov 2004 16:46:38 +0000 (GMT)
Received: from pD956202C.dip.t-dialin.net ([IPv6:::ffff:217.86.32.44]:55592
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224901AbUKQQqb>; Wed, 17 Nov 2004 16:46:31 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAHGkT1w025609;
	Wed, 17 Nov 2004 17:46:29 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAHGkT8b025608;
	Wed, 17 Nov 2004 17:46:29 +0100
Date: Wed, 17 Nov 2004 17:46:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Linux-MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Dubious MIPS kernel SMP Structures
Message-ID: <20041117164629.GA10920@linux-mips.org>
References: <006d01c4ccba$36a43110$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006d01c4ccba$36a43110$10eca8c0@grendel>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 17, 2004 at 04:29:21PM +0100, Kevin D. Kissell wrote:

> In arch/mips/kerenl/smp.c, there are two tables defined, __cpu_number_map[]
> and __cpu_logical_map[], which would appear to provide forward and backward
> mapping between a set of unique but arbitrary CPU numbers and a monotonically
> increasing number 0..n of indices into per-CPU data.   As near as I can tell, the
> only use of this is in the sb1250 code for setting up interrupt hardware.  Is there
> a reason why it's defined at the mips/kernel level, and not down in the SiByte
> platform subtree?  Is there a generic, architectural definition of how these mappings
> should and should not be set up and used?

The Linux kernel is living in the assumption of having a dense CPU number
space and being started by cpu 0 - something that isn't necessarily
reflected by the underlying hardware.  The system for which this concept
was introduced into Linux is SGI's IP27.  IP27 permits dividing of large
systems into multiple independant partitions.  Assume a two module
Origin 2000; let's assume it's fully configured with 16 processors.
Parititioning results in two domains.  The first consists of processors
0 - 7; the second 8 - 15.  Just for the kicks let's assume physical
processors 11 and 13 are broken and therfor were disabled.  From point of
view of the generic Linux kernel this leaves a 6 processor system.  So
when we boot the kernel it will initialize these two mappings to the
following mapping:

  logical     physical
   CPU #  ->    CPU #
    0            8
    1            9
    2           10
    3           12
    4           14
    5           15

  physical     logical  
   CPU #   ->   CPU #
     8           0
     9           1
    10           2
    11	  			# broken CPU, we're skipping this CPU number
    12           3
    13	  			# broken CPU, we're skipping this CPU number
    14           4
    15           5

As you found the IP27 code doesn't properly setup these mappings anymore;
partly because it's SMP initialization code is twisted to the point
where nobody understands it anymore.  Partly also because the systems
we used as SGI were too large to leave CPU numbers unused :)

Honestly no idea why the Sibyte code is using that mapping stuff.  The
Sibyte firmware is always launching the kernel on CPU 0 anyway so we have
the case of either only CPU 0 or both CPU 0 and CPU 1 which means the
mapping would always be a 1:1 mapping.

For most simple SMP or ccNUMA configurations assuming a 1:1 mapping is
reasonable.  For some uniprocessor configurations where a uniprocessor
kernel is running on a single processor other than processor number 0 on
a multiprocessor platform this also may be useful.

  Ralf
