Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2007 09:10:08 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:17331 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021586AbXHTIKG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2007 09:10:06 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 88566B83D6;
	Mon, 20 Aug 2007 10:06:25 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IN2HL-0006L8-3O; Mon, 20 Aug 2007 09:06:27 +0100
Date:	Mon, 20 Aug 2007 09:06:27 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Carl van Schaik <carl@ok-labs.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: TLS register for NPTL
Message-ID: <20070820080627.GF4479@networkno.de>
References: <46C93BB5.9050809@ok-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46C93BB5.9050809@ok-labs.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Carl van Schaik wrote:
> Hi All,
> 
> It seems the rdhwr emulation is used/proposed for accessing the thread
> word in NPTL.
> I've been reading some of the posts from 2005 about this choice of this
> and what I have missed is anyone talking about using the "k0" register
> for TLS. It seems logical that the kernel could always restore k0 on
> returning to user-land and having k1 only for the last part of returning
> to user is sufficient. Any reason why this was not looked at?

The TLB handlers need k0/k1 as well and have no good place to save/restore
a register.


Thiemo
