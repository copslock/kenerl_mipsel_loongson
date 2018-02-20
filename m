Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 14:21:24 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:39251
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994686AbeBTNVQURrC1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 14:21:16 +0100
Received: by mail-lf0-x241.google.com with SMTP id h78so4132103lfg.6
        for <linux-mips@linux-mips.org>; Tue, 20 Feb 2018 05:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vi5zczWEWi6koQgg1e50mnGe9xDiyeRRBUwPaQ5+9lc=;
        b=gsK+B3c2BlS9/pTPlGKwjWhTD6X8EaA0PSytVK2uoiDX+OcvDaT+HkbamYj1cvWlzD
         4/pEGlGI4Kka+y2naVjL8NNfBbi0RmWZM2AMQw//vLK1yxHXXIc3faAHJJ5GunyiL2v0
         17B8qk91TRGMnBQeRlmV9yZ5EU4eo3jxEUaxoSrTnOaqtQ9WUtSNHzlx/an6hYUVmEe8
         IdkUfkY3TJJuBgEFIUOIXQrI1L4ULvkJLKvHSO3g+n0kZGI3yGP/HjAiHMeV/UamiuLH
         5OORWQfiWk+5Xbekxh5z18a2nKF0BK4R/mna6WkdwpFzDuk+vZG4lFNEJjykELRdlfw7
         ek3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vi5zczWEWi6koQgg1e50mnGe9xDiyeRRBUwPaQ5+9lc=;
        b=uhJWiU+WTJa/NJjcglkLSDIBjc2Hymqq/d54I5ynnPevz87my67yYbhVM0QhxMZEnT
         PanRqiUldCTlT6ZSR8SepJqH6r+N/SfhaXtZ/dSpN9iNOwzxZityyn2jTy4eOS5XhyOO
         MU44vy1UvnfQe9S+DS8tX2SPfWVWApuP/1Os0O1Yb1EfVr/dMe3AloPhJb5fe+8LHdBb
         UHbnllyswsVJV7eOvwjGs+bPI6cT+WS+snr3WtzxC5v7uGa0keRmWUrKJCNoKLRZIFph
         2CIxps/Gxn+CEo2r1LjlcvC8SznrXY8cZ9kRd6PYRqmXgiE0I9FUJ9ndc1tHEAjwWahF
         uXWA==
X-Gm-Message-State: APf1xPCGdremx5l96y7eq+n06hXCFYLDkoYHoW9/z2cMQu9qhLwYcY6T
        naAUD9OMPxBLYBTiHuOQygY=
X-Google-Smtp-Source: AH8x225TJN76c2wZCrkGPQM8ewWm0peupuMMm1yi2h5LFwL8O5t6nRk2Bc+o5agxP0v90wCjiohdcw==
X-Received: by 10.25.202.9 with SMTP id a9mr13122998lfg.144.1519132870545;
        Tue, 20 Feb 2018 05:21:10 -0800 (PST)
Received: from gmail.com (c-2ec27091-74736162.cust.telenor.se. [46.194.112.145])
        by smtp.gmail.com with ESMTPSA id d77sm5371221ljd.31.2018.02.20.05.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 05:21:09 -0800 (PST)
