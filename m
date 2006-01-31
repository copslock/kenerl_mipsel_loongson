Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 18:38:21 +0000 (GMT)
Received: from bender.bawue.de ([193.7.176.20]:48105 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133544AbWAaSiE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2006 18:38:04 +0000
Received: from lagash (unknown [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id E99CD4BF7E; Tue, 31 Jan 2006 19:43:04 +0100 (MET)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1F40Sr-00012C-Pu; Tue, 31 Jan 2006 18:42:53 +0000
Date:	Tue, 31 Jan 2006 18:42:53 +0000
To:	Johannes Stezenbach <js@linuxtv.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
Message-ID: <20060131184253.GA23753@networkno.de>
References: <20060131171508.GB6341@linuxtv.org> <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl> <20060131181414.GA8288@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131181414.GA8288@linuxtv.org>
User-Agent: Mutt/1.5.11
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Tue, Jan 31, 2006 at 07:14:14PM +0100, Johannes Stezenbach wrote:
[snip]
> Yes, that's why I said I'm confused about mips_isa_regsize() vs.
> mips_abi_regsize().
> 
> mips_abi_regsize() correctly says the register size is 32bit for o32,
> but mips_register_type() calls mips_isa_regsize(), not
> mips_abi_regsize(). That's why I chose to "fix" mips_isa_regsize().
> 
> Or should mips_register_type() simply call mips_abi_regsize()?

Without having had a look at the code I think that's the right fix.

> Or is the correct fix to change gdbserver to transfer registers
> in mips_isa_regsize() size, i.e. 64bit for 64bit ISA?
> (But gdb would't use the upper 32bits of the registers anyway
> with o32 ABI, and this would be more complicated to fix.)


Thiemo
