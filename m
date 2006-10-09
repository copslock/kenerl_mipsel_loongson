Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 15:58:23 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:3497 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20039675AbWJIO6S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2006 15:58:18 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id DFDF1446E2; Mon,  9 Oct 2006 16:58:16 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GWwa9-0007Np-SY; Mon, 09 Oct 2006 15:58:17 +0100
Date:	Mon, 9 Oct 2006 15:58:17 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
Message-ID: <20061009145817.GB18308@networkno.de>
References: <45265BF0.8080103@innova-card.com> <20061006172153.GB4456@networkno.de> <452A3953.4060802@innova-card.com> <20061009132131.GA18308@networkno.de> <452A5BEA.2060500@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452A5BEA.2060500@innova-card.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
[snip]
> >> If so could you explain the choice of these values
> >> because I fail to understand it.
> > 
> > It allows to load a 64-bit kernel in KSEG0,
> 
> sorry to be ignorant of 64 bit kernels, but what's the point
> to load them in KSEG0.

Smaller code with better performance.

> > and use short 2-instruction symbol references there.
> 
> do you mean "it allows to use only 2 'lui' instructions to load
> a symbol address into a register" ?

It allows a 2-instruction "lui ; addiu" sequence instead of a
6-instruction "lui ; lui ; addiu ; addiu ; dsll32 ; addu" sequence.

> Futhermore I don't see how some part of the kernel convert virtual
> address into a physical one with such values. For example in setup.c,
> the function resource_init() does:
> 
> 	code_resource.start = virt_to_phys(&_text);
> 	code_resource.end = virt_to_phys(&_etext) - 1;
> 	data_resource.start = virt_to_phys(&_etext);
> 	data_resource.end = virt_to_phys(&_edata) - 1;
> 
> How does it work in this case ?

Those are addresses in 64-bit space, no special handling is needed
there.

The same doesn't hold for the initrd addresses supplied by the (32-bit)
firmware. The firmware doesn't convert the kernel parameters to 64-bit
values because the O2 kernel used to allow a pure 32-bit build, and the
firmware can't find out what's actually inside the object file.


Thiemo
