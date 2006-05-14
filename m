Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 01:30:21 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:32912 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133747AbWENXaO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 01:30:14 +0200
Received: from lagash (88-106-136-76.dynamic.dsl.as9105.com [88.106.136.76])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id C512F45597; Mon, 15 May 2006 01:30:10 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FfQ2B-0002bi-CD; Mon, 15 May 2006 00:29:59 +0100
Date:	Mon, 15 May 2006 00:29:59 +0100
To:	John Miller <jamiller1110@cox.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Instruction error with cache opcode
Message-ID: <20060514232959.GD800@networkno.de>
References: <446735C6.2080306@mountolympos.net> <002a01c67761$253e97f0$0202a8c0@Ulysses> <4467796E.8060000@mountolympos.net> <009501c6778e$947c3ff0$10eca8c0@grendel> <44678FB8.4070104@mountolympos.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44678FB8.4070104@mountolympos.net>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

John Miller wrote:
[snip]
> > [kevink@cthulhu tmp]$ mipsel-linux-gcc -I ~/smtchead/include -c cacheop.S
> > cacheop.S: Assembler messages:
> > cacheop.S:4: Error: Instruction cache requires absolute expression
> > cacheop.S:4: Error: Instruction cache requires absolute expression
> > cacheop.S:4: Error: illegal operands `cache'
> >
> >   
> 
> Well, it looks like I am missing something somewhere, just need to pin
> down what I did wrong.

Try gcc -E to get the preprocessed source, this is what the assembler
sees.


Thiemo
