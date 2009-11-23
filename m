Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 02:30:20 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:40064 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493132AbZKWBaO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 02:30:14 +0100
Received: by pwi15 with SMTP id 15so3261461pwi.24
        for <multiple recipients>; Sun, 22 Nov 2009 17:30:07 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=MwOjtm5ObRL8Fwf8uTNSEdCygAJol9hfA6XjRgHwvZ4=;
        b=agAH1La7JyNrX9BpVmIUm26kMwW9u8tLE5dxA0wjG1D5OPwhBz2dy4KaoDM5zAN29f
         iex/S2j+7bRY1A8kFA3xF2ltDLdJwIsg66wMvGKy35eEJtVPCKsnxRuh7q2MzI3ulFTD
         2AGGi1ixmgLpZFPPmKiBvJYb0pkgtalQTnQmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Vet8GLuNk+OUG7Zm4+ffBbZQpy8rr5gZR9q2gSo+lBoYPlhMGxhjeYamHInu3Vdr1w
         0D7L6z8CgREx8Iz9S3/2yRNxqxhfB0yr+DyUmKE4n+bCGWLVl5rSENSSiqu5I4h2rB9K
         wn12IUfnwI9y+IqetSVhChxNpDa2OYtA7N0lM=
Received: by 10.114.30.7 with SMTP id d7mr7474413wad.30.1258939807732;
        Sun, 22 Nov 2009 17:30:07 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm2741571pzk.2.2009.11.22.17.30.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 17:30:07 -0800 (PST)
Subject: Re: [PATCH v1 1/4] [loongson] Remove the inline annotation of
 prom_init_uart_base()
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <cd8541a74bab41734a44dfedcbc63688d165e35e.1258800842.git.wuzhangjin@gmail.com>
References: <cover.1258800842.git.wuzhangjin@gmail.com>
	 <cd8541a74bab41734a44dfedcbc63688d165e35e.1258800842.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Mon, 23 Nov 2009 09:29:56 +0800
Message-ID: <1258939796.2411.13.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

This one is also urgent, could you please fold it into "MIPS: Loongson:
Cleanup the serial port support"? thanks!

Best Regards,
	Wu Zhangjin

On Sat, 2009-11-21 at 19:05 +0800, Wu Zhangjin wrote:
> gcc 3.4.6 complains about un-implemented prom_init_uart_base() if using
> inline to annotate prom_init_uart_base(), so, remove the inline here.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/include/asm/mach-loongson/loongson.h |    2 +-
>  arch/mips/loongson/common/uart_base.c          |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
> index daf7041..a7fa66e 100644
> --- a/arch/mips/include/asm/mach-loongson/loongson.h
> +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> @@ -33,7 +33,7 @@ extern void __init prom_init_machtype(void);
>  extern void __init prom_init_env(void);
>  extern unsigned long _loongson_uart_base;
>  extern unsigned long uart8250_base[];
> -extern inline void __maybe_unused prom_init_uart_base(void);
> +extern void prom_init_uart_base(void);
>  
>  /* irq operation functions */
>  extern void bonito_irqdispatch(void);
> diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
> index 275bed6..1d636f4 100644
> --- a/arch/mips/loongson/common/uart_base.c
> +++ b/arch/mips/loongson/common/uart_base.c
> @@ -29,7 +29,7 @@ unsigned long __maybe_unused uart8250_base[] = {
>  };
>  EXPORT_SYMBOL(uart8250_base);
>  
> -inline void __maybe_unused prom_init_uart_base(void)
> +void __maybe_unused prom_init_uart_base(void)
>  {
>  	_loongson_uart_base =
>  		(unsigned long)ioremap_nocache(uart8250_base[mips_machtype], 8);
