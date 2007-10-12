Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 18:12:28 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:42447 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20030689AbXJLRMS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 18:12:18 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	by relay01.mx.bawue.net (Postfix) with ESMTP id 5B6DF48BCA;
	Fri, 12 Oct 2007 19:11:12 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IgO2j-0007kH-1U; Fri, 12 Oct 2007 18:11:21 +0100
Date:	Fri, 12 Oct 2007 18:11:21 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <fbuihuu@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/4] tlbex.c: cleanup debug code
Message-ID: <20071012171120.GI3379@networkno.de>
References: <470F16B9.7030406@gmail.com> <470F1775.7090807@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470F1775.7090807@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> 
> Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
> ---
>  arch/mips/mm/tlbex.c |   83 +++++++++++++++----------------------------------
>  1 files changed, 26 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 923515e..4775e4c 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -705,6 +705,22 @@ il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
>  	i_bgez(p, reg, 0);
>  }
>  
> +/*
> + * For debug purposes.
> + */
> +static inline void dump_handler(const u32 *handler, int count)
> +{
> +	int i;
> +
> +	pr_debug("\t.set push\n");
> +	pr_debug("\t.set noreorder\n");
> +
> +	for (i = 0; i < count; i++)
> +		pr_debug("\t%p\t.word 0x%08x\n", &handler[i], handler[i]);
> +
> +	pr_debug("\t.set pop\n");
> +}

I don't like this patch. I wrote the code to
a) print the handler before the (potentially fatal) memcpy. Touching
   EBASE for the first time is a place where things like to go wrong.
b) avoid printing leading nops which are never executed. The trailing
   nops have less potential for confusion.


Thiemo
