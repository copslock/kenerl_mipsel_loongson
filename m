Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 06:19:40 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:51850 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491061AbZK3FTh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 06:19:37 +0100
Received: by pzk35 with SMTP id 35so2307511pzk.22
        for <multiple recipients>; Sun, 29 Nov 2009 21:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=2NyaY6BaeVg3ewZsZxQ9SmxE6DpHwwdO3a3CV4lVBAM=;
        b=JvvnjHYXrakOZAc5Nu5G295JdZLd0zu5NDmUDG4NsAIlCKldk/dznG3+0cs/HcK/NN
         tPQVmhA61TymJqz0GF+ij+VNlPz6pMBsrxEQnOCCZRURpzJ57uXvWhOhz425abLTks04
         EhLSZjY4PHeW8+Nwyloo7DIEklyyyMe82i/qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=E8VDRXxsKVSZ7pgl1Qjcz/pPkowU/DK/wLuaF5N/qpUgjPdKVjCawpR4kB6kOfJ6GC
         Zs3fj/O5xeMlcoBVNVOpz/xy6d2+TSMSFOgcoCwm56i662VaztE88RPzjLdWlwQ7jJnN
         v3CxJRmiaQsmFDZAYyjGsgoo9hA+cdEG7M2qQ=
Received: by 10.114.162.4 with SMTP id k4mr6443244wae.149.1259558370065;
        Sun, 29 Nov 2009 21:19:30 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm2650547pxi.6.2009.11.29.21.19.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 21:19:29 -0800 (PST)
Subject: Re: [PATCH v5 6/8] Loongson: YeeLoong: add video output driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, luming.yu@intel.com
In-Reply-To: <dc116705b7d610d48b7d77ebd6365c5f05ad8ab7.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <dc116705b7d610d48b7d77ebd6365c5f05ad8ab7.1259414649.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 30 Nov 2009 13:19:06 +0800
Message-ID: <1259558346.5516.6.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-11-28 at 21:41 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds Video Output Driver, which provides standard interface
> to turn on/off the video output of LCD, CRT.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    8 +
>  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
>  .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |    3 +
>  .../lemote-2f/yeeloong_laptop/video_output.c       |  164 ++++++++++++++++++++
>  4 files changed, 176 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/video_output.c
> 
> diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> index 56cb584..c4398ff 100644
> --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> @@ -37,4 +37,12 @@ config YEELOONG_HWMON
>  	  interface for lm-sensors to monitor the temperatures of CPU and
>  	  battery, the PWM of fan, the current, voltage of battery.
>  
> +config YEELOONG_VO
> +	tristate "Video Output Driver"
> +	select VIDEO_OUTPUT_CONTROL

Will use "depend" instead in the next version.

Regards,
	Wu Zhangjin
