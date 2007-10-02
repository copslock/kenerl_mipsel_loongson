Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 21:15:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56785 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022930AbXJBUPC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Oct 2007 21:15:02 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l92KF1w8025138;
	Tue, 2 Oct 2007 21:15:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l92KEwhE025132;
	Tue, 2 Oct 2007 21:14:58 +0100
Date:	Tue, 2 Oct 2007 21:14:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2/4] move Cobalt UART base definition to
	arch/mips/cobalt/console.c
Message-ID: <20071002201458.GA16476@linux-mips.org>
References: <20071002225441.63d935eb.yoichi_yuasa@tripeaks.co.jp> <20071002231317.0fbaf7bb.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071002231317.0fbaf7bb.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 02, 2007 at 11:13:17PM +0900, Yoichi Yuasa wrote:

> diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/console.c mips/arch/mips/cobalt/console.c
> --- mips-orig/arch/mips/cobalt/console.c	2007-09-30 21:21:39.610319250 +0900
> +++ mips/arch/mips/cobalt/console.c	2007-09-30 21:26:10.135226000 +0900
> @@ -1,16 +1,15 @@
>  /*
>   * (C) P. Horton 2006
>   */
> +#include <linux/io.h>
>  #include <linux/serial_reg.h>
>  
> -#include <asm/addrspace.h>
> -
> -#include <cobalt.h>
> +#define UART_BASE	((void __iomem *)CKSEG1ADDR(0x1c800000))
>  
>  void prom_putchar(char c)
>  {
> -	while(!(COBALT_UART[UART_LSR] & UART_LSR_THRE))
> +	while(!(readb(UART_BASE + UART_LSR) & UART_LSR_THRE))
            ^^^
          missing space.

Aside of that looks ok, so I fixed that up and queued all four patches
for 2.6.24.

Thanks,

  Ralf
