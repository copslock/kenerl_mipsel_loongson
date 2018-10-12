Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 12:44:24 +0200 (CEST)
Received: from mail-wr1-x441.google.com ([IPv6:2a00:1450:4864:20::441]:37782
        "EHLO mail-wr1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeJLKoT5QgqQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 12:44:19 +0200
Received: by mail-wr1-x441.google.com with SMTP id y11-v6so12895811wrd.4;
        Fri, 12 Oct 2018 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TG27+xIK25GzwB3sLm2rIdsHlo9uLNjnjrSgSL3ZnIA=;
        b=MuKYxT3WxdCe3DNB4E+EIrsXFel+QDJZLORESJgPvIaGSwL/9W2f5bkeBEp/d6ZflK
         huEIqSLTUawcjlyD8/tLviy+4aExa3LRzi1zWMMfqQkELfEnlLC8e6yXyY34kTCrB9cw
         uW2Ol2Ph8x1XzqnbKXfuIhdvpBQm9yy7cgddMPSz6Cl48KnYbnSKt9MbCAmBWGw4enQC
         m5lKsOLDctFYJWDWVylYuqBTdQ+W2V628P6Ssgm/obW1Jp5S50cNwAZIsBT3jXpXAypa
         +Zpn+xej+fVe0gCw3e/CGyLGKeeJa8S663VY3CVAfwLxfzetb0kJcL0xlpDWAHghUylD
         +rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TG27+xIK25GzwB3sLm2rIdsHlo9uLNjnjrSgSL3ZnIA=;
        b=bfVjqfKoBozBrjTVZnKQbB+8sgOg5qQWBZeEEvq057mVQ9BSovxpq3jtLEIaOhlwzB
         8svKsJMq5tvxDHGI06RMsXmKXg0CERWjppvLQAVq/M3DE7ICW3kB3ITpm/j7jhNzCF1l
         aI9iusT3QkDy5KISI5VsOnM/7gwJzJMlhg9wMvuX7qHnHzpGwnnph1E8v0AGVOAdOv6w
         ktuf2rdUdear5FQhYV/AbXcCAJn5GIVB12tRpivIgFMLy+71ekBjFqdCzgnxSwcsM3O8
         uQCyf7Vlr4vdhSPzb6O+edAHmZPUStwI+6yXqx6eeN7BEN5O+xn9Kzv36p08oKVP97cy
         dZtA==
X-Gm-Message-State: ABuFfoj4IZOTfcnqOza8C8pK5HVmzjpzkmIrP59NAjyeOnm/iLFi4FYf
        UT8Ye9aNnFofd1H+5W1ufKI=
X-Google-Smtp-Source: ACcGV600/DfgP3odqNjuoljwtfkJMsad/+0s5NUbtEdoHcQeyydpu8eODNn904bIOnkQFF3K3l/mmA==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13-v6mr4475150wrt.120.1539341054544;
        Fri, 12 Oct 2018 03:44:14 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id j46-v6sm1139280wre.91.2018.10.12.03.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:44:14 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:44:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 14/24] pwm: jz4740: Drop dependency on MACH_INGENIC,
 use COMPILE_TEST
Message-ID: <20181012104413.GL9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-15-paul@crapouillou.net>
 <20181012104150.GH9162@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline
In-Reply-To: <20181012104150.GH9162@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66765
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


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 12:41:50PM +0200, Thierry Reding wrote:
> On Tue, Aug 21, 2018 at 07:16:25PM +0200, Paul Cercueil wrote:
> > Depending on MACH_INGENIC prevent us from creating a generic kernel that
> > works on more than one MIPS board. Instead, we just depend on MIPS being
> > set.
> >=20
> > On other architectures, this driver can still be built, thanks to
> > COMPILE_TEST. This is used by automated tools to find bugs, for
> > instance.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >=20
> > Notes:
> >      v5: New patch
> >    =20
> >      v6: No change
> >    =20
> >      v7: No change
> >=20
> >  drivers/pwm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

Again, technically:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAevwACgkQ3SOs138+
s6GelQ/+IO3/3WkTMSnpQ2QJHnzotuHHGdyWg9WiVsJXTCWZBd3gXvHrg8HwLrDH
DrxXd4eh/0ZJLoY5/HO0UdtsWcSkCm5DyL3UrZ8WeIYjxZAQGTnxsHGip1yMnOtN
grZXhj171MGsvyJlnjULrWYRjOKQaHlMNusp1J54zLH9gsfKAiv3kjhunxPTCfWT
5yxsy7dAlKp2mlwKg5nT3PFEJvRIk803EvKcivowpSIzhiK5uijW0vWYM/KpyGUJ
1zHK1HJsm097AJrb1d7MXbVx72uMjclZTmVk8RXgqESYGOSHqt5LdenA2xlqUwZ5
Myp5bbr2I0F45H8A8NCw7BYQwXUkSLoCLw+Up9U142QAEjG02rV09vgBzC2gAbxB
piSs6XMY5IHmf6oR7ujMLM/14epj1BdrGPwG/VH7dSKt+VERC6QZ4eNYdyOUzkHr
RtdrCk2Vol8cedHbk70hdWQMMSY8sB3QurTCYaTg/ZIIyViUxR/lu2Zf3xwFqbt7
w/+ICttqjsY750sU/aFUv7lIS40skAgYEIPXxu3Nj95nkaWmrEtfvFQ7YJ+GkPgT
5j4g6cStKFoJ498CDkZGThTGD8Eyb5vJZGFMS768xKdlRkXajXOwoP9cSuqBJGaS
/IbRlVmrzOy7/VYQzJNWzwfEUz+6a5CUi51+6na99M/eT0xsBDE=
=yYfr
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--
