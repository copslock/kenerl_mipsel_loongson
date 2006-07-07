Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 08:43:21 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:59371 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133361AbWGGHnL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2006 08:43:11 +0100
Received: from lagash (88-106-172-167.dynamic.dsl.as9105.com [88.106.172.167])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id D73A44542A; Fri,  7 Jul 2006 09:43:10 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1Fyk6Y-00045e-Jx; Fri, 07 Jul 2006 07:46:22 +0100
Date:	Fri, 7 Jul 2006 07:46:22 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix rdhwr_op definition
Message-ID: <20060707064622.GB4274@networkno.de>
References: <20060707.142641.122254596.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707.142641.122254596.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>
> diff --git a/include/asm-mips/inst.h b/include/asm-mips/inst.h
> index 1ed8d0f..6489f00 100644
> --- a/include/asm-mips/inst.h
> +++ b/include/asm-mips/inst.h
> @@ -74,7 +74,7 @@ enum spec3_op {
>  	ins_op, dinsm_op, dinsu_op, dins_op,
>  	bshfl_op = 0x20,
>  	dbshfl_op = 0x24,
> -	rdhwr_op = 0x3f
> +	rdhwr_op = 0x3b

Correct, thanks for catching this.


Thiemo
