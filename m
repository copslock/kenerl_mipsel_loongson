Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 22:35:18 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:9645 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038944AbWIYVfQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Sep 2006 22:35:16 +0100
Received: from lagash (88-106-220-212.dynamic.dsl.as9105.com [88.106.220.212])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 53E2D4427F; Mon, 25 Sep 2006 23:35:15 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GRy6c-00067W-OI; Mon, 25 Sep 2006 22:35:14 +0100
Date:	Mon, 25 Sep 2006 22:35:14 +0100
To:	Jonathan Day <imipak@yahoo.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: 64K page patch hiccup on SB1
Message-ID: <20060925213514.GB26965@networkno.de>
References: <20060923.235203.126573787.anemo@mba.ocn.ne.jp> <20060925210932.36813.qmail@web31505.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925210932.36813.qmail@web31505.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Jonathan Day wrote:
> I'll take your word for it that it's more useful - it
> doesn't look a whole lot clearer to me! Anyways, this
> is the output, with CONFIG_KALLSYMS enabled:
> 
> **Exception 32: EPC=FFFFFFFF806B1DEC, Cause=00008024
> (Breakpt  ) (CPU0)
>                 RA=FFFFFFFF806B1CF0,

Looks like it hit a BUG() at 0xffffffff806b1dec.


Thiemo
