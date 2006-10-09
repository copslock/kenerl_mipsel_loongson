Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 17:59:20 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:37090 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20039417AbWJIQ7S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2006 17:59:18 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id F3E0144641; Mon,  9 Oct 2006 18:59:16 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GWyTI-00086t-5s; Mon, 09 Oct 2006 17:59:20 +0100
Date:	Mon, 9 Oct 2006 17:59:20 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
Message-ID: <20061009165920.GC18308@networkno.de>
References: <20061009132131.GA18308@networkno.de> <452A5BEA.2060500@innova-card.com> <20061009145817.GB18308@networkno.de> <20061010.005142.03977034.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010.005142.03977034.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 9 Oct 2006 15:58:17 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > > do you mean "it allows to use only 2 'lui' instructions to load
> > > a symbol address into a register" ?
> > 
> > It allows a 2-instruction "lui ; addiu" sequence instead of a
> > 6-instruction "lui ; lui ; addiu ; addiu ; dsll32 ; addu" sequence.
> 
> Just for clarification: IIRC this optimization needs somewhat
> up-to-date binutils/gcc and is not enabled on current lmo kernel,
> right?

For old toolchains there used to be a gruesome hack (which AFAIR broke
at some point), for modern toolchains there's -msym32.


Thiemo
