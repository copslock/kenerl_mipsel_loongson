Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 13:24:31 +0000 (GMT)
Received: from pD95621F5.dip.t-dialin.net ([IPv6:::ffff:217.86.33.245]:35644
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225346AbUKINY0>; Tue, 9 Nov 2004 13:24:26 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id iA9DOIdf000979;
	Tue, 9 Nov 2004 14:24:18 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id iA9DOI4x000978;
	Tue, 9 Nov 2004 14:24:18 +0100
Date: Tue, 9 Nov 2004 14:24:18 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: mansoor <mansoor@isofttech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Disabling lwc0 instruction
Message-ID: <20041109132418.GE5652@linux-mips.org>
References: <04e601c4c65c$2fdc15a0$8c00a8c0@mansoor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04e601c4c65c$2fdc15a0$8c00a8c0@mansoor>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 09, 2004 at 06:31:11PM +0530, mansoor wrote:

> Iam working on lx4189. This core doesnt support 
> "lwc0" instruction but my tool chain generates
> this instruction.
> 
> So when I run some applications it throws 
> "unknown instruction" exception.
> 
> How can solve this issue ?
> 
> I have few solutions but I dont know
> whether its correct.
> 
> 
> 1) Re-build the toolchain with this instruction
>     disbaled. But how to do this ?.
> 2) Write an exception handler to handle this 
>     instruction. The exact replacement would be
>     "mfc0". how to do this ?

No.  lwc0 is ll, load linked.  In 2.6 define cpu_has_llsc to return 0 in
your system's cpu-feature-override.h.  In 2.4 disable CONFIG_CPU_HAS_LLSC.

The kernel actually has an emulation for ll/sc in applications which
enables running of application code using ll/sc on ll/sc-less processors.
You should try to find why this seems to fail for you.  Maybe this Lexra
kernel is simply super-ancient?  If it's as old as it seems you should
replace it as it has various exploitable security holes.

  Ralf
