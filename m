Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 06:22:38 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:59721 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491065AbZK3FWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 06:22:35 +0100
Received: by pwi15 with SMTP id 15so2039697pwi.24
        for <multiple recipients>; Sun, 29 Nov 2009 21:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=3H6w4zgJ0U8dlMvxBawWd3/pkG8m0ePUHQcI+ARZgNg=;
        b=H0I7v9NuXH+UTThogz4IMv1Mph3vCdpyTa1FWtRxw1XVDPlDWnwq/aLryBq6vM36Bm
         pIO9uMteoTiHSbIxtOW2JPfV7DP3sLuiPMdbf8tQEWQ4UzicqFdg0mC2Kpf1BtgW3QWp
         ZdvehHWjGeGjuXmgpcCeY7bpMMCnex5gm9RdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Gl/Mf82OLW+WaET90UxXRE6npgVlaN7c99SHMbKldUY+HqxpVE8UIULAmFZtxLpPnB
         BkiU4Seo3Bla+sra2/LgdOBAi5Ocjwl7mKEpxk9W6kPX+ZlqINGkUBM/oeNPSXtBMX+7
         Ehi7BoQbf1F2YLc+c8lc6RF+7EhWHydRm8i3E=
Received: by 10.114.186.29 with SMTP id j29mr6530296waf.4.1259558547208;
        Sun, 29 Nov 2009 21:22:27 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2717533pxi.11.2009.11.29.21.22.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 21:22:26 -0800 (PST)
Subject: Re: [PATCH v5 4/8] Loongson: YeeLoong: add battery driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, Jamey Hicks <jamey@crl.dec.com>,
        Stephen Rothwell <sfr@linuxcare.com>
In-Reply-To: <19f58dc908637c2e1216b9a644dba58ebc20b73f.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <19f58dc908637c2e1216b9a644dba58ebc20b73f.1259414649.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 30 Nov 2009 13:22:06 +0800
Message-ID: <1259558526.5516.10.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-11-28 at 21:37 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds APM_EMULATION based Battery Driver, which provides
> standard interface for user-space applications to manage the battery.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 ++
>  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
>  .../loongson/lemote-2f/yeeloong_laptop/battery.c   |  127 ++++++++++++++++++++
>  3 files changed, 137 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/battery.c
> 
> diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> index 02d36d8..e284c91 100644
> --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> @@ -19,4 +19,13 @@ config YEELOONG_BACKLIGHT
>  	  interface for user-space applications to control the brightness of
>  	  the backlight.
>  
> +config YEELOONG_BATTERY
> +	tristate "Battery Driver"
> +	select SYS_SUPPORTS_APM_EMULATION
> +	select APM_EMULATION

Will use "depend" on APM_EMULATION instead in the next version, and put
this line "select SYS_SUPPORTS_APM_EMULATION" under the
LEMOTE_YEELOONG2F.

Regards,
	Wu Zhangjin
