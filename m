Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 13:09:05 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:37780 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028533AbcERLJDvG3W1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 May 2016 13:09:03 +0200
Received: from [172.27.0.114] (unknown [83.142.147.193])
        (Authenticated sender: slash.tmp)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id AD461200216;
        Wed, 18 May 2016 10:59:27 +0200 (CEST)
Subject: Re: [PATCH 5/9] MIPS: Loongson-1A: workaround of pll register's
 write-only property
To:     Binbin Zhou <zhoubb@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org
References: <1463569018-25189-1-git-send-email-zhoubb@lemote.com>
From:   Mason <slash.tmp@free.fr>
Message-ID: <573C4D44.1050600@free.fr>
Date:   Wed, 18 May 2016 13:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:42.0) Gecko/20100101
 Firefox/42.0 SeaMonkey/2.39
MIME-Version: 1.0
In-Reply-To: <1463569018-25189-1-git-send-email-zhoubb@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <slash.tmp@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: slash.tmp@free.fr
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 18/05/2016 12:56, Binbin Zhou wrote:

> diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
> index 24f35b6..0c3c608 100644
> --- a/arch/mips/loongson32/common/platform.c
> +++ b/arch/mips/loongson32/common/platform.c
> @@ -62,9 +62,15 @@ struct platform_device ls1x_uart_pdev = {
>  
>  void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
>  {
> -	struct clk *clk;
> +	u32 ls1x_uartclk;
>  	struct plat_serial8250_port *p;
>  
> +#ifdef CONIFG_CPU_LOONGSON1A

CONIFG? :-)
