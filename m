Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 12:42:04 +0200 (CEST)
Received: from mail-wr1-x444.google.com ([IPv6:2a00:1450:4864:20::444]:44835
        "EHLO mail-wr1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbeJLKl5pOAUQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 12:41:57 +0200
Received: by mail-wr1-x444.google.com with SMTP id 63-v6so12894666wra.11;
        Fri, 12 Oct 2018 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fPDxcroJciIMsvfFT+WvfSSZGRz40ykKSUracXzD23Y=;
        b=dqIFSLUjkJDFGfPIgZkmQBCwM8kEXq6NKnTbWTDm6aAYo0uQeU3tF1pwEm+EzWRr+V
         irxU+MhlM0Pu1BJn/oN3AyX6GTLmbFk9tri4OqIGipwkZMTtgdaXDADFTeFnnwLudt52
         n3qt98gr7qbwk9zbnZ5w9ioaIUBgc+6AHmvYCT8gNFzxqUkGMMETyb0gUmGIAePJZjVP
         jLxmlj/ygZYrfSXLLmtfVkzgIlxpBKPpGe6V5sicYryd1qVkWS+kNJ6olEkdM9c0BT53
         sCyRMCYTZADaCjHu/q7GzqdCwzl6dsT+QJi9i1dTw6mdlcYB56v/VnkHN2rA/hT1NaHN
         dQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fPDxcroJciIMsvfFT+WvfSSZGRz40ykKSUracXzD23Y=;
        b=HfxmHbR4H39kQzG23++QIqUiz7W43RIkAU6O74XYq3qKpEOqLfkjc1g3/xb7xg215q
         jKZMQHXodQwb49tXCYx54y3Jc/pEnw2qhTSZ3Yv36/rT1pad1bPJ2tr/fkTQD5T31eOS
         6P+U1f95espdfMc+tg7GWmfsIQZTm0Bquw0jvlu5O/D/Ad1WeKQ4Sgdv6xdB45JwQ4Ma
         hILeS5B23Xzjs0lAqCzDJJZFBkgRVA5yT/gaOs6P5lo4SPjofjJad3J/UYDxQa/YCXxp
         9AsAUiW6CUr4i04QD6A+liSa1+QRQLWi4VJlEPr1mwUwcd2lPvnrz3EF6Fo4tdxd6IKA
         1vKw==
X-Gm-Message-State: ABuFfoh61FctaLYs8X4R8x0xGmTJ2jH3DTxa9V0qJEx2IHYvRG2D0DPr
        fRd7KXPROBKEPBHR2nB+IlAMZJZI
X-Google-Smtp-Source: ACcGV63S61DkjUKnutYPOSb34zVjavbTjZzNkDDVOTY37UfcPpm6CDzvOmoTNoM1o2OLE3U0MnLZbw==
X-Received: by 2002:a5d:620b:: with SMTP id y11-v6mr4788024wru.105.1539340912279;
        Fri, 12 Oct 2018 03:41:52 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id a1-v6sm818238wrt.79.2018.10.12.03.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:41:51 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:41:50 +0200
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
Message-ID: <20181012104150.GH9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-15-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-15-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66761
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


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:25PM +0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
>=20
> On other architectures, this driver can still be built, thanks to
> COMPILE_TEST. This is used by automated tools to find bugs, for
> instance.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v5: New patch
>    =20
>      v6: No change
>    =20
>      v7: No change
>=20
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAem4ACgkQ3SOs138+
s6G1TRAAux8060Bb39lvD0m2DyAcY+wj728JjVVoR4ewIrMKra16L/zRXspBZiK5
NE29yVOUrXx3h/C0/JD5zNTx7b6LajBoTYJ48FS2UVh3u04rky6MLHCyH97SnIA7
WKt+PWrDi5pXZ5ooh6tNURClbe5iETYuVjjXudUFjVtNC0ptAEaY9PvX7HrlcB0R
Eu1OUbp0k/RBhktlJJPkX/K/NqpBhncHo1GqHa2SRKf7+xkLia3V2SrszJC4q/g/
EtLjaOrsOjHkcolpePxX9Gc1V52Jpy6yDuB/TSmsAAkZGLbUBDZWh5VH21XJlbBZ
EDC28EJRnPDp3L6i9S2Kpy2anUNFblez+DAYY+takC3q/B+pKs/z4crRI9EwcVBA
AQFDwWbovRGB0Ery54rZSUYIOBKclO1hlBbMYROpd7bsadsA/PE4VtjGjrlkSJhz
GDF3anIdsvB5h23zZySwW3rOAKr8hGehlrWWu9tPCxacnKLZavMOHOThSDG2St9v
60glgFNZCH86gcJ47HOgg3pr+xejpvwF9s85dN378nNIqxiMEPiF6rrvELG+YzFp
Tv89gFw+06At4es9Gh+BlTqwYoiNGuIakwJHKoczVXCKxRThMiLkrjzhpomgh28y
x9DLbMSigzYstEPL1Q/VlRZGEYWRRa/vCWqu9Y0RMSSxnmMSLkc=
=ywfF
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
