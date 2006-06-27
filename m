Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2006 05:26:05 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:21551 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133390AbWF0EZz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2006 05:25:55 +0100
Received: by mo.po.2iij.net (mo31) id k5R4PqvC013234; Tue, 27 Jun 2006 13:25:52 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id k5R4Pkxf061690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 27 Jun 2006 13:25:48 +0900 (JST)
Date:	Tue, 27 Jun 2006 13:25:46 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org, Rajesh_Palani@pmc-sierra.com
Subject: Re: [PATCH 4/6] Sequoia Serial driver
Message-Id: <20060627132546.2faf6496.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <C28979E4F697C249ABDA83AC0C33CDF8143EF8@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
References: <C28979E4F697C249ABDA83AC0C33CDF8143EF8@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hello Kiran,

You should rewrite this patch referring to 8250.c Au1000 support.
Next time, you should send serial driver patch to linux-serial@vger.kernel.org too.

On Fri, 23 Jun 2006 19:02:00 -0700
Kiran Thota <Kiran_Thota@pmc-sierra.com> wrote:


> @@ -1036,6 +1044,12 @@
>  		up->acr &= ~UART_ACR_TXDIS;
>  		serial_icr_write(up, UART_ACR, up->acr);
>  	}
> +
> +#if defined(CONFIG_PMC_INTERNAL_UART)
> +	/* kick it! */
> +	serial_out(up, UART_TX, 0);
> +#endif
> +
>  }

Is this really necessary for you?

>  
>  static void serial8250_stop_rx(struct uart_port *port)
> @@ -2158,6 +2172,10 @@
>  	int parity = 'n';
>  	int flow = 'n';
>  
> +#ifdef CONFIG_PMC_SEQUOIA
> +	baud=115200;
> +#endif
> +

Use "Default kernel command string" or Use boot parameter with your boot loader.
eg. console=ttyS0,115200

Yoichi
