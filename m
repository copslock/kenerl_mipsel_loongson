Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 23:28:27 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:54514 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeARW2TTmSNb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 23:28:19 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 18 Jan 2018 22:27:02 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 18 Jan
 2018 14:26:06 -0800
Date:   Thu, 18 Jan 2018 22:26:04 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        <devicetree@vger.kernel.org>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: Document mti,mips-cpc binding
Message-ID: <20180118222603.GG27409@jhogan-linux.mipstec.com>
References: <1514385475-23921-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1514385475-23921-2-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f9lFb+Z4UT82L8vr"
Content-Disposition: inline
In-Reply-To: <1514385475-23921-2-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1516314421-637138-9128-76600-8
X-BESS-VER: 2017.17-r1801171719
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189125
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
X-archive-position: 62245
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

--f9lFb+Z4UT82L8vr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2017 at 03:37:51PM +0100, Aleksandar Markovic wrote:
> From: Paul Burton <paul.burton@mips.com>
>=20
> Document a binding for the MIPS Cluster Power Controller (CPC) that
> allows the device tree to specify where the CPC registers are located.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  Documentation/devicetree/bindings/power/mti,mips-cpc.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/mti,mips-cpc.txt b/D=
ocumentation/devicetree/bindings/power/mti,mips-cpc.txt
> new file mode 100644

Is it worth adding to the MIPS GENERIC PLATFORM entry of MAINTAINERS,
given that it directly benefits it?

Cheers
James

> index 0000000..c6b8251
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/mti,mips-cpc.txt
> @@ -0,0 +1,8 @@
> +Binding for MIPS Cluster Power Controller (CPC).
> +
> +This binding allows a system to specify where the CPC registers are
> +located.
> +
> +Required properties:
> +compatible : Should be "mti,mips-cpc".
> +regs: Should describe the address & size of the CPC register region.
> --=20
> 2.7.4
>=20

--f9lFb+Z4UT82L8vr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlphHvsACgkQbAtpk944
dnosoRAApbUmU9krdm+eQh/ArkjZmYh/onFKo1q9QNghYNVom4vHzCF7hRQZCYcP
6EJo6/x6JMyFwaM4/dTZ6NghInx2wrHGSbOMFbL8Il4LtlzXi2lmDoV0oX4P2SUD
+TEfbKUHoANRdq9eck8nM+heqsJkF/MZ++ykD/FUjRwkoKG9rgh7wwLaPtnHNCX1
fY6qwTxboy1gKWOfBV9kMAM7sHzztRdDbPnlOVup1MSXShCOgzK1y2GSLIdRZyl3
flTJUJojdv7OAzBKAZrqM8ldYqKLEiEkBR+APRH4OvnWHkcVtd0/iQ1ntGZVz1Hf
3XNGZARH+K1JwIfmpy4ZbeSog5dn74KjSY0dhI5wgCisOP2MGuOxwnJ2hl+nbXYF
Xa9YYbftxOw4+XiBCQPjT6euJemnXgo7pW4i7LWPk3caOic0IOlGQgQCUYZ3AHBy
03iSOBFDCHhCQSLDWY2EMTA4b5JvI/tU8qAc2yGU51U3rTG6Q4uucGHrlIaMgApZ
e9u/CFmCr0uxj9GL2enaejO44YlgG5B8Ql+94IDDCMa7D7slwcyVp5t+5Gko55fS
mAcrKo1/0LdSoy24XxmWc730WZJBxcvteCFAgnsjiC5rr/bMmzqjpWAmM3f1D6eV
vUk3q/D6KN9mIqfDJ19cvaurOsfS2gtULF3CC9uchu8iWaLFJds=
=6/vD
-----END PGP SIGNATURE-----

--f9lFb+Z4UT82L8vr--
