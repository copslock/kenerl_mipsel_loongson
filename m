Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Oct 2006 16:21:40 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51922 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038536AbWJVPVj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Oct 2006 16:21:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9MFM46H018173;
	Sun, 22 Oct 2006 16:22:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9MFLw1S018172;
	Sun, 22 Oct 2006 16:21:58 +0100
Date:	Sun, 22 Oct 2006 16:21:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Karl-Johan Karlsson <creideiki+linux-mips@ferretporn.se>
Cc:	linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
Message-ID: <20061022152158.GB17776@linux-mips.org>
References: <200610212159.04965.creideiki+linux-mips@ferretporn.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610212159.04965.creideiki+linux-mips@ferretporn.se>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 21, 2006 at 09:59:02PM +0200, Karl-Johan Karlsson wrote:

> I have an Origin 2000 with 16 R12000 and 16 R10000 CPU:s, running a git 
> snapshot kernel from 20060618 based on 2.6.17.10 (the latest available in 
> Gentoo). Light loads run without problems, but as soon as the load average 
> goes above 4-5 system overhead skyrockets and almost no useful work is being 
> done (see top output below). OProfile is no help, since the daemon just 
> throws away everything the kernel gives it (see output from strace of 
> oprofiled below).
> 
> Does anyone know where this overhead is coming from, or how to get some data 
> from OProfile so I can search for it myself? I'll try booting just the R12000 
> part sometime soon to see if that helps with either problem.

Oprofile is a bit of a bitch on mixed processor systems since it assumes
all processors to have identical performance counters.  However SGI in
it's wisdem decieded the R12000 had to be better than the R10000 and
changed it.  It is possible to work around that but lacking any mixed
CPU configuration I've never done that.

With those annotations, the kernel part of oprofile doesn't yet support
R1x000 processors, I'll try to cook up something.  Should be easy enough
since the interface is nearly identical to MIPS32/MIPS64.

  Ralf
