Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 17:44:08 +0100 (BST)
Received: from localhost.localdomain ([IPv6:::ffff:127.0.0.1]:35210 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226892AbVGSQnD>; Tue, 19 Jul 2005 17:43:03 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6JGiRJ7009503;
	Tue, 19 Jul 2005 12:44:27 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6JGiRPT009502;
	Tue, 19 Jul 2005 12:44:27 -0400
Date:	Tue, 19 Jul 2005 12:44:27 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kishore K <hellokishore@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: bal instruction in gcc 3.x
Message-ID: <20050719164427.GB8758@linux-mips.org>
References: <f07e6e05071909301c212ab4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07e6e05071909301c212ab4@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 19, 2005 at 10:00:20PM +0530, Kishore K wrote:

> We are facing a problem when U-boot is compiled with gcc 3.x
> 
> U-boot  uses the following instruction in one of the files.
> 
> bal jump_to_symbol
> 
> This code gets compiled without any problem with gcc2. However, if I
> compile the code
> with gcc3, it exits with the error "Cannot branch to unknown symbol".
> 
> What should we do to circumvent this problem ?
> 
> I replaced 
> 
> bal jump_to_symbol 
> 
> by
> 
> la t9, jump_to_symbol
> jalr t9
> 
> Then code gets compiled properly without any problem. Please let me
> know, whether this
> is correct way of fixing the problem. I am newbie to MIPS assembly
> language. Why this
> change is required with gcc 3.x compiler ?

FIrst of all, gcc doesn't care at all about your assembler code, that's
the assembler which you must have changed along with that.

There used to be no relocation type to represent a branch to an external
symbol in an ELF file which is why gas is throwing an error message, so
gas is throwing an error message.  Latest gas fixed that shortcoming.
I think there was a bug in somewhat older gas which resulted in such
invalid code actually being accepted even though it shouldn't have been.

  Ralf
