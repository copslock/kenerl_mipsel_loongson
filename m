Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 13:19:18 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:48773
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990901AbdKIMTJw3Uoy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 13:19:09 +0100
Received: by mail-qk0-x242.google.com with SMTP id a142so7364107qkb.5
        for <linux-mips@linux-mips.org>; Thu, 09 Nov 2017 04:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9hlZrtaCi20vDKyTikTZT2Cqtw130Wc8hVFKvR8vylA=;
        b=uxwAParudTjSYMrtIkAR+Qzklbi7SylRI16VUruXbBpseO29uZNqgxwicc0SN71DEq
         qRFJ2woz+rTX3pf9HFO7z0NeZC5948r3F0x4zteddPT09RXkPe5y+8g7+AJS86MFcbLO
         hkZpSzYdrfbUsmyH669qBtancIjohOGLGX8r0p+8xG2U/X26wX9UWDGLm9EALob2kEZR
         XKVSpW2zTT/bzBnQ2x+uM42G4RiP9TW9woF1VRgaqHr6DSK/3UD1O+TsNXB9DzMLgZuO
         rH0Sxo5yLyxtGGiSu1k8u9tIiZU9Vb+kJkhPRcKdPWDtWB1wr7OphryiEqsYRDAklITE
         nn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9hlZrtaCi20vDKyTikTZT2Cqtw130Wc8hVFKvR8vylA=;
        b=lrJJ3vqPY6703+CaJID1ixNnxVuEqm6z7mFe2gbgJ4Si8YmXR13GubIj6X4tU+SrP0
         CtpqI/001mU6chMxanVaX1ahty9UarSHE1eJohxEeN/Q/yMzedC/0aHUiJSuaa+JwSp3
         UkfuAmdj93oBP337b0qpJcWUGfpEVbIVRjAd8Ly8zRM15Co2tnCGQQ7gL6efA77HxVGC
         LoxOKk5BNA9joXqanIakQWB3Szfu/kYyo91ttfB0ExYgmL3NbBexH47VAGyLCfzn/VT5
         OpuUH3i1j9aqKQo/XqmGkSQKcfOnoyTl7e9P8/uDjbeAQnL4ocO6PEegylX1swan322Y
         7vcQ==
X-Gm-Message-State: AJaThX4js/pSt7BOXtddjab3DABt3YOXz9LYIlLKpW7K3kSN1VC0v+xF
        ynMyXidMVUGsdENr6x9KWUeDvKu+w4uq6zhd8cypHA==
X-Google-Smtp-Source: AGs4zMZbK4JWJA3zgYGvVGZDkwGk5qBmyn5paEpo8MNvo/P5VrLacxJTrp0X0rRl/wkGs6huiHQUsG7fxm8qpIMuAtU=
X-Received: by 10.233.237.71 with SMTP id c68mr409148qkg.69.1510229943460;
 Thu, 09 Nov 2017 04:19:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.107.54 with HTTP; Thu, 9 Nov 2017 04:19:02 -0800 (PST)
X-Originating-IP: [212.159.75.221]
In-Reply-To: <CAAG0J98rRS+Sw8k_87gmTqYdNWByk=9zWVbWnC348vd63H4N9w@mail.gmail.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-3-git-send-email-yamada.masahiro@socionext.com> <CAAG0J98rRS+Sw8k_87gmTqYdNWByk=9zWVbWnC348vd63H4N9w@mail.gmail.com>
From:   James Hogan <james@albanarts.com>
Date:   Thu, 9 Nov 2017 12:19:02 +0000
Message-ID: <CAAG0J99envT6gtM6tHdTvetrHr0itX1dexkuWSU=u1c5UTLE1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: handle dtb-y and CONFIG_OF_ALL_DTBS natively
 in Makefile.lib
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        James Hogan <james.hogan@mips.com>, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james@albanarts.com
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

(resend using a working From address)

<yamada.masahiro@socionext.com> wrote:
> If CONFIG_OF_ALL_DTBS is enabled, "make ARCH=arm64 dtbs" compiles each
> DTB twice; one from arch/arm64/boot/dts/*/Makefile and the other from
> the dtb-$(CONFIG_OF_ALL_DTBS) line in arch/arm64/boot/dts/Makefile.
> It could be a race problem when building DTBS in parallel.
>
> Another minor issue is CONFIG_OF_ALL_DTBS covers only *.dts in vendor
> sub-directories, so this broke when Broadcom added one more hierarchy
> in arch/arm64/boot/dts/broadcom/<soc>/.
>
> One idea to fix the issues in a clean way is to move DTB handling
> to Kbuild core scripts.  Makefile.dtbinst already recognizes dtb-y
> natively, so it should not hurt to do so.
>
> Add $(dtb-y) to extra-y, and $(dtb-) as well if CONFIG_OF_ALL_DTBS is
> enabled.  All clutter things in Makefiles go away.
>
> As a bonus clean-up, I also removed dts-dirs.  Just use subdir-y
> directly to traverse sub-directories.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

 ...

> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index 7891ffa..b2b0d88 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -1,20 +1,14 @@
> -dts-dirs       += brcm
> -dts-dirs       += cavium-octeon
> -dts-dirs       += img
> -dts-dirs       += ingenic
> -dts-dirs       += lantiq
> -dts-dirs       += mti
> -dts-dirs       += netlogic
> -dts-dirs       += ni
> -dts-dirs       += pic32
> -dts-dirs       += qca
> -dts-dirs       += ralink
> -dts-dirs       += xilfpga
> +subdir-y       += brcm
> +subdir-y       += cavium-octeon
> +subdir-y       += img
> +subdir-y       += ingenic
> +subdir-y       += lantiq
> +subdir-y       += mti
> +subdir-y       += netlogic
> +subdir-y       += ni
> +subdir-y       += pic32
> +subdir-y       += qca
> +subdir-y       += ralink
> +subdir-y       += xilfpga
>
> -obj-y          := $(addsuffix /, $(dts-dirs))
> -
> -dtstree                := $(srctree)/$(src)
> -dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))
> -
> -always         := $(dtb-y)
> -subdir-y       := $(dts-dirs)
> +obj-$(BUILTIN_DTB)     := $(addsuffix /, $(subdir-y))

I wonder if that should be CONFIG_BUILTIN_DTB?

This is causing failures in linux-next with MIPS
cavium_octeon_defconfig like below, and changing this line to
CONFIG_BUILTIN_DTB seems to fix it.

arch/mips/cavium-octeon/setup.o: In function `__octeon_is_model_runtime__':
/work/mips/linux/main/./arch/mips/include/asm/octeon/octeon-model.h:368:
undefined reference to `__dtb_octeon_3xxx_begin'
arch/mips/cavium-octeon/setup.o: In function `device_tree_init':
/work/mips/linux/main/arch/mips/cavium-octeon/setup.c:1188: undefined
reference to `__dtb_octeon_3xxx_begin'
/work/mips/linux/main/arch/mips/cavium-octeon/setup.c:1184: undefined
reference to `__dtb_octeon_68xx_begin'
/work/mips/linux/main/arch/mips/cavium-octeon/setup.c:1184: undefined
reference to `__dtb_octeon_68xx_begin'

Thanks
James


-- 
James Hogan
