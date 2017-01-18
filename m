Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 08:15:48 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:35973
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993085AbdARHPkLhEdT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 08:15:40 +0100
Received: by mail-wm0-x241.google.com with SMTP id r126so1798499wmr.3;
        Tue, 17 Jan 2017 23:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TlhyI9uSqARSi0/CL3mmnp9h2K/l4tg0jjyZFfAUNic=;
        b=aA6i6Rv9g7GWVJd7hD0u5D2ud94M3G9U09LLQ5dA729JyfotAhWmfuVIAwSOKw84bW
         P8UKWHNIk4kmH5QKykA3smTawE6budmfZ/x+GSE++z3XKRZns+a+1r7ArgRau7XCtslZ
         23utM13yYO/7D0EWBEsU5E2fBIuxG65Ag2zmGREf0ZNZhwY7q2aywHtUHRlPG/uYjJ8F
         QOQN94ibSRznLegs2Q+BRByoqigvSb47xaFILYDXglY8l6d1lsapXQqICu5U7B0xy9ir
         v4ht4s5l0DDzpMs26+94/zWoC5bWGx66mAGvn8AOlaAS4e+UgLQSioPWjG4/P1Sg8dDL
         pJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlhyI9uSqARSi0/CL3mmnp9h2K/l4tg0jjyZFfAUNic=;
        b=TwmpqBJIPnHAkjQ+vi4m/avbPBe6DRXwIkQ9G9kCWkzlZt1QoUiD8njT1OWj+kn/gv
         mwPuY7upOxNXX4S+lx9dsJGJCYR3aNuIR6NM7uVRRqKm1OLWuirnW/bya/Nj7//zkQMW
         xgXanUVfhSk+Qjo9DCJLEAkPRLPDIMUV8nX8MzKNfc6nP8jdpzIWq2P5d0IyLykxAjYq
         3P/hw+S6rSC7ocjPNYQpYkX7NXugUph1I4mY4MmLcMNJUdVV5ceeqRrg6F2Noh8OGRB9
         ryT/N3IfOitIWZ0Q4ecB1e6meQabeJF0urRMD9eHKRWNKXsg+zxnrO85KJW2sZInXtUo
         Nimw==
X-Gm-Message-State: AIkVDXLNdjtzvTtxsh3j2E3uZU30XmycNwEZtssTjOumZpt1dXx+W4mg7wfl2/fZ/iDb2g==
X-Received: by 10.223.150.183 with SMTP id u52mr1374919wrb.180.1484723732592;
        Tue, 17 Jan 2017 23:15:32 -0800 (PST)
Received: from localhost (port-5733.pppoe.wtnet.de. [84.46.22.123])
        by smtp.gmail.com with ESMTPSA id l74sm2711890wmg.2.2017.01.17.23.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jan 2017 23:15:31 -0800 (PST)
Date:   Wed, 18 Jan 2017 08:15:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com
Subject: Re: [PATCH 00/13] Ingenic JZ4740 / JZ4780 pinctrl driver
Message-ID: <20170118071530.GA18989@ulmo.ba.sec>
References: <20170117231421.16310-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56384
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


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 18, 2017 at 12:14:08AM +0100, Paul Cercueil wrote:
[...]
> One problem still unresolved: the pinctrl framework does not allow us to
> configure each pin on demand (someone please prove me wrong), when the
> various PWM channels are requested or released. For instance, the PWM
> channels can be configured from sysfs, which would require all PWM pins
> to be configured properly beforehand for the PWM function, eventually
> causing conflicts with other platform or board drivers.

Still catching up on a lot of email, so I haven't gone through the
entire series. But I don't think the above is true.

My understanding is that you can have separate pin groups for each
pin (provided the hardware supports that) and then control each of
these groups dynamically at runtime.

That is you could have the PWM driver's ->request() and ->free()
call into the pinctrl framework to select the correct pinmux
configuration as necessary.

> The proper solution here would be to modify the pwm-jz4740 driver to
> handle only one PWM channel, and create an instance of this driver
> for each one of the 8 PWM channels. Then, it could use the pinctrl
> framework to dynamically configure the PWM pin it controls.

That could probably work. From only looking at the JZ4740 PWM driver
there's no separate IP block to deal with the PWM outputs, but they are
merely GPIOs controller via a timer, so one instance per GPIO seems like
a fine solution to me.

> Until this can be done, the only jz4740 board supported upstream
> (Qi lb60) could configure all of its connected PWM pins in PWM function
> mode, if those are not used by other drivers nor by GPIOs on the
> board. The only jz4780 board upstream (CI20) does not yet support the
> PWM driver.

Typically all of the pinmux is pre-determined by the board design. That
is if you've got 8 pins that can be driven by a PWM signal, not all of
those might be exposed by the design. If, say, only 0-4 and 6 expose the
PWM signal while 5 and 7 expose a different function then you can simply
use a static pinmux configuration and ignore PWMs 5 and 7. Even if
someone were to configure them, the signal would simply go nowhere.

Of course you'd have to check that your hardware actually matches those
assumptions. They certainly apply to many SoCs that I've come across.

Thierry

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/Fg8ACgkQ3SOs138+
s6Gr8Q//TFgNuNimYiB+7+AruQDt63U50a4sL1bBqLZEtCja8d1coKzuIihocevQ
FmB9mRjJA9VM/PGa86qsjDBAtWbIROZYqBE50U0DjGcIOHdZOltSM7I0liWPQRGm
42j4lMZZo7mdcIGWzcQmmIFroDOC0HMgG7/ZnYP1xvheJJaIJXghb41I/hYo55ub
c3M+ySsnWHfeIhe6BCsxm7sW99iStEiMDvGQkT/42QdmqsDkA2oKRgxOH4sNqgae
0r6fKZIF3bJX5klQiarNroAm7zRmc1T8AB/60CeQTrgDA0NC/rYThPE707ivqgqq
wsLbrqWXsO194wJxXJ2PX3+mKxm0Y6TgQPdDEb6f2Mehl8/NNTmIURjRyxBWrfsG
u0q0of+WuoEHi014KW3Qy4DJcGaATi13wJJzV1R2SX0dDcApALoPrVthMpx3h599
kUpxaMFeWpCNGjRFszJdCn8ZZgxaoDZiKRvLR9ghRYB1CaFlR7SZEz/wiHDjEx0q
4OSgtSMDRdWOyInw+wCTVE/9dFrSBLoMVAihrmS9d6FqUDdNYYlRsU/QReC8lFFl
tabfOvtDw/BHahDuKlWJpW2QdVQ5xmr+uUDM6uWMWV8rYdIz20fP614uSt0nJNQx
7WMslUpB4sm1DGoeX0fL+PPa7wDWUeL9tAgZHmMEWIe8393sjtM=
=7L1k
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
