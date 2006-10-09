Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 14:21:38 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:10734 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038606AbWJINVc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2006 14:21:32 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 300FF445CA; Mon,  9 Oct 2006 15:21:29 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GWv4W-0006v2-Bj; Mon, 09 Oct 2006 14:21:32 +0100
Date:	Mon, 9 Oct 2006 14:21:32 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
Message-ID: <20061009132131.GA18308@networkno.de>
References: <45265BF0.8080103@innova-card.com> <20061006172153.GB4456@networkno.de> <452A3953.4060802@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452A3953.4060802@innova-card.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Thiemo Seufer wrote:
> > Franck Bui-Huu wrote:
> >>
> >> -	if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
> >> +	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> > 
> > ISTR this failed on O2, where kernel+initrd are loaded into KSEG0 but the
> > PAGE_OFFSET is for XKPHYS.
> > 
> 
> I guess that you were meaning somthing like:
> 
> LOADADDR    = 0xffffffff80004000
> PAGE_OFFSET = 0xa800000000000000
> 
> is that correct ?

Yes.

> If so could you explain the choice of these values
> because I fail to understand it.

It allows to load a 64-bit kernel in KSEG0, and use short 2-instruction
symbol references there. At the same time, it allows access to more
address space for memory and I/O than would fit in KSEG0.


Thiemo
