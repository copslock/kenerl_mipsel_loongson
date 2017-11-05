Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Nov 2017 15:13:07 +0100 (CET)
Received: from conssluserg-06.nifty.com ([210.131.2.91]:63613 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbdKEONAMnvg7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Nov 2017 15:13:00 +0100
Received: from mail-yw0-f174.google.com (mail-yw0-f174.google.com [209.85.161.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id vA5ECJVT001902;
        Sun, 5 Nov 2017 23:12:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com vA5ECJVT001902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1509891140;
        bh=pU5AgvxWsGuJew1bd4ieQiSPZXrZbDrmYcWQ/960Ces=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=nKOlaYZrSzBTpbPbEaKRvQS6wYjn1LoXCyBE+ydwUxpyepaMbyGmVEHnreA/5Lm93
         AUaVtuiB5xhMI772M7MiiP5KWRsGOe/T+NWOLSVPM/UXa585Q1/6ip45lax7oyUOWg
         gobP+NTMgQneyzGGk7gH9RGEopdDl12MEpuFn9tswXhWfdr0EBYUtsjX0RLYzYKPdZ
         6IfKPNLd1BWwfnfQ2bzWnRbrnofkXKMK5eu53/grsSeR59OWtlexER5Q2LoKZ/Svvw
         LtTNLK3dJSR2hZiBPqPokiAx5bz3OWnDhvtfeWy7EAx4SoiCWxbSU+h8oQrwr88R2y
         ql7wYs1ZwePLA==
X-Nifty-SrcIP: [209.85.161.174]
Received: by mail-yw0-f174.google.com with SMTP id l32so5879026ywh.13;
        Sun, 05 Nov 2017 06:12:19 -0800 (PST)
X-Gm-Message-State: AMCzsaXzemOLoumsL5q5QVhP3uNrGLn31SEg//dORICugNUVEbmgZGIG
        uzH0XuVqZzh85GnK0K27XrPVaIQmvS/NPh0rWn4=
X-Google-Smtp-Source: ABhQp+QIl4OuuDZo9M9tPwunE+cTiSxY0+RXjJxw3cG9O6fEtDAIXf4klW6nSwapsLFGmg7N2GtbkfsK667QvN62Vok=
X-Received: by 10.37.70.134 with SMTP id t128mr7701248yba.505.1509891138832;
 Sun, 05 Nov 2017 06:12:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.110.139 with HTTP; Sun, 5 Nov 2017 06:11:38 -0800 (PST)
In-Reply-To: <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com> <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 5 Nov 2017 23:11:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
Message-ID: <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: dts: remove bogus bcm96358nb4ser.dtb from dtb-y entry
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

+CC Ralf Baechle <ralf@linux-mips.org>
+CC linux-mips@linux-mips.org
+CC Kevin Cernekee <cernekee@gmail.com>
+CC Florian Fainelli <f.fainelli@gmail.com>


I missed to CC MIPS maintainers.


2017-11-05 14:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> arch/mips/boot/dts/brcm/bcm96358nb4ser.dts does not exist, so
> we cannot build bcm96358nb4ser.dtb .
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/mips/boot/dts/brcm/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
> index 69a69d1..ad76130 100644
> --- a/arch/mips/boot/dts/brcm/Makefile
> +++ b/arch/mips/boot/dts/brcm/Makefile
> @@ -22,7 +22,6 @@ dtb-$(CONFIG_DT_NONE) += \
>         bcm63268-comtrend-vr-3032u.dtb \
>         bcm93384wvg.dtb \
>         bcm93384wvg_viper.dtb \
> -       bcm96358nb4ser.dtb \
>         bcm96368mvwg.dtb \
>         bcm9ejtagprb.dtb \
>         bcm97125cbmb.dtb \
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
