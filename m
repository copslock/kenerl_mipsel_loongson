Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 15:36:29 +0100 (BST)
Received: from mail.bawue.net ([193.7.176.63]:18319 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20024285AbXJBOgT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 15:36:19 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 8778CE0047;
	Tue,  2 Oct 2007 16:36:24 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1Icir6-0003Pr-DS; Tue, 02 Oct 2007 15:36:12 +0100
Date:	Tue, 2 Oct 2007 15:36:12 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Fix a typo in an R4600 v2 erratum
	workaround
Message-ID: <20071002143612.GE16772@networkno.de>
References: <Pine.LNX.4.64N.0710021435200.32726@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710021435200.32726@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
>  Restore a load from KSEG1 done as a workaround for an R4600 v2 
> erratum, dropped with 211be16de99a7424e66c0b6c0d00e2c970508ac2.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> Thiemo,
> 
>  It reverts your change of Sep 1st, 2005; given the way the code is 
> written, I am assuming the change was accidental, correct?  At the moment 
> the load never happens.

That's correct.


Thiemo
