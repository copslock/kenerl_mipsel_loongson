Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 16:40:49 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:36606
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992974AbdDFOklOUqeN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 16:40:41 +0200
Received: by mail-wr0-x242.google.com with SMTP id o21so6901535wrb.3;
        Thu, 06 Apr 2017 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jEfUxBvPVzgdnApcGivuC30FSWnxsC3QjMWlZLvy7Uo=;
        b=ISGP/bgojgR2Oa5c18avz0yRLBzS+KcUzeiM3pA16dhbZ9fK4BQB0+RNXI8hmOHNhs
         +jBq+xzz5L4m95K0ZgpeWo0fYSYZ7YoI3+8ZF5xA2t17GPS8LzyvF/wUq8QihcWrFHzc
         rfToy4EpH9a7KbvN/2DJC8917SEvtCfnrgVBVuYX3AWaEaWg0ttlTgpA3yMd/l0jSuOH
         Y67/uhA4qwXAjVKgbYvwuL3TKf6fSL1LDLj5TyooOuWaCbz2TIAW0CfFianSqqYD/xBN
         1mY8Kj0qa+XMtEMGAj8LrWtcH7V5k/hWejkbbnqmNI3LXUfoHpEBacwXedu7ATuVFdQq
         9LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jEfUxBvPVzgdnApcGivuC30FSWnxsC3QjMWlZLvy7Uo=;
        b=D40a7gngFdRnwEDXE63g5rfYGXwKJMdjq2d2oJpfoAKHNV4v8zt1uBGAGxLuTZdn7H
         xh04NU5JC8H3sKglWirLmLKcOhfS7UEHX2tuf3ORB0tJIFpqGi/eRlUBgL6C+eT2zwak
         sXrcwzT9UPPyQQ70zwKVBovLBkgT6bn3QQ9Up6BkLa4O0eE/fQXwk1H4b10eTG6wepr4
         tiqVBknIQHQaNoyIAlXT5YutmllctJe70Vl4oS8luGNhg+v/437GXqsnP6WGdvXY3Z+G
         9JbuNqWFnTuWxgtaWeeSUqgRlnqPeXEOv9E+IYBFUjU6odJHQlUpRhVewi0NNOScAo1/
         geBg==
X-Gm-Message-State: AFeK/H3XiiSoPRuSaU+/7kKCiWp5UabeCqIC9qQ5wsPHO2bBza1hsTxdcfa1Tlu/z5yx+Q==
X-Received: by 10.223.170.66 with SMTP id q2mr29653038wrd.179.1491489635583;
        Thu, 06 Apr 2017 07:40:35 -0700 (PDT)
Received: from localhost (port-21936.pppoe.wtnet.de. [46.59.147.92])
        by smtp.gmail.com with ESMTPSA id m14sm2397427wrb.13.2017.04.06.07.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Apr 2017 07:40:34 -0700 (PDT)
Date:   Thu, 6 Apr 2017 16:40:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 13/14] pwm: jz4740: Let the pinctrl driver configure
 the pins
Message-ID: <20170406144034.GE8438@ulmo.ba.sec>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-14-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
In-Reply-To: <20170402204244.14216-14-paul@crapouillou.net>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57607
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


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2017 at 10:42:43PM +0200, Paul Cercueil wrote:
> Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
> the pins being properly configured before the driver probes.
>=20
> One inherent problem of this new approach is that the pinctrl framework
> does not allow us to configure each pin on demand, when the various PWM
> channels are requested or released. For instance, the PWM channels can
> be configured from sysfs, which would require all PWM pins to be configur=
ed
> properly beforehand for the PWM function, eventually causing conflicts
> with other platform or board drivers.
>=20
> The proper solution here would be to modify the pwm-jz4740 driver to
> handle only one PWM channel, and create an instance of this driver
> for each one of the 8 PWM channels. Then, it could use the pinctrl
> framework to dynamically configure the PWM pin it controls.
>=20
> Until this can be done, the only jz4740 board supported upstream
> (Qi lb60) can configure all of its connected PWM pins in PWM function
> mode, since those are not used by other drivers nor by GPIOs on the
> board.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/pwm-jz4740.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)

Assuming that you want to take this through the pinctrl tree along with
the remainder of the series:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmU2EACgkQ3SOs138+
s6HGABAApLsMiPuePBh0cJc9OAijswAsVlj72HCTmH1JA3qrEfhOVWZxltlReNwi
z9upRVFfXOAux8PGiJT+0N/z5Zrkwu/haho/al14XxloMx4DSW4UWkeBAVyqBkba
N6btN6WY2TLAMi7gav0GWbXFhspUJCncB+HqK2wmXyAhQJfBjMQ2Et1OpniwQ5fe
v60TCWUjBY7dZtgtZ5I80tQKjYnZC6hLQoXZcBwTNvQbeIM3sl9cymdPbMXVIJH4
dzxud0NQLfx1flI0KlEI35gpRAAfinGr5XqUYipP1JtsegR51uvpQdQ6l2WdGcBV
9mICw0SZnFuELmPzAYXFjKEYvmOFLB9kMgVHISOgCCwFtJfIH4slY27lZLLvmUkg
y/erHU6r8KQfjkVdxNiMcktqMOoAoHaUpWfgsBL/kE3Am0aoXXL3AFEsKY8WXbDg
qjN3dsSIdafpEngfpz6tyxbZfPeUkpYubI4+D9T4ov5SC9JeKuPLd6TTXnGtAntx
FNhSfWilbcbkYG1r37LpNkW8xWo904JQ7G0pn7opGScBH92xGhV3+g0MBTlTfs/8
t1fqhL3r7+z576vncJwup/hFZq2XrjqCWjizIHKwp2q7vj8JFyN1NXrwRp0CwfJt
IwPgbk9MEqstyCKhNIpM4qoJvvmSTQS/SC3k2JvQVGkwjWiytNM=
=QxS9
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
