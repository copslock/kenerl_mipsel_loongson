Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 16:33:47 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:42832
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994689AbeBTPdj2FRxa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 16:33:39 +0100
Received: by mail-lf0-x244.google.com with SMTP id t204so4763820lff.9
        for <linux-mips@linux-mips.org>; Tue, 20 Feb 2018 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HgPTyUgMXpmVKkKQlQHKEsElAiY3+igRvAvVGsAC4tE=;
        b=gj7VkLLrYgAlDjUAwhpjmEhVAl9MEw7oO/43rrYUXTrFGpUde3KO8ZL38pyMYZekGB
         kX17hkOwmRB0mUa7WkMX9DjOrLN2sjYvVZPZmIiszhKotICBlb9Rw0e4BWzg/d/UhBpY
         0QclL+yjv8gbGVdRQPl5F9tBBX6k7GYar7NsTCXO0OOLpE2BLpiuX7CbZpALTLnnA3FH
         svjVgK0P65Ac0XeVfxAlHJS/1qmj8P2esmRPTbIO0g3ZW1K5VHp9YQVD5dGmojEFbvX5
         a6ctHTuMRc8rcZkC/vJbsESEmk/bMiJWoxMZJ3Q4GNJ1IZ/YDCgYMmlD14QIgfIU42pl
         acWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HgPTyUgMXpmVKkKQlQHKEsElAiY3+igRvAvVGsAC4tE=;
        b=Qza8YbLu3z5tLaE4DoswcIhx+aHgLL6UPfdSkoI8WVebMcCrr2+UnJy/StanZOuKCl
         /Trz82mmcZilyEzQR760k8FfSgz9Nn7Vs2xBYhoQZdl8+Dxup4LUAhMAD8z9rK/MY54y
         n4waNVWb/yX/4uTxtcI9Kxh0I56DhnImsVq/JsiSmwp8Pg9A+oOV0pY1HfQD0mKjg5Va
         z91flmnep2qh3onkZMJGSTVM8k7DmfPmWKv9asGmxCqRdJ1E51zRL0WPzwVK01YbKsA1
         MCZHA92gJ5QJwmalwKdBL/eiUdj7vxckYKf+wafJKPdxYqqLgAlEH+VVrATRIWsjSxh8
         yJkQ==
X-Gm-Message-State: APf1xPB8rEYABlwkLMcPl+YMA8E7SxSFV4jWJ+saZXotaVHFSLuzNtMj
        l8dVJNleWy1iNdCvbJfKr7E=
X-Google-Smtp-Source: AH8x227CAnPWbiTfZyj2af4s4OrOKVKScXFpf8fl3itzp1XUykc6wg8GdiOF1O0x+5lrAk7jMO57DQ==
X-Received: by 10.25.67.18 with SMTP id q18mr20427lfa.114.1519140813646;
        Tue, 20 Feb 2018 07:33:33 -0800 (PST)
Received: from gmail.com (c-2ec27091-74736162.cust.telenor.se. [46.194.112.145])
        by smtp.gmail.com with ESMTPSA id a197sm5556093lfe.88.2018.02.20.07.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 07:33:32 -0800 (PST)
Date:   Tue, 20 Feb 2018 16:33:26 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
Message-ID: <20180220153326.GE24311@gmail.com>
References: <20180220104542.32286-1-marcus.folkesson@gmail.com>
 <20180220124955.GA17814@sophia>
 <20180220132103.GD24311@gmail.com>
 <48db897e-8a61-a5bc-5a61-56349cafaa10@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline
