Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2003 00:26:02 +0000 (GMT)
Received: from p508B62E6.dip.t-dialin.net ([IPv6:::ffff:80.139.98.230]:34478
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224948AbTL2A0B>; Mon, 29 Dec 2003 00:26:01 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBT0Pqa5013139;
	Mon, 29 Dec 2003 01:25:52 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBT0Pps1013138;
	Mon, 29 Dec 2003 01:25:51 +0100
Date: Mon, 29 Dec 2003 01:25:50 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.5 n32 syscall numbers are wrong
Message-ID: <20031229002550.GA13103@linux-mips.org>
References: <20031223175732.GA26052@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223175732.GA26052@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 23, 2003 at 12:57:32PM -0500, Daniel Jacobowitz wrote:

> If you take a look at scall64-n32.S, you'll find that there's no hole after
> sendfile64.  But in <asm/unistd.h> there is.  So glibc gets built with the
> wrong number for clock_gettime and confusion ensues...

Applied.  I also fixed __NR_Linux_syscalls and __NR_N32_Linux_syscalls
which also were off by one but didn't get fixed by your patch.

  Ralf
