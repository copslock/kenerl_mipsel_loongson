Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 17:53:30 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32938 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028619AbcERPxZwUOp8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 17:53:25 +0200
Received: by mail-wm0-f67.google.com with SMTP id r12so13988214wme.0;
        Wed, 18 May 2016 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=jYfrO4cGGMyXutkyzeZ/8pwvh0Bz9d05isHak05gIdI=;
        b=n0uojTE2QZ9tGAdtgQEgyGqn/4tqfchGKis57y7Fz0puojTKwJe2y7QhPuZlKWA4ZY
         SsljtyfLjemXjxlyVcvCZuTbzV+2iwvr13aCWmrl0V7SG5sCnsnIW7EmgTZElxZ6lDQo
         LKchXSML6GZVS3mhqp3y/JPFhkgNpGfjExSxWw+bTxTz+nS0iaoU1bOKrccGksq7xrY2
         P2k6r/ER7kNO+IVjL3I14nRUG+MXn6V0uWjILSMOomn/6UghMibmrfSeceuixsf1MqMQ
         46mNqhw2IlTXoNiNg3ETVJCEH99898VW+jVN7S6OhfK/QFNOIRvi1xpNPeVJl8Y606ei
         3z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jYfrO4cGGMyXutkyzeZ/8pwvh0Bz9d05isHak05gIdI=;
        b=caxBesF2Zb5Oytxw8/tjUA6tgNHYhoQ7ZMkzdWu4FwMrrs/OAiB/roO/86uWVyKKj0
         AL0VwOieqiJtjDM9uxYNZ5TkUitkVIFuIbT8AjkAwSzu0HNSp+BnG6KTYFLU8/wH0poe
         DoMeJCFzFPIAG5qKNrrkIXofvMurmaCovJr1KfG28+Dvk8PigxSdrdt95nqxDyiIfHhl
         UsB7Ov5jlpKeP02OJh6M7hLb32vZEGjYKbPmAiDbTQosSFKiaa7JpMlk3eIx2TQhxiTf
         NTqRD9lHvy8UVCrXra/T7ZND369KlW1OmcenZeZAi9Yfi4a5s03zOlO5rARJxn+AYRh4
         W36g==
X-Gm-Message-State: AOPr4FWn2n6qAdKIg4h/V0sxHsR9vgSC+BiCOEFGi1jUe0Iuri1eWPs7oxBBcoyXj0uB/NwM0unqMEWeKA//Gg==
MIME-Version: 1.0
X-Received: by 10.28.18.11 with SMTP id 11mr7954279wms.51.1463586800602; Wed,
 18 May 2016 08:53:20 -0700 (PDT)
Received: by 10.194.246.66 with HTTP; Wed, 18 May 2016 08:53:20 -0700 (PDT)
In-Reply-To: <1463568601-25042-7-git-send-email-zhoubb@lemote.com>
References: <1463568601-25042-1-git-send-email-zhoubb@lemote.com>
        <1463568601-25042-7-git-send-email-zhoubb@lemote.com>
Date:   Wed, 18 May 2016 23:53:20 +0800
Message-ID: <CAJhJPsU4d2RbWO0k1mY49v3sU_hP9kBtWj2YL7Dek8MuPVf0Fw@mail.gmail.com>
Subject: Re: [PATCH 8/9] MIPS: Loongson-1B: Update config file
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     Binbin Zhou <zhoubb@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

2016-05-18 18:50 GMT+08:00, Binbin Zhou <zhoubb@lemote.com>:
> CONFIG_LOONGSON1_LS1B=y is needed to be set.
>
> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/configs/loongson1b_defconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/mips/configs/loongson1b_defconfig
> b/arch/mips/configs/loongson1b_defconfig
> index c442f27..476f52b 100644
> --- a/arch/mips/configs/loongson1b_defconfig
> +++ b/arch/mips/configs/loongson1b_defconfig
> @@ -1,4 +1,5 @@
>  CONFIG_MACH_LOONGSON32=y
> +CONFIG_LOONGSON1_LS1B=y
>  CONFIG_PREEMPT=y
>  # CONFIG_SECCOMP is not set
>  # CONFIG_LOCALVERSION_AUTO is not set
> @@ -43,7 +44,6 @@ CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_NAND=y
> -CONFIG_MTD_NAND_LOONGSON1=y

Please restore this line.

>  CONFIG_MTD_UBI=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_SCSI=m
> @@ -72,7 +72,6 @@ CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_GPIOLIB=y
> -CONFIG_GPIO_LOONGSON1=y

ditto

>  # CONFIG_HWMON is not set
>  # CONFIG_VGA_CONSOLE is not set
>  CONFIG_HID_GENERIC=m
> --
> 1.9.1
>
>
>
>


-- 
Best regards,

Kelvin Cheung
