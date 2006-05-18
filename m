Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2006 13:17:48 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:18894 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133864AbWERLRl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 May 2006 13:17:41 +0200
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id 71D6E44330; Thu, 18 May 2006 13:17:39 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FggV6-00041d-S8; Thu, 18 May 2006 12:17:04 +0100
Date:	Thu, 18 May 2006 12:17:04 +0100
To:	dmitry pervushin <dpervushin@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] NEC EMMA2RH support
Message-ID: <20060518111703.GA15601@networkno.de>
References: <1147946423.8223.4.camel@diimka-laptop> <20060518195404.663eba86.yoichi_yuasa@tripeaks.co.jp> <1147950509.8223.10.camel@diimka-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147950509.8223.10.camel@diimka-laptop>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

dmitry pervushin wrote:
> On ???, 2006-05-18 at 19:54 +0900, Yoichi Yuasa wrote:
> > Hi,
> > 
> > On Thu, 18 May 2006 14:00:23 +0400
> > dmitry pervushin <dpervushin@ru.mvista.com> wrote:
> > 
> > > Index: linux-malta/arch/mips/emma2rh/markeins/int-handler.S
> > > ===================================================================
> > > --- /dev/null
> > > +++ linux-malta/arch/mips/emma2rh/markeins/int-handler.S
> > 
> > You should rewrite the assembler interrupt handler to C code.
> Why ?? Could you please comment the statement ?

The other handlers were rewritten in C recently.

> May be, I have
> misunderstood the modern ways in linux kernel development, but I am
> pretty sure that assembler interrupt handler will be faster than C
> code.

Only marginally, it doesn't outweigh the maintenance trouble.


Thiemo
