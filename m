Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2018 19:25:28 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:47752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994669AbeCESZP1hYqT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Mar 2018 19:25:15 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D467221486;
        Mon,  5 Mar 2018 18:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D467221486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 5 Mar 2018 18:25:03 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 6/8] MIPS: jz4780: dts: Fix watchdog node
Message-ID: <20180305182502.GG4197@saruman>
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <20171230135108.6834-6-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62807
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


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2017 at 02:51:06PM +0100, Paul Cercueil wrote:
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/=
ingenic/jz4780.dtsi
> index 9b5794667aee..a52f59bf58c7 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -221,7 +221,10 @@
> =20
>  	watchdog: watchdog@10002000 {
>  		compatible =3D "ingenic,jz4780-watchdog";
> -		reg =3D <0x10002000 0x100>;
> +		reg =3D <0x10002000 0x10>;

Should the example in
Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt be
updated too?

Regardless,
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James


--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqdi3YACgkQbAtpk944
dnrLfxAAh8UzJNhjGjaxSpbWP/AjinkyNVwGe3Grpvql4g0kuxloc7LXlOCW6hZW
v7n+7D792ieqlFE9xImWAtdP4ZQNwv/sUv6Bfbkb7z47auqyzsv7M8OfT1CMQ9zP
nYPSesq2xRg6a/UXFPfLp83V0eZtEz4KUsz17s8wzM3U2Bu5gX36zKa2FxwMc4I7
P5hoHRRRLCTXHQGEXgeOJvY+/vJFr3Vcbh2J39elNv9UXyZmp75gah6cYrrhGvb8
ggaQKOUkkVDJ4WPw4NFbFksDC8LFxq4ykEmsOmH1W6XFmodjUFbKA3I5ihIu7Zpm
UM9rAltpUiZawmRaucLCwpEXw5jA3FLUCqOLkC9oNyd4r/iLhbRk+I7bvazjKSbo
kc5RsfidekdYXGl5hNPkK3lfCMNFoWON5Me8q5UWxIcYoUj+0IQx+GxS7tPiRr0R
c+Xkmg3eQxQIQZD1bRDlRGTjqigMZjdMffPLh3RJMFcmwWXsTAQJBk6IK8wHBXqv
c/Y3lyoOZAT6yZLSutRyBSrzrkdowaVE457NHcQgdLFL16ZtVlLA8qsIXe2PmhTK
+TkhuX8dDJYYPeWCfAznozO/rancNHhsRwzCIatMyBnCq/7xOVbLyH1QhHCCv4wd
i5cnhVAIVPUehr0WWIec163Tdu4dUvksHv6MRJ/17LDWQ6AJdS8=
=rurv
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
