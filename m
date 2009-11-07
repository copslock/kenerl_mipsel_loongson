Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Nov 2009 11:43:44 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:38156 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492220AbZKGKnh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Nov 2009 11:43:37 +0100
Received: by pwi15 with SMTP id 15so1133848pwi.24
        for <multiple recipients>; Sat, 07 Nov 2009 02:43:27 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=NCnW7gq4gEQHF5zert5f1feBUot9lS/yA6p2NZ+iX6A=;
        b=RZZklCfCKRJuEhOUra1sUlFazirksY2tZGqrw+yAr+Ud1H8vv76H7lmBkGx0kkINIm
         ijFGyzY/ZG4mCtOtwsrFfnlm50xFH+ORFVbeLpMzD/y4EFCd/hi9y8oaMSo9I4SjWVIo
         LX0WoHeSqxo5+XeVoKThRp6Ktgv9wCgysJUHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=oBIMNomW2I+0sr8iR6MLe9Mo39V4YMbR6xpDFIDKvpd5Jn/VvA+7GrmB0Rake+g6rp
         oNKC1Rdyb5ZSTcBQcNUnQdMNY1utPRPa5sGgSxDJWr2dGFwmarC8OQV1G1OcldvQoCR1
         jHJls+2B3Y0YOmOVON3+t1TZrTwRuYXkNUev0=
Received: by 10.115.84.39 with SMTP id m39mr8590988wal.62.1257590607837;
        Sat, 07 Nov 2009 02:43:27 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm557127pxi.3.2009.11.07.02.43.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 02:43:26 -0800 (PST)
Subject: Re: [PATCH -queue v1 6/7] [loongson] lemote-2f: add reset and
 shutdown support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, zhangfx@lemote.com,
	yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>, linux-mips@linux-mips.org
In-Reply-To: <eda10072015359ae0f3f36ea81ec1281602091a8.1257510612.git.wuzhangjin@gmail.com>
References: <cover.1257510612.git.wuzhangjin@gmail.com>
	 <17e5d58a0cd7273b81c7151b7f7f2096c9694b59.1257510612.git.wuzhangjin@gmail.com>
	 <588574ed5910292f2728072ca147add2ae342778.1257510612.git.wuzhangjin@gmail.com>
	 <7affa8fce1f55b817aff1c64f823824f6809dd85.1257510612.git.wuzhangjin@gmail.com>
	 <84e7310659ae445b3b3dc68aadc8f27648c709f6.1257510612.git.wuzhangjin@gmail.com>
	 <96301eaeffac1ae45d7529760eb961a04356dfca.1257510612.git.wuzhangjin@gmail.com>
	 <eda10072015359ae0f3f36ea81ec1281602091a8.1257510612.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Sat, 07 Nov 2009 18:43:01 +0800
Message-ID: <1257590581.2251.9.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, 2009-11-06 at 21:11 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> fuloong2f, yeeloong2f and menglong2f have different reset/shutdown
> logic, this patch add respective support for them.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/include/asm/mach-loongson/loongson.h |    7 +
>  arch/mips/loongson/lemote-2f/Makefile          |    2 +-
>  arch/mips/loongson/lemote-2f/reset.c           |  163 ++++++++++++++++++++++++
>  3 files changed, 171 insertions(+), 1 deletions(-)
>  create mode 100644 arch/mips/loongson/lemote-2f/reset.c
> 
[...]
> +
> +/* we only cope with the lemote 2f series */
> +typedef void (*mach_reset_func)(void);
> +static mach_reset_func mach_reset[][2] = {
> +	[MACH_LOONGSON_UNKNOWN]	{NULL, NULL},
> +	[MACH_LEMOTE_FL2E]	{NULL, NULL},
> +	[MACH_LEMOTE_FL2F]	{fl2f_reboot, fl2f_shutdown},
> +	[MACH_LEMOTE_ML2F7]	{ml2f_reboot, ml2f_shutdown},
> +	[MACH_LEMOTE_YL2F89]	{yl2f89_reboot, yl2f89_shutdown},
> +	[MACH_DEXXON_GDIUM2F10]	{NULL, NULL},
> +	[MACH_LOONGSON_END] {NULL, NULL},
> +};
> +

Here really waste some memory there, will replace it by the
"switch..case" statements later.

> +void mach_prepare_reboot(void)
> +{
> +	if (mach_reset[mips_machtype][0])
> +		mach_reset[mips_machtype][0]();
> +}
> +
> +void mach_prepare_shutdown(void)
> +{
> +	if (mach_reset[mips_machtype][1])
> +		mach_reset[mips_machtype][1]();
> +}

Reagrds,
	Wu Zhangjin
