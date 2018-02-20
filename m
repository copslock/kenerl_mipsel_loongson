Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 12:25:12 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:33478
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994680AbeBTLZE0QH20 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 12:25:04 +0100
Received: by mail-qk0-x242.google.com with SMTP id f25so15946734qkm.0
        for <linux-mips@linux-mips.org>; Tue, 20 Feb 2018 03:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C3hgodxvTMX1KLLy7oMxcCLYY+lNFN7IfcoBFdhvtMQ=;
        b=JSjXe1zZeDWb06/IrPD4JdnB8iBVg6uCEfVGfAoFDagKCudp/6JMPgP8s7JMHUAOlA
         nhLIekdVSWV1+80inRBDs0NhHLU1iNmVm/TAspeqgKj/5d+z6CymKiTuUPSVfmLgr6Q+
         y+LuSA/KeXvsDtoTKcywReqsuot3CBTufc1a0l4h3JIMdRhvOwcFoQSyAfZUocMxMQ6n
         bYa7fTB4TrxAIRgimll0/20IYKEnRcniNSh4jvnvjhRUL+vmqgVsk5Tl0rty7ACL41iX
         Z9CZ4xYOMnFcu9c7KRAtjBg5SX+SydvVyKcjV/L9tttsgAuEkAZHse2+7QsSkRn85qKz
         ibsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C3hgodxvTMX1KLLy7oMxcCLYY+lNFN7IfcoBFdhvtMQ=;
        b=N02QXGvULv0Dzl9BEkhhDP2dFULw5vGto3vlZiWnvFIO14nOOkDwifKE2dC3osKXB4
         HzYveEn/JJVkzv4bVeHZuRUIhw+fnEUyZmOlbHcfhtMVVGoIGMxwpFmlr//rsuueWxR5
         n/UKX7Pi5sGvW4Xr/0j+9Vm+mCYZKla91z0m5VbCphJoQ5rC1Yl6eflcSJMyBko9IjyV
         rQgieqa/hAxZVH5hZwuKMAQsZ6Beb9zdBHqHddyR7rg73EUwC8OO3r3cPuxHIJpfx0rL
         xP215o8NiUB1G+FDw0uV9ryCgMKPPxlbYXOa/1PhZ7lRPVJOiG2hOVnbgy72d/z9jGnv
         94pg==
X-Gm-Message-State: APf1xPCS/7s14FduXsUU+gKkditJcrUYIMWJlpok+UkPW5yxgK2GFrw5
        WFt9O+137iK0ekokcao6lOE=
X-Google-Smtp-Source: AH8x2263bJLggTOY9y3/VH7nblSZdoJ81keQMvQ6sjlIxFteMn8wrZpm0sNqzqV4AKWtmwQE9glwBQ==
X-Received: by 10.55.138.195 with SMTP id m186mr2809202qkd.72.1519125898148;
        Tue, 20 Feb 2018 03:24:58 -0800 (PST)
Received: from localhost (p200300E41F106E0039EA77311119C466.dip0.t-ipconnect.de. [2003:e4:1f10:6e00:39ea:7731:1119:c466])
        by smtp.gmail.com with ESMTPSA id g64sm17681033qtd.17.2018.02.20.03.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 03:24:57 -0800 (PST)
Date:   Tue, 20 Feb 2018 12:24:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jimmy Vance <jimmy.vance@hpe.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Andreas Werner <andreas.werner@men.de>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zwane Mwaikambo <zwanem@gmail.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-mips@linux-mips.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2] watchdog: add SPDX identifiers for watchdog subsystem
Message-ID: <20180220112455.GB9556@ulmo>
References: <20180220104542.32286-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20180220104542.32286-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2018 at 11:45:31AM +0100, Marcus Folkesson wrote:
[...]
>  drivers/watchdog/tegra_wdt.c           | 10 +------
[...]

Acked-by: Thierry Reding <treding@nvidia.com>

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqMBYcACgkQ3SOs138+
s6FRCA/+L1X7BfUKUkdJE+llR+ybOHpXilPB7yoH13SoNPr3XHybgRI9O19maL8c
bwuUEcCW9T9TbpdXf2OgLXeVAYnViZGASGDTZet20w0E3Qdol0WAZNIzVeL76ROv
Ajx9yQ0LWo8QyZFuc8R2u2TcJ2ogY4KEwM6qOrsSqPtpdQbJH/2IPHQD0q5ty54N
Yd2GIp41JdD8WGpyeXrDb2AYa3POMgp8lxbFYX3Os7fnC38/MftAn07psibY5aQK
MkGdFDG2KYeORyNFby7swdCEM8NW79zNy9QIhKkkHMOPbIBq/YOop76yD3ZKb2j/
PE+9ULqwiPmQFO6EjwT0+UfNQxbIbU9cgaVD4F2wweMUBQFpSk3xh3hRoUmetLN3
sM810bRGbdevwQ365+7sQ/NRNG4BlxnXseb3JMW4WFvvRWpPdV1OBdyDfVo+P9vV
e+0wu0C9dXmwkA0MoLoDmJHPzb+XChWNvjmJRwrDx03d6S2HalBn0kE1sJftRopb
gYmAzxkQhy34/i29PA9+uC93Cub31KQldgpHNnO49/ZwgPUiiZOEjauYl1lliejX
v+Tr4uQJzZhdCfmv382eTqJ8xFW9EXvaIGK9R3g8XVEEmQey8av3iFyS4iQmHHgt
IcC2m9dawjP6YkM4gA5WRt+ZriFgCyMzHzQDZ/iU/NlkDPviqzE=
=HcvD
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
