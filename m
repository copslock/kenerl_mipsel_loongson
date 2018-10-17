Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2018 22:28:29 +0200 (CEST)
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35424 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbeJQU2ZTBQbW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2018 22:28:25 +0200
Received: by mail-oi1-f193.google.com with SMTP id 22-v6so22210328oiz.2;
        Wed, 17 Oct 2018 13:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEcdy7QEDbNlcX07BFBN89zLOirmmnq91X/i2VMyaL8=;
        b=gwWxFO7FxIx7GCCYRXaDZ/IKnj1LGE9tU/1l2qEtzjQbUzYH2qPsT2jOgsfzR+VCJz
         OuLDmOXrnkVXe9Q4aUburXEHIGfkBpp/Q8P0zV3GEpXOL3dyRYMCQCEkezN508xE2mXp
         0GeViYp7Adwirl+0kn2/LNNlxpPrCpHB2gQuweB41Y15ydOgHK9+3dqu05lGboExV0VW
         Z5ns7lzLlAYyM0egtO2QvyfI1Sg7mcCAFEcvTeOY+wBDpQwIcJs19iI6AC9DY/CANXLS
         ZOeL3VRR5YLlXxRlpZRyr7r9Mbs3aybNmzDvZvQARERZkpGso9FLZlnXTBQDHTdO/64q
         vJTA==
X-Gm-Message-State: ABuFfogqSPlyjAZP7GDhNG7DZSSYaOJ7mrK/ZSveTSpB+EYB3gPkbTa8
        Cuo+9b/0YA80xT0Uk9P2jewS0Ufghq4pTLyXLoY=
X-Google-Smtp-Source: ACcGV63AaImc1z7tHmL0M6Msh6TSOdjWNVL1mke8ThowGM2MOldlYt/WOW24+5D3Tl4K3VZSolDd5sb68toPmLpKSvg=
X-Received: by 2002:aca:ab8b:: with SMTP id u133-v6mr15347446oie.57.1539808099156;
 Wed, 17 Oct 2018 13:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180606193811.16007-1-malat@debian.org> <20180606193811.16007-2-malat@debian.org>
In-Reply-To: <20180606193811.16007-2-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 17 Oct 2018 22:28:08 +0200
Message-ID: <CA+7wUswf1+3E12-qs0c0L7PjPWsndYo2oe_b=Gv5vXF0gd+Ttg@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: Ci20: Enable SND_JZ4740_SOC driver
To:     James Hogan <jhogan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Wed, Jun 6, 2018 at 9:38 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> Update the Ci20's defconfig to enable the JZ4780's SND driver.
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/mips/configs/ci20_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
> index e1c14f6af824..0c08c7675b42 100644
> --- a/arch/mips/configs/ci20_defconfig
> +++ b/arch/mips/configs/ci20_defconfig
> @@ -104,6 +104,10 @@ CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_DEBUG=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  # CONFIG_VGA_CONSOLE is not set
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_JZ4740_SOC=y

technically I am also missing: CONFIG_SND_JZ4740_SOC_I2S=y

>  # CONFIG_HID is not set
>  # CONFIG_USB_SUPPORT is not set
>  CONFIG_MMC=y
> --
> 2.11.0
>
