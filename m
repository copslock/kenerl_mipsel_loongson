Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2004 12:38:46 +0000 (GMT)
Received: from p508B63AE.dip.t-dialin.net ([IPv6:::ffff:80.139.99.174]:15647
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224872AbUKKMi0>; Thu, 11 Nov 2004 12:38:26 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iABCcJMU001146;
	Thu, 11 Nov 2004 13:38:19 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iABCcGLk001145;
	Thu, 11 Nov 2004 13:38:16 +0100
Date: Thu, 11 Nov 2004 13:38:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Ho Tan <ho.tan@avantec.com.hk>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel compile error
Message-ID: <20041111123815.GA23713@linux-mips.org>
References: <00df01c4c7c5$cffdad90$6e01a8c0@HughTan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00df01c4c7c5$cffdad90$6e01a8c0@HughTan>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 11, 2004 at 04:09:48PM +0800, Ho Tan wrote:

> When compliation, everything go fine until the compiler compling entry.S which locate at arch/mips/kernel. and the Error message prompt.
> 
> make[1]: Entering directory `/usr/eldk/usr/src/linux-mips/arch/mips/kernel'
> mips_4KC-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/eldk/usr/src/linux-mips/include -D_MIPS_SZLONG=32 -D_MIPS_SZPTR=32 -D_MIPS_SZINT=32  -g -G 0 -mno-abicalls -fno-pic -pipe   -c -o entry.o entry.S

_MIPS_SZLONG etc. are defined by the compiler.  If your tree has kludgery
such as defining _MIPS_SZLONG etc. you shouldn't be surprised to see
errors like this.  It also seems to indicate that mips_4KC-gcc is not a
compiler for a mips*-linux* target.

> entry.S: Assembler messages:
> entry.S:225: Error: unrecognized opcode `reg_s $8,164($29)'
> entry.S:226: Error: unrecognized opcode `reg_s $8,164($29)'

And that's what you get from it.  See include/asm-mips/asm.h for REG_S.

  Ralf
