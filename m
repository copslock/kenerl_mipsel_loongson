Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2009 13:05:22 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:36540 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S21366038AbZAPMvp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2009 12:51:45 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B408F3ECC; Fri, 16 Jan 2009 04:51:32 -0800 (PST)
Message-ID: <497082D1.5030504@ru.mvista.com>
Date:	Fri, 16 Jan 2009 15:51:29 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-mips@linux-mips.org, stable <stable@kernel.org>
Subject: Re: [PATCH] tx4939ide: Do not use zero count PRD entry
References: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
In-Reply-To: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> This fixes data corruption on some heavy load.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
> index bafb7d1..30d0d25 100644
> --- a/drivers/ide/tx4939ide.c
> +++ b/drivers/ide/tx4939ide.c
> @@ -259,6 +259,12 @@ static int tx4939ide_build_dmatable(ide_drive_t *drive, struct request *rq)
>  			bcount = 0x10000 - (cur_addr & 0xffff);
>  			if (bcount > cur_len)
>  				bcount = cur_len;
> +			/*
> +			 * This workaround for zero count seems required.
> +			 * (standard ide_build_dmatable do it too)
>   

    s/do/does/

> +			 */
> +			if ((bcount & 0xffff) == 0x0000)
>   

   Why not just bcount == 0x10000?

MBR, Sergei