In-Reply-To: <48db897e-8a61-a5bc-5a61-56349cafaa10@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <marcus.folkesson@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62652
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


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 07:13:43AM -0800, Guenter Roeck wrote:
> On 02/20/2018 05:21 AM, Marcus Folkesson wrote:
> > Hello William,
> >=20
> > On Tue, Feb 20, 2018 at 07:49:55AM -0500, William Breathitt Gray wrote:
> > > On Tue, Feb 20, 2018 at 11:45:31AM +0100, Marcus Folkesson wrote:
> > > > - Add SPDX identifier
> > > > - Remove boiler plate license text
> > > > - If MODULE_LICENSE and boiler plate does not match, go for boiler =
plate
> > > >   license
> > > >=20
> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > > Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > > ---
> > > >=20
> > > > Notes:
> > > >     v2:
> > > >     	- Put back removed copyright texts for meson_gxbb_wdt and coh9=
01327_wdt
> > > >     	- Change to BSD-3-Clause for meson_gxbb_wdt
> > > >     v1: Please have an extra look at meson_gxbb_wdt.c
> > >=20
> > > [...]
> > >=20
> > > > diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc=
-c384_wdt.c
> > > > index 2170b275ea01..c173b6f5c866 100644
> > > > --- a/drivers/watchdog/ebc-c384_wdt.c
> > > > +++ b/drivers/watchdog/ebc-c384_wdt.c
> > > > @@ -1,15 +1,8 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > /*
> > > >   * Watchdog timer driver for the WinSystems EBC-C384
> > > >   * Copyright (C) 2016 William Breathitt Gray
> > > >   *

The copyright is untouched?

> > > > - * This program is free software; you can redistribute it and/or m=
odify
> > > > - * it under the terms of the GNU General Public License, version 2=
, as
> > > > - * published by the Free Software Foundation.
> > > > - *
> > > > - * This program is distributed in the hope that it will be useful,=
 but
> > > > - * WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the G=
NU
> > > > - * General Public License for more details.
> > > >   */
> > > > #include <linux/device.h>
> > > > #include <linux/dmi.h>
> >=20
> > Thank you for your feedback!
> > >=20
> > > I have no problem with adding a SPDX line to the top of this file, but
> > > use "SPDX-License-Identifier: GPL-2.0-only" as I was very intentional
> > > with the selection of GPL version 2 only when I published this code.
> >=20
> > SPDX-License-Identifier: GPL-2.0
> > Is GPL-2.0 only [1], so it respects your choice of license.
> >=20
> > >=20
> > > Furthermore, please do not remove the existing copyright text; althou=
gh
> >=20
>=20
> It is not a matter if you CAN keep a copyright. You MUST NOT remove a cop=
yright.
> As long as you do, the series is
>=20
> Nacked-by: Guenter Roeck <linux@roeck-us.net>
>=20
> Guenter

I'm sorry, I do not see where the copyright is removed unless you count
the license text as part of the copyright.

Can you please point it out?

>=20
> > The copyright text:
> >=20
> >   Copyright (C) 2016 William Breathitt Gray
> >=20
> > Is still in the file.

^^^

> >=20
> >=20
> > > it's just boilerplate for some, I was careful with the selection of
> > > these words, and I worry the SPDX line only -- despite its useful
> > > conciseness -- may lead to misunderstandings about my intentioned
> > > license for this code.
> >=20
> > I'm not sure I understand your concerns here, the SPDX identifier is
> > a shorthand for the GPL 2.0 only license. See [1] - Linux kernel licens=
ing rules.
> >=20
> > One of the biggest benefits with SPDX identifier is that it is hard to =
verify
> > boiler plate licenses due to formatting, types, different formulations =
and so on.
> >=20
> > If still worrying, I think we could keep the license text as
> > well.
> >=20
> > >=20
> > > For the time being, I can't Ack this patch with the changes it makes
> > > currently:
> > >=20
> > >          Nacked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > >=20
> > > William Breathitt Gray
> >=20
> > Please let me know if I got you wrong at some point.
> >=20
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/process/license-rules.rst
> >=20
> > Best regards
> > Marcus Folkesson
> >=20
>=20

Best regards
Marcus Folkesson

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqMP8EACgkQiIBOb1ld
UjI5xBAAzZs/kuzKKdrL/lfJRg3GsiskH1mmB2h/dn54xHjx/uXLIKIbEhqa0tDH
q333ZEflilx0oqgyOn3z05inWR/NJ7PRrMF5sCW0hYJ0iPh/m12ui66fgx12mN0j
f3i1jdH9uKU/HWs5RBo1qNgzzOqHOXQuoq0L7LCHOfNYAUaB0FZfZ5YF/IFdGGYS
ogpeA3pM/vSfLKPiEUw0nIWK/J98BFfj4NaT1rpdPsgmYzMYTrrzDrvGLKWIKGSf
udGGlYJ/k6R8clDmj33mPa5YoBE9iiiGrhZo0tcs/93s44cIFhOGJxkhzAUJAZVl
puwzu7aa5flIGG3MEKk2JCsvkeCYYWgTtYuWUgBN/a/DM92fjRjerCwL4sTz/z4W
AAWzvzwhHkGCpJm6QHX3iALoE2JYNlbcPNGL5pRqwRjyXFQ0k3u/Dv3xdOovy395
79Szv+1fEsQYZGFDgXaOVTJ6WEwLvOVyYTKr9V/tH4QgylQrALR6c4YYmA1q4jZc
rvqEiTIDNYT/uY613ytReA64mkzaqurXOj9A+RndEB/2mZQmU1rONIJzMA5MoD+0
omoJW9Y5mX0KhALPgxfWtC/7mUmp/K9Ocq4BC8EKzHRzoBHpjIaM9Y8fU6jk2aHf
wk6yY29IKXjM/YpcqiXPoqcfHt7KdMRZwSyPiHsljr7xcv6p0so=
=FnNU
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
