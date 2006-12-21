Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2006 16:46:52 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:19934 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S28644165AbWLUQqq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2006 16:46:46 +0000
Received: from lagash (p54A47735.dip.t-dialin.net [84.164.119.53])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 941DA845A0;
	Thu, 21 Dec 2006 17:41:18 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GxQzY-0000bs-UT; Thu, 21 Dec 2006 16:42:00 +0000
Date:	Thu, 21 Dec 2006 16:42:00 +0000
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix build_store_reg()
Message-ID: <20061221164200.GE30873@networkno.de>
References: <20061218.003821.96686517.anemo@mba.ocn.ne.jp> <20061222.010316.63742169.anemo@mba.ocn.ne.jp> <20061222.013031.89066226.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222.013031.89066226.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 22 Dec 2006 01:03:16 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > BTW, why prefetch is preferred than cache_cdex?  I feel cdex is better
> > while it avoids unnecessary load...
> 
> Oh, I missed that Pref_StoreStreamed or Pref_PrepareForStore is used
> for destination.  Perhaps they would be better than cdex (though not
> sure...).

StoreStreamed doesn't avoid the reload, but PrepareForStore does.


Thiemo
