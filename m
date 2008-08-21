Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 14:46:08 +0100 (BST)
Received: from yx-out-1718.google.com ([74.125.44.154]:62253 "EHLO
	yx-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20031894AbYHUNqB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 14:46:01 +0100
Received: by yx-out-1718.google.com with SMTP id 36so404140yxh.24
        for <linux-mips@linux-mips.org>; Thu, 21 Aug 2008 06:45:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :in-reply-to:references:x-mailer:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=LdrAuF0RvIWlqB82Bcn8PdB8BS4h2ovesoxUh3e9jj0=;
        b=rvpV43qWx5rUGyAJ6E8r/ZGGeMlRyVJg0JFlVhXFGEUMcuv4YRfCVFIZKckeAqJQdn
         zQvsah8o9E2uEME9C/ZLGHOOPSnz+/7SU+ImWTS0vqM+SZCgYYU+F+dE3PpxPvwrXEHx
         jsOUlOZBiqnGrM201oaANBw6+jVUnQTW7Z9zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=iQqkNAkKtFtrQ9eUiFqk/6dYAP1kpiB2siiY8pL3DoAFbcUSBPOosN7sR8hHmmQH5I
         SHuLvOUQpgHcMQ+ejLmhRJIqcKVGKxF7bOIb6V+WEgu14C/4nTX3j+TBBMoM7H9IBlAj
         FFILALeOG2094ass0ql87hdRLc+JcU4QI5x6c=
Received: by 10.114.103.1 with SMTP id a1mr1365323wac.82.1219326358200;
        Thu, 21 Aug 2008 06:45:58 -0700 (PDT)
Received: from delta ( [125.30.7.41])
        by mx.google.com with ESMTPS id 5sm3625702yxt.1.2008.08.21.06.45.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 06:45:57 -0700 (PDT)
Date:	Thu, 21 Aug 2008 22:45:52 +0900
From:	Yoichi Yuasa <tripeaks@gmail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	tripeaks@gmail.com, "linux-mips" <linux-mips@linux-mips.org>,
	ralf@linux-mips.org
Subject: Re: [PATCH] cobalt: group UART definition into header
In-Reply-To: <200808211303.44865.florian@openwrt.org>
References: <200808211303.44865.florian@openwrt.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <48ad7195.c505be0a.3500.4a15@mx.google.com>
Return-Path: <tripeaks@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tripeaks@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 21 Aug 2008 13:03:44 +0200
Florian Fainelli <florian@openwrt.org> wrote:

> This patch groups the UART base address definition into
> the cobalt.h header file making it easier to reuse
> this code.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/cobalt/console.c b/arch/mips/cobalt/console.c
> index d1ba701..48e2094 100644
> --- a/arch/mips/cobalt/console.c
> +++ b/arch/mips/cobalt/console.c
> @@ -6,7 +6,7 @@
>  
>  #include <cobalt.h>
>  
> -#define UART_BASE	((void __iomem *)CKSEG1ADDR(0x1c800000))
> +#define UART_BASE	((void __iomem *)CKSEG1ADDR(COBALT_UART_ADDR))
>  
>  void prom_putchar(char c)
>  {
> diff --git a/arch/mips/cobalt/serial.c b/arch/mips/cobalt/serial.c
> index 53b8d0d..d12202e 100644
> --- a/arch/mips/cobalt/serial.c
> +++ b/arch/mips/cobalt/serial.c
> @@ -28,8 +28,8 @@
>  
>  static struct resource cobalt_uart_resource[] __initdata = {
>  	{
> -		.start	= 0x1c800000,
> -		.end	= 0x1c800007,
> +		.start	= COBALT_UART_ADDR,
> +		.end	= COBALT_UART_ADDR + 0x7,
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	{
> @@ -45,7 +45,7 @@ static struct plat_serial8250_port cobalt_serial8250_port[] = {
>  		.uartclk	= 18432000,
>  		.iotype		= UPIO_MEM,
>  		.flags		= UPF_IOREMAP | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
> -		.mapbase	= 0x1c800000,
> +		.mapbase	= COBALT_UART_ADDR,
>  	},
>  	{},
>  };
> diff --git a/include/asm-mips/mach-cobalt/cobalt.h b/include/asm-mips/mach-cobalt/cobalt.h
> index 5b9fce7..9bf9e94 100644
> --- a/include/asm-mips/mach-cobalt/cobalt.h
> +++ b/include/asm-mips/mach-cobalt/cobalt.h
> @@ -19,4 +19,6 @@ extern int cobalt_board_id;
>  #define COBALT_BRD_ID_QUBE2    0x5
>  #define COBALT_BRD_ID_RAQ2     0x6
>  
> +#define COBALT_UART_ADDR	0x1c800000
> +

NAK

This value is only used in serial.c.
Please define in serial.c.

Yoichi
