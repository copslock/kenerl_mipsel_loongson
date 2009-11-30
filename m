Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 06:23:30 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:46492 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491063AbZK3FX1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 06:23:27 +0100
Received: by pzk35 with SMTP id 35so2309384pzk.22
        for <multiple recipients>; Sun, 29 Nov 2009 21:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=fAKhuuVj1/I/dmptQF1uUdQB+rfkh9pKXS2QVv30ifs=;
        b=B8SLZvjKYvMB5pPT3JwFgBJAXyHV+OpQBYP8XCGDEipLO9ts4TQG7WTPzCgmyRpFFa
         myXs1LJl21BJRuXigxbxjJShdXJzf4AE/mYQJlGTDoUFQpLF2dQNIXaJeH/ZuevPt8QV
         1hjwzHgboviNsFcsUD1f4bDr70CsgTKTaBx+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=bxGVJIrkHu+1xeAsHQQ8yy5lW+Rk5KQiNTd9S/NT5R1q5tpFV7ErKHmPVydPDHBO/+
         utM2kIIDiJikRT+bERPLKHn60R5GqmNoqjRIidn5bxpyHHBYktOw+FNivw7DoyJghrmI
         kEDx7doQnSMFDSoX0krze6APoIIsoYepzzAhE=
Received: by 10.115.65.11 with SMTP id s11mr6481014wak.170.1259558600954;
        Sun, 29 Nov 2009 21:23:20 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm2656664pxi.1.2009.11.29.21.23.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 21:23:20 -0800 (PST)
Subject: Re: [PATCH v5 3/8] Loongson: YeeLoong: add backlight driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, Richard Purdie <rpurdie@rpsys.net>
In-Reply-To: <23a22d9d675a53c962500ee88db7f6cd2192e8db.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <23a22d9d675a53c962500ee88db7f6cd2192e8db.1259414649.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 30 Nov 2009 13:22:53 +0800
Message-ID: <1259558573.5516.11.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-11-28 at 21:36 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds YeeLoong Backlight Driver, which provides standard
> interface for user-space applications to control the brightness of the
> backlight.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 ++-
>  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    2 +
>  .../loongson/lemote-2f/yeeloong_laptop/backlight.c |   93 ++++++++++++++++++++
>  .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |    1 +
>  4 files changed, 104 insertions(+), 1 deletions(-)
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/backlight.c
> 
> diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> index d6df9b7..02d36d8 100644
> --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> @@ -10,6 +10,13 @@ menuconfig LEMOTE_YEELOONG2F
>  
>  if LEMOTE_YEELOONG2F
>  
> -
> +config YEELOONG_BACKLIGHT
> +	tristate "Backlight Driver"
> +	select BACKLIGHT_CLASS_DEVICE

Will use "depend" instead in the next version.

Best Regards,
	Wu Zhangjin
