Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 13:01:33 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:6606 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022562AbXGSMBb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 13:01:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6JC1UQK021392;
	Thu, 19 Jul 2007 13:01:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6JC1UjH021391;
	Thu, 19 Jul 2007 13:01:30 +0100
Date:	Thu, 19 Jul 2007 13:01:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] User stack pointer randomisation
Message-ID: <20070719120130.GB16258@linux-mips.org>
References: <469F0E5F.4050005@innova-card.com> <20070719111440.GA19916@linux-mips.org> <cda58cb80707190447m1cd9b37fye7d330b50331b199@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80707190447m1cd9b37fye7d330b50331b199@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 19, 2007 at 01:47:19PM +0200, Franck Bui-Huu wrote:

> this is weird I would have defined them like this instead:
> 
> #if (_MIPS_SIM == _MIPS_SIM_ABI32)
> #define ALSZ 8
> #elif (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
> #define ALSZ 16
> #endif
> 
> #define ALMASK (~(ALSZ-1))

<asm/asm.h> which is fairly similar to it's userspace equivalent <sys/asm.h>
contains definitions which are some sort of pseudo-standard in the MIPS
world, including ALSZ and ALMASK.  If I had choosen them I'd have set
ALSZ to 8 rsp. 16, just like you ...  Anyway, having similar macros makes
porting of assembler code easier.  This also is why <asm/regdef.h> and
<asm/fpregdef.h> are as they are.  RISC/os, IRIX, some of the BSD variants,
even the non-Linux SDE variants for example for baremetal use a similar
set of macros and headers.

  Ralf
