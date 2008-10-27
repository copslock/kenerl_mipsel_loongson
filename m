Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 23:12:29 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:50088 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22530895AbYJ0XMV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 23:12:21 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C5B033ECA; Mon, 27 Oct 2008 16:12:16 -0700 (PDT)
Message-ID: <49064ACA.20200@ru.mvista.com>
Date:	Tue, 28 Oct 2008 02:12:10 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] tx4938ide: Check minimum cycle time and SHWT range
References: <20081027.223913.128619425.anemo@mba.ocn.ne.jp>	<4905CB09.5020805@ru.mvista.com> <20081027.235224.82088530.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081027.235224.82088530.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Subject: [PATCH] tx4938ide: Check minimum cycle time and SHWT range (v2)
>
> SHWT value is used as address valid to -CSx assertion and -CSx to -DIOx
> assertion setup time, and contrarywise, -DIOx to -CSx release and -CSx
> release to address invalid hold time, so it actualy applies 4 times and
> so constitutes -DIOx recovery time.  Check requirement of the recovery
> time and cycle time.  Also check SHWT maximum value.
>
> Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
> index a0d10a9..796289c 100644
> --- a/drivers/ide/tx4938ide.c
> +++ b/drivers/ide/tx4938ide.c
> @@ -39,10 +39,17 @@ static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
>  	/* Address-valid to DIOR/DIOW setup */
>  	shwt = DIV_ROUND_UP(t->setup, cycle);
>  
> +	/* -DIOx recovery time (SHWT * 4) and cycle time requirement */
> +	while ((shwt * 4 + wt + (wt ? 2 : 3)) * cycle < t->cycle)
>   

   Besides, it's worth making 'wt' variable signed, otherwise you're 
risking underflow when subtracting 2 above...

WBR, Sergei
