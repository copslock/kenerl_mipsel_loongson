Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 12:59:57 +0100 (CET)
Received: from mail-ew0-f212.google.com ([209.85.219.212]:50214 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493030AbZKWL7u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 12:59:50 +0100
Received: by ewy4 with SMTP id 4so1869669ewy.27
        for <multiple recipients>; Mon, 23 Nov 2009 03:59:43 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=S5QBBynvQydx1qIQwi2MnDQQKGUyL30GnR9nZwMpDXk=;
        b=w+9IZiSlcgmkd7j5aICCmQNzF3W4ZPc+MxCTz7tPWd5k34qBqrkqrjh+l9hmBP6z/2
         cYNNQKvR94bwFWipopmnkpVk+zQZPb58n+7lYpHlb01M3qUyo7Rmafa8j97ttHhJUxcO
         OhwwIu1pb0fkxhwE7svxo8l41kvA5kds0DVUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=GwBu6lP24IHutnwn15hnKyHlCbFbW+kNoNYWjn07I4AEe8Zi4/nt/xm+fcXGB4YQE9
         r12wbANkaveu73jICE+v3E1dEbudqs5JTztVY9RcY0wVButXiZ8z0YyPKNMgyL8QV92b
         xpWZSlo77J7k38g2QKeBF9A3NUtXoqvdk/c0s=
Received: by 10.213.102.72 with SMTP id f8mr4636708ebo.26.1258977581051;
        Mon, 23 Nov 2009 03:59:41 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 13sm1999653ewy.5.2009.11.23.03.59.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 03:59:40 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: Re: [PATCH] [MIPS] Move several variables from .bss to .init.data
Date:	Mon, 23 Nov 2009 12:58:31 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-14-server; KDE/4.3.2; x86_64; ; )
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
References: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com>
In-Reply-To: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200911231258.31283.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Dmitri

On Monday 23 November 2009 12:53:37 Dmitri Vorobiev wrote:
> Several static uninitialized variables are used in the scope of
> __init functions but are themselves not marked as __initdata.
> This patch is to put those variables to where they belong and
> to reduce the memory footprint a little bit.
> 
> Also, a couple of lines with spaces instead of tabs were fixed.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>

For the ar7 bits:

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  arch/mips/ar7/platform.c        |    2 +-
>  arch/mips/sgi-ip22/ip22-eisa.c  |    4 ++--
>  arch/mips/sgi-ip22/ip22-setup.c |    2 +-
>  arch/mips/sgi-ip32/ip32-setup.c |    2 +-
>  arch/mips/sni/setup.c           |    2 +-
>  arch/mips/txx9/generic/setup.c  |    2 +-
>  arch/mips/txx9/rbtx4939/setup.c |    4 ++--
>  7 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
> index 835f3f0..85169c0 100644
> --- a/arch/mips/ar7/platform.c
> +++ b/arch/mips/ar7/platform.c
> @@ -505,7 +505,7 @@ static int __init ar7_register_devices(void)
>  	int res;
>  	u32 *bootcr, val;
>  #ifdef CONFIG_SERIAL_8250
> -	static struct uart_port uart_port[2];
> +	static struct uart_port uart_port[2] __initdata;
> 
>  	memset(uart_port, 0, sizeof(struct uart_port) * 2);
> 
> diff --git a/arch/mips/sgi-ip22/ip22-eisa.c
>  b/arch/mips/sgi-ip22/ip22-eisa.c index 1617241..da44ccb 100644
> --- a/arch/mips/sgi-ip22/ip22-eisa.c
> +++ b/arch/mips/sgi-ip22/ip22-eisa.c
> @@ -50,9 +50,9 @@
> 
>  static char __init *decode_eisa_sig(unsigned long addr)
>  {
> -        static char sig_str[EISA_SIG_LEN];
> +	static char sig_str[EISA_SIG_LEN] __initdata;
>  	u8 sig[4];
> -        u16 rev;
> +	u16 rev;
>  	int i;
> 
>  	for (i = 0; i < 4; i++) {
> diff --git a/arch/mips/sgi-ip22/ip22-setup.c
>  b/arch/mips/sgi-ip22/ip22-setup.c index b9a9313..5deeb68 100644
> --- a/arch/mips/sgi-ip22/ip22-setup.c
> +++ b/arch/mips/sgi-ip22/ip22-setup.c
> @@ -67,7 +67,7 @@ void __init plat_mem_setup(void)
>  	cserial = ArcGetEnvironmentVariable("ConsoleOut");
> 
>  	if ((ctype && *ctype == 'd') || (cserial && *cserial == 's')) {
> -		static char options[8];
> +		static char options[8] __initdata;
>  		char *baud = ArcGetEnvironmentVariable("dbaud");
>  		if (baud)
>  			strcpy(options, baud);
> diff --git a/arch/mips/sgi-ip32/ip32-setup.c
>  b/arch/mips/sgi-ip32/ip32-setup.c index c5a5d4a..3abd146 100644
> --- a/arch/mips/sgi-ip32/ip32-setup.c
> +++ b/arch/mips/sgi-ip32/ip32-setup.c
> @@ -90,7 +90,7 @@ void __init plat_mem_setup(void)
>  	{
>  		char* con = ArcGetEnvironmentVariable("console");
>  		if (con && *con == 'd') {
> -			static char options[8];
> +			static char options[8] __initdata;
>  			char *baud = ArcGetEnvironmentVariable("dbaud");
>  			if (baud)
>  				strcpy(options, baud);
> diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
> index a49272c..d16b462 100644
> --- a/arch/mips/sni/setup.c
> +++ b/arch/mips/sni/setup.c
> @@ -60,7 +60,7 @@ static void __init sni_console_setup(void)
>  	char *cdev;
>  	char *baud;
>  	int port;
> -	static char options[8];
> +	static char options[8] __initdata;
> 
>  	cdev = prom_getenv("console_dev");
>  	if (strncmp(cdev, "tty", 3) == 0) {
> diff --git a/arch/mips/txx9/generic/setup.c
>  b/arch/mips/txx9/generic/setup.c index 06e801c..2cb8c49 100644
> --- a/arch/mips/txx9/generic/setup.c
> +++ b/arch/mips/txx9/generic/setup.c
> @@ -664,7 +664,7 @@ void __init txx9_physmap_flash_init(int no, unsigned
>  long addr, };
>  	struct platform_device *pdev;
>  #ifdef CONFIG_MTD_PARTITIONS
> -	static struct mtd_partition parts[2];
> +	static struct mtd_partition parts[2] __initdata;
>  	struct physmap_flash_data pdata_part;
> 
>  	/* If this area contained boot area, make separate partition */
> diff --git a/arch/mips/txx9/rbtx4939/setup.c
>  b/arch/mips/txx9/rbtx4939/setup.c index b0c241e..64914d4 100644
> --- a/arch/mips/txx9/rbtx4939/setup.c
> +++ b/arch/mips/txx9/rbtx4939/setup.c
> @@ -379,8 +379,8 @@ static void __init rbtx4939_mtd_init(void)
>  		struct rbtx4939_flash_data data;
>  	} pdevs[4];
>  	int i;
> -	static char names[4][8];
> -	static struct mtd_partition parts[4];
> +	static char names[4][8] __initdata;
> +	static struct mtd_partition parts[4] __initdata;
>  	struct rbtx4939_flash_data *boot_pdata = &pdevs[0].data;
>  	u8 bdipsw = readb(rbtx4939_bdipsw_addr) & 0x0f;
> 

-- 
--
WBR, Florian
