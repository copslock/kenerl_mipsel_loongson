Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2003 13:40:42 +0100 (BST)
Received: from p508B791F.dip.t-dialin.net ([IPv6:::ffff:80.139.121.31]:45953
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbTEFMkk>; Tue, 6 May 2003 13:40:40 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h46CeWts002638;
	Tue, 6 May 2003 14:40:33 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h46CeTTg002637;
	Tue, 6 May 2003 14:40:29 +0200
Date: Tue, 6 May 2003 14:40:29 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Guo Michael <michael_e_guo@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Which compiler should I use to make mips64 kernel
Message-ID: <20030506124029.GA2180@linux-mips.org>
References: <BAY8-F125H3IhA1qfT700013d0f@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY8-F125H3IhA1qfT700013d0f@hotmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 06, 2003 at 02:54:52PM +0800, Guo Michael wrote:

> mips64el-linux-ld  -r -o kernel.o sched.o dma.o fork.o exec_domain.o 
> panic.o printk.o module.o exit.o itimer.o info.o time.o softirq.o 
> resource.o sysctl.o acct.o capability.o ptrace.o timer.o user.o signal.o 
> sys.o kmod.o context.o ksyms.o
> mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117

This is a known but not yet fixed problem that only seems to hit certain
kernel configurations; I believe it somehow tied to little endianess also.

  Ralf
