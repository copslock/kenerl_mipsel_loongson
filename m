Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 10:54:51 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:57826 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20039531AbWJPJyq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2006 10:54:46 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 33C234571C; Mon, 16 Oct 2006 11:54:44 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GZPBL-0002Sq-81; Mon, 16 Oct 2006 10:54:51 +0100
Date:	Mon, 16 Oct 2006 10:54:51 +0100
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
Message-ID: <20061016095451.GA9095@networkno.de>
References: <45333CC1.3090704@innova-card.com> <20061016.171046.55511403.nemoto@toshiba-tops.co.jp> <45334765.6000805@innova-card.com> <20061016.180740.88700024.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016.180740.88700024.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 16 Oct 2006 10:48:37 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > thanks but it doesn't explain anything either...Anyways what about this
> > patch on top of the previous one ?
> 
> > +	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + sizeof(u32) * 2 + 1));
> 
> This breaks the addinitrd.  You mean this perhaps?
> 
> initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + sizeof(u32) * 2)) - sizeof(u32) * 2;
> 
> 
> BTW, I'm a bit uncomfortable with current automatic initrd detection.
> Now we have rd_start= option.  If I enabled BLK_DEV_INITRD and did
> pass nfsroot= instead of rd_start= option, I want kernel do not search
> initrd_header at all.

There's "noinitrd" for that purpose. Alos, one might want to use a
built-in initrd plus nfsroot.


Thiemo
