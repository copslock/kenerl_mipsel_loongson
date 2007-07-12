Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 18:22:31 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:30622 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022624AbXGLRW3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2007 18:22:29 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 8CF57B8BD8;
	Thu, 12 Jul 2007 19:21:53 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1I92MS-0004te-6K; Thu, 12 Jul 2007 18:21:52 +0100
Date:	Thu, 12 Jul 2007 18:21:52 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Mike Crowe <mac@mcrowe.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Strange gp corruption problem
Message-ID: <20070712172152.GC30622@networkno.de>
References: <20070712170624.GA31776@mcrowe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070712170624.GA31776@mcrowe.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Mike Crowe wrote:
[snip]
> We have a function that does some string manipulation (not
> particularly dangerous manipulation and I've been through it
> carefully) and then calls atol. As expected the prologue of this
> function calculates the value of the gp register by applying an offset
> to the t9 register which contains the address of the start of the
> function like this:
> 
>  47995c:       3c1c0fba        lui     gp,0xfba

Looks weird as an entry point. Normally entries are 8 byte aligned.

[snip]
> The only user-space reason I can come up with for this happening is if
> the caller jumped into this function one instruction late. This seems
> unlikely because t9 contains the correct value and the stack looks
> fine.

Check the value of $ra (e.g. with a gdb breakpoint) after entering the
function.


Thiemo
