Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2005 11:12:14 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:13343 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133638AbVJ1KL5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Oct 2005 11:11:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9SAC2xR004673;
	Fri, 28 Oct 2005 11:12:02 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9SAC2OD004671;
	Fri, 28 Oct 2005 11:12:02 +0100
Date:	Fri, 28 Oct 2005 11:12:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Arthur Othieno <a.othieno@bluewin.ch>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: prom_free_prom_memory() returns `unsigned long'
Message-ID: <20051028101202.GA2935@linux-mips.org>
References: <20051028044256.GA14758@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028044256.GA14758@krypton>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 28, 2005 at 12:42:56AM -0400, Arthur Othieno wrote:

> Some boards have, eg.:
> 
>   arch/mips/momentum/ocelot_3/prom.c:242:void __init prom_free_prom_memory(void)
> 
> yet free_initmem() expects a return:
> 
>   arch/mips/mm/init.c:285:extern unsigned long prom_free_prom_memory(void);
>   arch/mips/mm/init.c:291:	freed = prom_free_prom_memory();
> 
> Fix those up and return 0 instead, just like everyone else does.

Thanks alot, applied.

  Ralf
