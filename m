Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2018 00:40:16 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:57760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990401AbeCIXkIvL02A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Mar 2018 00:40:08 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F4C221771;
        Fri,  9 Mar 2018 23:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4C221771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 9 Mar 2018 23:39:57 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 13/14] MIPS: dts: ci20: Enable DMA and MMC in the
 devicetree
Message-ID: <20180309233956.GM24558@saruman>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <20180309151219.18723-14-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/t6ASE28jIy1gGy9"
Content-Disposition: inline
In-Reply-To: <20180309151219.18723-14-ezequiel@vanguardiasur.com.ar>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62900
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


--/t6ASE28jIy1gGy9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 12:12:18PM -0300, Ezequiel Garcia wrote:
> Now that we have support for JZ480 SoCs in the MMC driver,
> let's enable it on the devicetree.
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  arch/mips/boot/dts/ingenic/ci20.dts | 38 +++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ing=
enic/ci20.dts
> index a4cc52214dbd..9c5261dbcc4e 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -36,6 +36,32 @@
>  	clock-frequency =3D <48000000>;
>  };
> =20
> +&dma {
> +	status =3D "okay";
> +};

With that removed, it looks good to me in principle:
Acked-by: James Hogan <jhogan@kernel.org>

Thanks
James

--/t6ASE28jIy1gGy9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqjG0wACgkQbAtpk944
dnr3FhAAoDKDwyScBXcHJDGF9LEQ6H3Zs8cCNSh6y71S7agwRgmaNsrlVPf3fW6y
yL8S9Ama2iJz3fwqjGvcU8d4G2BiVzI26qzEkBNmyZw8RqTAwP5YJ7AZAfxcKALJ
zq/hHqMzd+3W2Yw454wa17kwi594amOZhWIDwaQbZAltMbAuKAXidSe02IbUkTog
SxZi92Dca1FljKoAQg+MRDJXRCTt9b+n7v8r/CNdD+UdPSKfnhnw0+QI6vrewSrV
J9goVBWNMOf/lBgInG8xR4Qr5oX43/bMQl0e+URnXEEEy158WPn1MtH2iG5BIALJ
teVWBkDO/YmHrY4IY3RouhBu+x9UmOnvFh1l7gIc9sIqsTM279uxor3zxX4HbXLa
MiTzKNcWNRPkrAe6b4M1t7unKpz6lUA+KSo8DH4AXAg3zaYMn53i/Y6ktK7Q13+N
pczCIOGeWCWspwW7TXr0i+xIwJtPJw3u9c823qWUg51WSPY7NoKii2HLnovYPD6K
HauBdgDoGwY2S67tPz6LTT+hFEGe7bb1DfKsRk1o2LPR/L1B/jpX7CVRi61bwWT3
Gf+i/whrurrdlUQY2KjDJ1DH9wP6bhCs8s+MnSoDh08CVk9OV0ny3Nef3N7cF7eT
7q6nzz9bWxdPWx99FLoimXtwrrllI1DqbatFaxdDIvGt6Mg+wRk=
=5+51
-----END PGP SIGNATURE-----

--/t6ASE28jIy1gGy9--
