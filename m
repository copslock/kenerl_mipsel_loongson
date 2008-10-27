Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 14:07:46 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:64406 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22505383AbYJ0OHe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 14:07:34 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CBB533ECB; Mon, 27 Oct 2008 07:07:25 -0700 (PDT)
Message-ID: <4905CB09.5020805@ru.mvista.com>
Date:	Mon, 27 Oct 2008 17:07:05 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH 1/2] tx4938ide: Check minimum cycle time and SHWT range
References: <20081027.223913.128619425.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081027.223913.128619425.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> SHWT value is used as address valid to -CSx assertion and -CSx to -DIOx
> assertion setup time, and contrarywise, -DIOx to -CSx release and -CSx
> release to address invalid hold time, so it actualy applies 4 times and
> so constitutes -DIOx recovery time.  Check requirement of the recovery
> time and cycle time.  Also check SHWT maximum value.

> Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

> diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
> index fa660f9..7e4820e 100644
> --- a/drivers/ide/tx4938ide.c
> +++ b/drivers/ide/tx4938ide.c
> @@ -39,10 +39,17 @@ static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
>  	/* Address-valid to DIOR/DIOW setup */
>  	shwt = DIV_ROUND_UP(t->setup, cycle);
>  
> +	/* -DIOx recovery time (SHWT * 4) and cycle time requirement */
> +	while (shwt * cycle * 4 + t->act8b < t->cycle)

    This can lead to adding an extra setup cycle due to use of "non-quantized" 
active time, here's more precise expression for the cycle time:

    (shwt * 4 + wt + (wt ? 2 : 3)) * cycle

or even this, more obsure:

    (shwt * 4 + wt + !wt + 2) * cycle

MBR, Sergei
