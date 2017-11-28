Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 17:14:38 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:34115 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbdK1QOay1q7Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 17:14:30 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 28 Nov 2017 16:14:03 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 28 Nov
 2017 08:10:16 -0800
Date:   Tue, 28 Nov 2017 16:10:14 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 01/13] dt-bindings: Add vendor prefix for Microsemi
 Corporation
Message-ID: <20171128161014.GG27409@jhogan-linux.mipstec.com>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-2-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <20171128152643.20463-2-alexandre.belloni@free-electrons.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511885640-298552-2200-43236-15
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187380
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 04:26:31PM +0100, Alexandre Belloni wrote:
> Microsemi Corporation provides semiconductor and system solutions for
> aerospace & defense, communications, data center and industrial markets.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org

Nit: Usually the Cc list goes before the --- line so that it is included
in the git history (i.e. these people had the opportunity to comment).

Cheers
James

>=20
>=20
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docu=
mentation/devicetree/bindings/vendor-prefixes.txt
> index 0994bdd82cd3..7b880084fd37 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -219,6 +219,7 @@ motorola	Motorola, Inc.
>  moxa	Moxa Inc.
>  mpl	MPL AG
>  mqmaker	mqmaker Inc.
> +mscc	Microsemi Corporation
>  msi	Micro-Star International Co. Ltd.
>  mti	Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
>  multi-inno	Multi-Inno Technology Co.,Ltd
> --=20
> 2.15.0
>=20
>=20

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlodimYACgkQbAtpk944
dnr87A//ZRd9S96D6M6KvgykqRA/eGrYQHsgg3SVKLEHOs8dXOuULXBFKfH3q6TC
0ojY+7kA0Ch34UbOIcM9QArzbZil77Y/dpgm/Glsk1yh7GuGn6EjcWBBi4YkebGX
oTEuwI9jVvvGAyeDIOcXlwXW9+zohN2ufNXUNz+12ae50WqRFDtN0wrerSD2si+F
Cf7imr1V56TdAFIzPKEj3oCyI62t7AAE3H7JWMAfyj/3swJCSWF7rLjwSnQGGNjz
hV3IFslOqLQTzSzfkkxbWcVBpoYSLgkiDAjtNLoDGOWO1YDNlDF0DnBJimOjwjp6
D2dVNF8VSig2FT9JuRYqnm+Nh9nd24sZu4OoELWif/PXgXDo+o45NfY38YHNji4n
PpBxYEYrv1cYxRJDIcbhj3OFHOFoeKdv0a/I3PCbSCGy+a5wqh4TveD9O4HjRcKB
MfVW0jWSzwJob4Ld4MNnD+lV7P1C3xjrbqvYJhmugprAoMasj/gJdPU6lrMS49mK
gdylYdsF6KHh0WUofg2pEt8o65vwE+EbY7BnU3PzRFYNIhzff0Pf38fcV27fIynt
aFxcKzTGJp7u9H35gev8G71kjiD8uEz1hSsx+ZeD436mn5wTk74APTk4n7w4/Alv
QWwSgnbu5E94G7pTf2Y83tFVeK7qINhPR+7XACS6UCgM/DPFP7s=
=/5tY
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