Date:   Tue, 20 Feb 2018 14:21:03 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
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
        Thierry Reding <thierry.reding@gmail.com>,
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
Message-ID: <20180220132103.GD24311@gmail.com>
References: <20180220104542.32286-1-marcus.folkesson@gmail.com>
 <20180220124955.GA17814@sophia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <20180220124955.GA17814@sophia>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <marcus.folkesson@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcus.folkesson@gmail.com
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


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Tue, Feb 20, 2018 at 07:49:55AM -0500, William Breathitt Gray wrote:
> On Tue, Feb 20, 2018 at 11:45:31AM +0100, Marcus Folkesson wrote:
> >- Add SPDX identifier
> >- Remove boiler plate license text
> >- If MODULE_LICENSE and boiler plate does not match, go for boiler plate
> >  license
> >
> >Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> >Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> >Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >Acked-by: Michal Simek <michal.simek@xilinx.com>
> >---
> >
> >Notes:
> >    v2:
> >    	- Put back removed copyright texts for meson_gxbb_wdt and coh901327=
_wdt
> >    	- Change to BSD-3-Clause for meson_gxbb_wdt
> >    v1: Please have an extra look at meson_gxbb_wdt.c
>=20
> [...]
>=20
> >diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384=
_wdt.c
> >index 2170b275ea01..c173b6f5c866 100644
> >--- a/drivers/watchdog/ebc-c384_wdt.c
> >+++ b/drivers/watchdog/ebc-c384_wdt.c
> >@@ -1,15 +1,8 @@
> >+// SPDX-License-Identifier: GPL-2.0
> > /*
> >  * Watchdog timer driver for the WinSystems EBC-C384
> >  * Copyright (C) 2016 William Breathitt Gray
> >  *
> >- * This program is free software; you can redistribute it and/or modify
> >- * it under the terms of the GNU General Public License, version 2, as
> >- * published by the Free Software Foundation.
> >- *
> >- * This program is distributed in the hope that it will be useful, but
> >- * WITHOUT ANY WARRANTY; without even the implied warranty of
> >- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >- * General Public License for more details.
> >  */
> > #include <linux/device.h>
> > #include <linux/dmi.h>

Thank you for your feedback!
>=20
> I have no problem with adding a SPDX line to the top of this file, but
> use "SPDX-License-Identifier: GPL-2.0-only" as I was very intentional
> with the selection of GPL version 2 only when I published this code.

SPDX-License-Identifier: GPL-2.0
Is GPL-2.0 only [1], so it respects your choice of license.

>=20
> Furthermore, please do not remove the existing copyright text; although

The copyright text:

 Copyright (C) 2016 William Breathitt Gray

Is still in the file.


> it's just boilerplate for some, I was careful with the selection of
> these words, and I worry the SPDX line only -- despite its useful
> conciseness -- may lead to misunderstandings about my intentioned
> license for this code.

I'm not sure I understand your concerns here, the SPDX identifier is
a shorthand for the GPL 2.0 only license. See [1] - Linux kernel licensing =
rules.

One of the biggest benefits with SPDX identifier is that it is hard to veri=
fy
boiler plate licenses due to formatting, types, different formulations and =
so on.

If still worrying, I think we could keep the license text as
well.

>=20
> For the time being, I can't Ack this patch with the changes it makes
> currently:
>=20
>         Nacked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>=20
> William Breathitt Gray

Please let me know if I got you wrong at some point.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/license-rules.rst

Best regards
Marcus Folkesson

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqMILgACgkQiIBOb1ld
UjK9Ag//RFYuvmLZSH6GnP5gGk0/GBMTVPPr95tPUKj2LxlQrPBqoWqCdFXnuHf1
da0hos+DEBo8xaRPtbvitCeWo3m3MgCG4RTCU/HKqTinyis52XV95y3YXGrMT6T9
kH/hukr9/oIIlKpz5bAIR9vfwo2hd2M1KkBsc5hYhloWY83jbuYTAEUcmogipLAu
5pPJIHWig0yHga6nTaUxwhyVShgX0qSiYfHihliemt+9reU5jtLDeDc3u5UrGiTg
6E2GeQYv9mA07s9xzWdHTAoyUx3sMCwAJ65F6u4E89uiQjVr7KFz7HvlMJswnehn
xWqnN8L2fNNaUxxDrJ7aEwPy1dMbiVjxdOoIl9ivc4mDe+DpD6N0bxPEk6bj1hbR
pMLtfoBZHQZok1lzvQk8B0EPvnfOEJsntjsb09R6io+28dU+z1KlZwFHZ7PJ4g0l
lnb64yyNupUMsG7zRyAC8Hq5bJbFGf0aZMOHD/NuZul/2+k3cNuUJUVUqV2wndyk
VduFlrBiDRk9mjFPnqlsnOgFVteAROyineIzMEeOPio05wMQ7/KJRKLxxL8TZNmw
j6TtRSFPIZZTFmpR8Xu5Ezxm32qb/5umECl2WqPkauzEWL3erJxngioWLp2q7vTy
988Zz12kOcwGHl6N2F9FCbeoO4z8Bj9zSZMYezU/f3LR+SLaAy0=
=96Xu
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
