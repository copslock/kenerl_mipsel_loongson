Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2018 09:37:46 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:54924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990394AbeCMIhi4tqwc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Mar 2018 09:37:38 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFCB1208FE;
        Tue, 13 Mar 2018 08:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCB1208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 13 Mar 2018 08:37:07 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Dan Haab <riproute@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Dan Haab <dan.haab@luxul.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Add Luxul XAP1500/XWR1750 WiFi LEDs
Message-ID: <20180313083707.GG21642@saruman>
References: <1519767173-8918-1-git-send-email-riproute@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline
In-Reply-To: <1519767173-8918-1-git-send-email-riproute@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 02:32:53PM -0700, Dan Haab wrote:
> @@ -528,6 +539,12 @@
>  	bcm47xx_leds_pdata.num_leds =3D ARRAY_SIZE(dev_leds);		\
>  } while (0)
> =20
> +static struct gpio_led_platform_data bcm47xx_leds_pdata_extra =3D {};

Any reason that couldn't be __initdata?

Thanks
James

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqnja0ACgkQbAtpk944
dnoNtA/8ClGMojCKX/q+7U3vTAAhFgS5ZVazbh2ErNqRypqeZ0GXeiy20pGK9PqF
JUvXi6GBZHPsjmPfzjskYMuaXKSXkSf55o5oPpqSrwPenZJelgPdTS+jVDBSqLY1
8DQQXhyTtwhiTa6IeJP+kv2RMaPTaFZ7T1jAEseeRK7ofIlJ8UjiQLZ/RU/5bcLc
y656vzNeJc5qI6wGenYcA0IoGt+uUa6wLy4VeRdlEFPcYgH4ZCe1oAffSjsj9S+N
EqIaKNjFLIKHy3/BckYKHhG8Ndai2JEj/KxDqazYPW/C05rQd6aEwJzyx7+yrp2z
kSaroWHBbeikFqV+i5Np5DNgKZZp7wQ7Ah3JZgr4+0mPJCQewKhXFk4A5Qk1dnGp
HPAIIbqt6Z6/ycG5OXowjXC6G+DctqygXN1iG6Av/QgFmE/n2ATGenPFQuz9aAuH
V0wDHwCiWRjKdMwaBG/CKBEdekMmUMFphJXtSdQQ9uj6kS92xk9OMg5CRwIoLG8w
sjrZDXqLrgbYrhVXcfrZgzvzNgoADQBIpZnX3aiMsC9zTZflMaa3Z8ce8ruYcJKO
EAFyBIk9VFQU+ExCz43MP8DqmCihx9aQd1yKjLdbUSdZtVhylPSc9KtchyeUeRqL
vXzerNoJU9xDOI2vb9cy21oRCmhMkq10EL+Aao9n91O23491es8=
=Aplx
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
