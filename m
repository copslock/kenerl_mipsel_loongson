Received:  by oss.sgi.com id <S305159AbQCROXP>;
	Sat, 18 Mar 2000 06:23:15 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:29751 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCROWt>;
	Sat, 18 Mar 2000 06:22:49 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA12772; Sat, 18 Mar 2000 06:18:11 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA97292
	for linux-list;
	Sat, 18 Mar 2000 05:59:53 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA26826
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 18 Mar 2000 05:59:47 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from dial-3-232.cwb.matrix.com.br (dial-3-232.cwb.matrix.com.br [200.196.1.232]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA00538
	for <linux@cthulhu.engr.sgi.com>; Sat, 18 Mar 2000 05:59:43 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407911AbQCRN7Y>;
	Sat, 18 Mar 2000 10:59:24 -0300
Date:   Sat, 18 Mar 2000 10:59:24 -0300
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     SGI Linux Alias <linux@cthulhu.engr.sgi.com>
Subject: Re: Include coherency problem, sigaction and otherwise
Message-ID: <20000318105924.A5581@uni-koblenz.de>
References: <005901bf90d1$269b2690$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <005901bf90d1$269b2690$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sat, Mar 18, 2000 at 12:57:29PM +0100, Kevin D. Kissell wrote:

> Having two independent sets of include files between kernel and userland
> is always a bad idea, but is not *necessarily* broken, and sometimes
> cannot be avoided.   The problem is not that the definitions are seperately
> wired, but that they are incompatible - the risk one takes when one creates
> multiple independent definitions.

The problem before that was that using the kernel headers for userland was
a serious problem.

> >                                     Current glibc snapshots and Linuxkernels
> have
> >been fixed to use the same definitions.  If not, mail me a brown paperbag.
> 
> Certainly the hardhat-sgi-5.1-tar.gz archive on oss.sgi.com is out of sync
> with any MIPS/Linux kernel sources of which I am aware.  The most recent
> version of glibc 2.0 for MIPS that I have been able to find is 2.0.7, and it
> too seems to be out of synch.  Which version of glibc has been fixed,
> and where can I download it?   Which userland distribution is built with
> the consistent glibc?

Definately no entire distribution, I'm also not sure if I actually did
publish a fixed libc due to another binutils related issue.  I'm about to
jump into a plane but could you take a look at
pub/linux/mips/redhat/manhattan/RedHat/RPMS/glibc-2.0.6-4.mipseb.rpm
from oss?

  Ralf  (Up, up and away ...)
