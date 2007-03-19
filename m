Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 14:14:51 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:43482 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021845AbXCSOOq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 14:14:46 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 5F6E4BB79F;
	Mon, 19 Mar 2007 15:07:22 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HTIWQ-0008SP-5f; Mon, 19 Mar 2007 14:07:38 +0000
Date:	Mon, 19 Mar 2007 14:07:38 +0000
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>,
	Arnaud Giersch <arnaud.giersch@free.fr>
Subject: Re: IP32 prom crashes due to __pa() funkiness
Message-ID: <20070319140738.GA28895@networkno.de>
References: <45D8B070.7070405@gentoo.org> <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com> <45FC46F0.3070300@gentoo.org> <87irczzglc.fsf@groumpf.homeip.net> <45FC9E39.7010506@gentoo.org> <45FE95EE.5030108@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45FE95EE.5030108@innova-card.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
[snip]
> > Now I guess we're back to CONFIG_BUILD_ELF64=n?  I guess the real
> > question is, which way is the OneWay(TM), RightWay(TM) and OnlyWay(TM)?
> 
> Now it's clear that CONFIG_BUILD_ELF64 is really confusing. I would say
> that whatever the value of CONFIG_BUILD_ELF64, your kernel should run
> fine. BUT it really depends on your kernel load address:
> 
> if CONFIG_BUILD_ELF64=y then kernel load address must be in XKPHYS
> if CONFIG_BUILD_ELF64=n then kernel load address must be in CKSEG0
> 
> All others configs (I think) are buggy...

Why? A ELF64 kernel for CKSEG0 should be fine, at least in principle,
even if it doesn't work wih the current codebase.

> That's said, it seems that IPxx kernels are really special
> beasts. Take from MIPS makefile:
> 
> """
> Some machines like the Indy need 32-bit ELF binaries for booting
> purposes.
> """

This is true for netbooting via firmware. For booting from disk the
bootloaders support AFAIR ELF64-for-CKSEG0.


Thiemo
