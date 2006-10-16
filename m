Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 10:09:14 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:40138 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20039193AbWJPJJM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2006 10:09:12 +0100
Received: from lagash (88-106-179-150.dynamic.dsl.as9105.com [88.106.179.150])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 72D5344753; Mon, 16 Oct 2006 11:09:09 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GZOTL-00028C-Lc; Mon, 16 Oct 2006 10:09:23 +0100
Date:	Mon, 16 Oct 2006 10:09:23 +0100
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
Message-ID: <20061016090923.GB25607@networkno.de>
References: <11607431461469-git-send-email-fbuihuu@gmail.com> <1160743146503-git-send-email-fbuihuu@gmail.com> <45333CC1.3090704@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45333CC1.3090704@innova-card.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Atsushi,
> 
> Franck Bui-Huu wrote:
> > Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
> > ---
> [snip]
> > @@ -176,24 +174,34 @@ static unsigned long __init init_initrd(
> [snip]
> >  	end = (unsigned long)&_end;
> >  	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
> >  	if (tmp < end)
> >  		tmp += PAGE_SIZE;
> >  
> 
> Any idea on what is this code for ?
> It seems that a minimum gap is needed betweend the end of kernel
> code and initrd but I don't see why...

AFAIR the bootmem map is placed there.


Thiemo
