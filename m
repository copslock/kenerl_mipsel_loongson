Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 15:13:41 +0100 (WEST)
Received: from h155.mvista.com ([63.81.120.155]:30982 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20022047AbZFJONd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jun 2009 15:13:33 +0100
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id DB1EE3ECD; Wed, 10 Jun 2009 07:13:28 -0700 (PDT)
Message-ID: <4A2FBFE5.2090205@ru.mvista.com>
Date:	Wed, 10 Jun 2009 18:15:01 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Alexey Zaytsev <zaytsev@altell.ru>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Make it compile.
References: <20090610140002.17913.33485.stgit@bzz.altell.local>
In-Reply-To: <20090610140002.17913.33485.stgit@bzz.altell.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alexey Zaytsev wrote:

> Signed-off-by: Alexey Zaytsev <zaytsev@altell.ru>

> diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
> index f69c6b5..222bed0 100644
> --- a/arch/mips/lib/delay.c
> +++ b/arch/mips/lib/delay.c
> @@ -51,6 +51,6 @@ void __ndelay(unsigned long ns)
>  {
>  	unsigned int lpj = current_cpu_data.udelay_val;
>  
> -	__delay((us * 0x00000005 * HZ * lpj) >> 32);
> +	__delay((ns * 0x00000005 * HZ * lpj) >> 32);

    This (and more) is already fixed by the patch posted by Atsushi Nemoto.

>  }
>  EXPORT_SYMBOL(__ndelay);

WBR, Sergei
