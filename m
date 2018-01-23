Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2018 12:44:26 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:59250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992818AbeAWLoSfDimy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Jan 2018 12:44:18 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F1F921715;
        Tue, 23 Jan 2018 11:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1F921715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 23 Jan 2018 11:44:05 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: dts: Remove leading 0x and 0s from bindings
 notation
Message-ID: <20180123114404.GD22211@saruman>
References: <20171214165358.28058-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
In-Reply-To: <20171214165358.28058-1-malat@debian.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62279
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


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 05:53:56PM +0100, Mathieu Malaterre wrote:
> Improve the DTS files by removing all the leading "0x" and zeros to fix t=
he
> following dtc warnings:
>=20
> Warning (unit_address_format): Node /XXX unit name should not have leadin=
g "0x"
>=20
> and
>=20
> Warning (unit_address_format): Node /XXX unit name should not have leadin=
g 0s
>=20
> Converted using the following command:
>=20
> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -E -i -e "s/=
@0x([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" -e "s/@0+([0-9a-fA-F\.]+)\s?\{/@\L\1 \=
{/g" {} +
>=20
> For simplicity, two sed expressions were used to solve each warnings sepa=
rately.
>=20
> To make the regex expression more robust a few other issues were resolved,
> namely setting unit-address to lower case, and adding a whitespace before=
 the
> the opening curly brace:
>=20
> https://elinux.org/Device_Tree_Linux#Linux_conventions
>=20
> This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading =
0x from bindings notation")
>=20
> Reported-by: David Daney <ddaney@caviumnetworks.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/mips/boot/dts/img/boston.dts   | 2 +-
>  arch/mips/boot/dts/ingenic/ci20.dts | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/b=
oston.dts
> index 2cd49b60e030..1bd105428f61 100644
> --- a/arch/mips/boot/dts/img/boston.dts
> +++ b/arch/mips/boot/dts/img/boston.dts
> @@ -157,7 +157,7 @@
>  					#address-cells =3D <1>;
>  					#size-cells =3D <0>;
> =20
> -					rtc@0x68 {
> +					rtc@68 {
>  						compatible =3D "st,m41t81s";
>  						reg =3D <0x68>;
>  					};
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ing=
enic/ci20.dts
> index a4cc52214dbd..7d5e49e40b0d 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -110,22 +110,22 @@
>  					reg =3D <0x0 0x0 0x0 0x800000>;
>  				};
> =20
> -				partition@0x800000 {
> +				partition@800000 {
>  					label =3D "u-boot";
>  					reg =3D <0x0 0x800000 0x0 0x200000>;
>  				};
> =20
> -				partition@0xa00000 {
> +				partition@a00000 {
>  					label =3D "u-boot-env";
>  					reg =3D <0x0 0xa00000 0x0 0x200000>;
>  				};
> =20
> -				partition@0xc00000 {
> +				partition@c00000 {
>  					label =3D "boot";
>  					reg =3D <0x0 0xc00000 0x0 0x4000000>;
>  				};
> =20
> -				partition@0x8c00000 {
> +				partition@8c00000 {
>  					label =3D "system";
>  					reg =3D <0x0 0x4c00000 0x1 0xfb400000>;

should that one actually be called partition@4c00000?

Cheers
James

>  				};
> --=20
> 2.11.0
>=20
>=20

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpnH/4ACgkQbAtpk944
dnp5zg//RBwYHjIEPh5OFW/n304VSNYBvd9YkALJq45rMHgmHuAPuCsp2W5j1suB
4N6V5tBTKczu/ZgvjmTP2epiysBbDd7b3cLXmubzEkOTUNPZrvy04NSuL3u/+i0q
Ph8iuxgvdwRTOGnmcCwB5A4ySSZbLrdY4R47fshHxXlyTXGTkLlgGGPdcDOMhM2O
C7GKl2WwBD39MbiR1Y3bWw717UxP7KGAuCF3i7LpCcJwUZdV7X1lupg5RYEF3BZ5
V8CQfFVNnBPf1A363Dh8fPHKkJsxoSJ/qwSeqcP1zJ9YbK9osNYZHUkwi6fcm1kv
pSKSZnvTpf5LraP6p7EpIoRvMQGyuy6KLq1HQeuG0/NLwbM6oKPXKFuun57bwS3/
3CmZ+7xMJ/VDeck9GbqscFs7mn6xRtB+U1yaYUq784OnujX+h46Wm5214qWHW3DS
ffJ5uLi9/0zs9vjiGqYXiPpJV0S96MY9Rd9328Lpi0CnKZAj3p3gJDLe3zM1t+Ss
b09EbnQ5d7EtJDJV5mF+5/9a8ZoYCfKmfsWJhCgtzPznWb5JgNyWm2WcP/ERJLRo
w4Fh0ef0kKaGJL6U5fr3h5c8khfvGwHApbLtj+C85xeWh3yPYbRfxucJc1tYOo/T
4powwVm1CZTXB/g5EO7IruDJjHoIEIp72hPaZuCAuxK1T0d/8q4=
=1QxK
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
