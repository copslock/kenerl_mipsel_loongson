Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 12:43:23 +0200 (CEST)
Received: from mail-wr1-x444.google.com ([IPv6:2a00:1450:4864:20::444]:44845
        "EHLO mail-wr1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbeJLKnTPLZ2Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 12:43:19 +0200
Received: by mail-wr1-x444.google.com with SMTP id 63-v6so12899440wra.11;
        Fri, 12 Oct 2018 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+MvIpKzcTAhwZa+2gA4ijL4Bg+X482ReRYyrDcy6zTw=;
        b=bbLQCpBX/Ce3u/WyUZRtcrafmQ5FCpl3hL8YaIR5JwXgNxqkRKMA8AyssokuqUL+m2
         a2SuxgSTyusKaW/q2gjACYvIF3eFb7ZfgaFSUiWpT35RRyBMb9DJua3p0VKO4fV7GRtk
         P5wgr11FZvE8qGLcmZgKnZWQ1j+RO6goIEe85pa9BOGI8+JyEvYXcBziVaKyX02bV6kt
         DBRpF9tVyaWMubz0Rxlm9jdrvWsvkV6VGv59KmtFr/y3cMZU5BLsZm66pfHsAWYDh9bE
         GR+1zbpZ38Si6Du6AWDqWw0ag//Ga+ToxYg6gZgetEASn+bTzM00QRjHwAXlaPFbB6si
         U9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+MvIpKzcTAhwZa+2gA4ijL4Bg+X482ReRYyrDcy6zTw=;
        b=djST+PyQt7e4/w9ICqcL5zSv3W9fhrsZ+xHZ9v0fYOAqal3BrPbGtAk0q0u9CTQ9iM
         /bc5IHsS1GH6XpnwYzCeaCMUNBQ1PRdsc5+G9FhXdOCSGG8ZM19C+1EqWZ2I7J4OBNEm
         G60eD/GZxm1KrhLzWhAcnEWiNcC3Haq2xWDTrlb5/3Ee/QJhSWp64ImJAxVUH7Oaw9IS
         PlGu8wc+ahlQZQrDi1xRB86pp3Un3VnLPta7WMM6g0TpP6HnqBhVvkA0I58/DC2Y18Cv
         P2W0TPWsSgVaeI/dwX08LifU4MsyQbNWzupHV0ic065hjS3TWMOOEFmdIc8+NNHke8ia
         06/g==
X-Gm-Message-State: ABuFfoiML3LQZJSEF5tGFLFrjNszUqJN8marQX4iH7VD/E29Y408Go94
        uaQ8QlPH0Nlgf46le4l73m8=
X-Google-Smtp-Source: ACcGV63yYY1cBT/RQapQt8J9P8I3lr83iCHHozSQXWYMa3eiJMvvxEAwuWYXqJ0hN6BFdBWN0cB4EQ==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18-v6mr5247537wru.80.1539340993866;
        Fri, 12 Oct 2018 03:43:13 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id v76-v6sm1236456wmd.32.2018.10.12.03.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:43:13 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:43:12 +0200
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
Subject: Re: [PATCH v7 16/24] pwm: jz4740: Add support for the JZ4725B
Message-ID: <20181012104312.GJ9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-17-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-17-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66763
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


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:27PM +0200, Paul Cercueil wrote:
> The PWM in the JZ4725B works the same as in the JZ4740, except that it
> only has 6 channels available instead of 8.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v5: New patch
>    =20
>      v6: - Move of_device_id structure back at the bottom (less noise in
>            patch)
>          - Use device_get_match_data() instead of of_* variant
>    =20
>      v7: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAesAACgkQ3SOs138+
s6FK7g//XMqm9tY/j9ebBHkmvyejEcCSzNYK6TscB0/JcxIikY5BBEPT3Zu4yk5K
jvy11nwiuGXxqeoCCvrprgWlMskRbB0vfjaXbkbium0WtcDWECGAD2q0PQ61wT2Q
HwtIecyTHVHp5vTht3FuqhRW/ISdQo/h4aN54HiX3GTvFEPXIobrW/52smXWIGLw
BBE0fz2a94H3zVewmeiqwzViQAfBTT3FqKl13AH0iAfmfT3mjgxsPgnnCGmQo9gc
zt8cvqS9LAPy1cw07bFfiyPGVn3DL4KhlybPi2NTOn+zGKIMJeza0iYKpyh/PcGX
xMgk1VSLKNFQTITXllRnw69ad9QfW2hs3kHqy1W3oTaQe7VmXuUAS0LlFkX4WRG7
vhnwdCZVlGjpdzmt9IduRBUBhZuTkqNLdzF4WhoeQjEeohvmmvKFGjy5OwMw0F9Y
pDYjp0bfECwQNKynPVF+pPSw7B3nh1D97o5VGZGILYXYFIE5MlKOXqMVXpSd2HIj
NmjziYKpPZk6auyQlbdsijlZ/jra0RYGvLdi8bWBJVbpo4IqC9iFjtC4/9vJ0m+R
YLwQlJoZGqRKCVpwdQKDEEBx+4bQxdQcQJZrYueZXMCRIimzWC2H2cmxKpRWdjqw
mokR4lpnDhHpADP3A7wPVKCvMoJn39U1saRvscYMRxkH8cV1J9g=
=OX+r
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--
