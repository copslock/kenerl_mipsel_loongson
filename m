Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 16:56:11 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:3762 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133505AbWGTP4B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Jul 2006 16:56:01 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 696DB4652A; Thu, 20 Jul 2006 17:56:00 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G3arq-0000Rh-H2; Thu, 20 Jul 2006 16:55:14 +0100
Date:	Thu, 20 Jul 2006 16:55:14 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Gary Smith <gary.smith@3phoenix.com>, linux-mips@linux-mips.org
Subject: Re: IDE on Swarm
Message-ID: <20060720155514.GD4350@networkno.de>
References: <000601c6ac09$0c262f30$6dacaac0@3PiGAS> <20060720153208.GC4350@networkno.de> <20060720153629.GH26731@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060720153629.GH26731@deprecation.cyrius.com>
User-Agent: Mutt/1.5.12-2006-07-14
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> * Thiemo Seufer <ths@networkno.de> [2006-07-20 16:32]:
> > > in Linux 2.6 during the late 2004 time-frame.  I'd like to inquire about the
> > > current availability of the IDE driver in the kernel.
> > The SWARM onboard IDE works for me with the appended patch. (Originally from
> > Peter Horton <pdh@colonel-panic.org>.)
> 
> I think the problem is that PCMCIA support was never ported to 2.6.
> Peter 'p2' De Schrijver wanted to work on this but I've no idea what
> the progress is.

AFAIU Gary used a Compact Flash connected to the onboard IDE, not a
CF -> PCMCIA Adapter.


Thiemo
