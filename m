Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 19:26:11 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:63507 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225281AbVDGSZ5>; Thu, 7 Apr 2005 19:25:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j37IPnxN025752;
	Thu, 7 Apr 2005 19:25:49 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j37IPnlI025751;
	Thu, 7 Apr 2005 19:25:49 +0100
Date:	Thu, 7 Apr 2005 19:25:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Fabrizio Fazzino <fabrizio@fazzino.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: Assembly macro with parameters
Message-ID: <20050407182549.GA24235@linux-mips.org>
References: <425573AD.9010702@fazzino.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425573AD.9010702@fazzino.it>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 07, 2005 at 07:53:49PM +0200, Fabrizio Fazzino wrote:

> Hi all,
> I'm working to an hardware extension of the MIPS32 instruction set
> and I need to convert my new instruction into an existing opcode
> to make it possible for the normal GCC to correctly compile the code.
> 
> Just to be clear, to obtain my new FZMIN instruction like
> 
> 	FZMIN $rd, $rs, $rt
> 
> I have to convert it into
> 
> 	LWC1 $rt, rd<<11 ($rs)
> 
> that is an existing (in some cases unused) opcode.
> 
> I'm currently using hardcoded values for the parameters, so
> fzmin(10,8,9) will be transformed into
> 	asm("lwc1 $9, 10<<11($8)" : : : "$10");
> 
> It works, but I need a way to set the values of the parameters
> at runtime; so I've tried the following macro:
> 
> 	#define fzmin(rd, rs, rt) asm("lwc1 $rt, rd<<11($rs)");

Which will leave the assembler entirely unimpressed ;-)

> As you can imagine I'm not an expert of MIPS Assembly macros:
> what I've written does NOT work since the values of rd,rs,rt
> are NOT substituted inside the asm string.
> 
> Is there any way to do what I need? I would appreciate your
> help very much.

Unless you only have a few instructions and are going for a quick hack
I really suggest to add proper support for these instructions to binutils.
Having working support in as, gdb, objdump will make your life so much
easier.

  Ralf
