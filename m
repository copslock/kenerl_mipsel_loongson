Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 12:44:10 +0200 (CEST)
Received: from mail-wr1-x444.google.com ([IPv6:2a00:1450:4864:20::444]:34703
        "EHLO mail-wr1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeJLKoF1Z0RQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 12:44:05 +0200
Received: by mail-wr1-x444.google.com with SMTP id l6-v6so12491867wrt.1;
        Fri, 12 Oct 2018 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/b+VycXEgumQlj8+CR3YSCavTy78fDjvWdT9Eiibs5Q=;
        b=CnYkKYac89F7hBEZ8NGi5cADyHu39zTWiCsNMK+CmN1YvXAhJGG+9ExDQDEfzFH8V+
         eLtRSDWdyylbIq7k4nr2CvmMQXywOqUt1pAwMuBt9v2PBOXmMjCOfszpcdd7G2FlDuuZ
         pLy27ZOOT9oblvwnYpjjPY3+wkZRHm5KfXFCkGZ9Yx5H/8+K3+CUEmQAwDZCKP5uTGRL
         GRywzJEzDH3qpjVFuKtwX4/EnImas3kHkYSjqW0xvhLtBY4IelhyF+ZIPGZswMAEN/br
         hcB29Hbk3lkx05rhdywK76nirO2RwS9bNbJnfkgsgCpHC9Cd9J/LA09dY+h47Wxv/ZPA
         REiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/b+VycXEgumQlj8+CR3YSCavTy78fDjvWdT9Eiibs5Q=;
        b=jRz/IYkIzxytF9nssK7dQXu+MEQ83cegQwVTqZSS3YINEjd8eKIhE8y2mzjbwoL9Dm
         T3dnkipe2rPTAR9oDR476cVyRlArR2AZm9rShuw7hxwLivgGAMPGydnpg2q6bV+lh1ca
         SCZqM5P8bnnXHdznVaUEcTAKiyCM1FKb3F7cE+LDU5w8Rr73m+mIENREC/KS6nqxL3zf
         CtuuQca48tuEAlfu4P+srNgE5COEQAq6yo6PLJ3rDmoJjcoLKrUrVoGT52Nxuvfd2gw6
         Gj2aWlNGD4ASuJKKYXkxf7LUyp30mq6Nkx2bNtxbz2hAoFm2mLSo5SHZQOqBc3eGBPaw
         Fztw==
X-Gm-Message-State: ABuFfojCdq9GskH8fdfs+RPprx8LEMVwTlYIING6V6Mb2eA/Ad+bGZIq
        Lkghe4tuxgjrJUDaF/eqWl8=
X-Google-Smtp-Source: ACcGV60QmXu0o+nBgCWf6g4L+FuZv4JBO5Ux5dxcQPPyb/kw1OVwuqdaZPo8e7t1mlu3b9opXh8USw==
X-Received: by 2002:adf:b743:: with SMTP id n3-v6mr4892065wre.274.1539341040056;
        Fri, 12 Oct 2018 03:44:00 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id y64-v6sm997203wmg.28.2018.10.12.03.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:43:59 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:43:58 +0200
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
Subject: Re: [PATCH v7 13/24] pwm: jz4740: Allow selection of PWM channels 0
 and 1
Message-ID: <20181012104358.GK9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-14-paul@crapouillou.net>
 <20181012104053.GG9162@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline
In-Reply-To: <20181012104053.GG9162@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66764
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


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 12:40:53PM +0200, Thierry Reding wrote:
> On Tue, Aug 21, 2018 at 07:16:24PM +0200, Paul Cercueil wrote:
> > The TCU channels 0 and 1 were previously reserved for system tasks, and
> > thus unavailable for PWM.
> >=20
> > This commit uses the newly introduced API functions of the ingenic-timer
> > driver to request/release the TCU channels that should be used as PWM.
> > This allows all the TCU channels to be used as PWM.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >=20
> > Notes:
> >      v6: New patch
> >    =20
> >      v7: No change
> >=20
> >  drivers/pwm/pwm-jz4740.c | 28 ++++++++++++++++------------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

Technically this should be:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAeu4ACgkQ3SOs138+
s6HsGA/+OJEoG7dAfVGZx3RgpI7szDdd/ub5tyj8iEnxQJesIILP6jDs17mjzQ6g
jaDfYBESKsbVTJiOo/hpgekRsRFVmzZcDXwDAHM0w47OzDNNGT4NNBMNbg94ioki
hycEzI0w8Ty/K/uUBBpHfeswoBNAVrNn/xEE0Wp5ULvcak8AjfWj8gjkdSRgioB/
ghl5zGM0uVZzYjKKNCaQXEcCIO+aTPdvC/fHq5L6yBpfqwFh80OoxJlieK31uGMf
m59ZIkKQsPGvQSRZzuDZtwE6f9iQCBT+2BDebWwJjpUt4nC1oJS8biIEVC2UMEPX
94ltWiddkrj4DPpxZE8fqPhMFegd2cN1CmdB8WIkF6d+/K3LlvktsXmRULqWLI6z
7kF7mufd/s4KzIm35NkD+66+avzFcJYqGCvJMuk/aHAigqOXV8MVQo5zuHHLHl7/
C4KZaAQpXcuwfIt9blMHY+LxILA+vcWewhbIpE6397ICD1o8P//gKCBbQ2nQHAZE
+MtBHieUJMl6zjzsdT3PkifebmJxD0xXz9HdTH6xVR7l5tYrbaenGJwT1TsNYVnp
a+mpz7TXQozQTpXx0DoRrEgYa5Fx+arEMqsBctx9slWENPxwZWC2zyKCeHKYhrA1
vNUzJSXwmQozneec9SaJ6NKSqb/O9n1LOBC0rVV07OwrcuC5/cI=
=DqPs
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--
