Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 04:57:54 +0000 (GMT)
Received: from mo30.po.2iij.NET ([210.128.50.53]:63809 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022865AbYALE5o (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2008 04:57:44 +0000
Received: by mo.po.2iij.net (mo30) id m0C4vbYQ050847; Sat, 12 Jan 2008 13:57:37 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox305) id m0C4vXvw025439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 12 Jan 2008 13:57:34 +0900
Date:	Sat, 12 Jan 2008 13:57:33 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] Cobalt Qube1 has no serial port so don't use it
Message-Id: <20080112135733.04e8cb15.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080111232517.C7B9FC2F2B@solo.franken.de>
References: <20080111232517.C7B9FC2F2B@solo.franken.de>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


On Sat, 12 Jan 2008 00:25:17 +0100 (CET)
Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:

> Because Qube1 doesn't have a serial chip waiting for transmit fifo empty
> takes forever, which isn't a good idea. No prom_putchar/early console
> for Qube1 fixes this.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Acked-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

> ---
> 
>  arch/mips/cobalt/console.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/cobalt/console.c b/arch/mips/cobalt/console.c
> index db330e8..d1ba701 100644
> --- a/arch/mips/cobalt/console.c
> +++ b/arch/mips/cobalt/console.c
> @@ -4,10 +4,15 @@
>  #include <linux/io.h>
>  #include <linux/serial_reg.h>
>  
> +#include <cobalt.h>
> +
>  #define UART_BASE	((void __iomem *)CKSEG1ADDR(0x1c800000))
>  
>  void prom_putchar(char c)
>  {
> +	if (cobalt_board_id <= COBALT_BRD_ID_QUBE1)
> +		return;
> +
>  	while (!(readb(UART_BASE + UART_LSR) & UART_LSR_THRE))
>  		;
>  
> 
