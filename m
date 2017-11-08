Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 23:09:13 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:47255 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993917AbdKHWJGgPiHr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Nov 2017 23:09:06 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 08 Nov 2017 22:08:48 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 8 Nov 2017
 14:06:46 -0800
Date:   Wed, 8 Nov 2017 22:06:44 +0000
From:   James Hogan <james.hogan@mips.com>
To:     "Maciej W. Rozycki " <macro@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Use SLL by 0 for 32-bit truncation in
 `__read_64bit_c0_split'
Message-ID: <20171108220643.GP15260@jhogan-linux>
References: <alpine.DEB.2.00.1709291502060.12020@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E187YRO8KGM40JwS"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709291502060.12020@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510178927-637137-12452-944941-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186733
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60778
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

--E187YRO8KGM40JwS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2017 at 04:26:31PM +0100, Maciej W. Rozycki wrote:
> Optimize `__read_64bit_c0_split' and reduce the instruction count by 1,=
=20
> observing that a DSLL/DSRA pair by 32, is equivalent to SLL by 0, which=
=20
> architecturally truncates the value requested to 32 bits on 64-bit MIPS=
=20
> hardware regardless of whether the input operand is or is not a properly=
=20
> sign-extended 32-bit value.
>=20
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> ---
>  Tested by compilation only to verify syntax correctnes as I do not know=
=20
> if this execution path is actually used by any configuration (suggestions=
=20
> welcome).  I believe it to be technically correct though, being=20
> sufficiently straightforward to verify by proofreading, and an obvious=20
> improvement.
>=20
>  Therefore, please apply.

Thanks, Applied for 4.15.

Cheers
James

--E187YRO8KGM40JwS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloDf/MACgkQbAtpk944
dnoeuQ//WTBzaIdGliegG3NUnozCe3aPu67GMxNGBURhqqz6mg2ilikrZR2s8lk9
u4L2naLhpH+mWwucChzxe46SvK+8tLLOGrv9qfK6DAkUw+Ql6utMUKL/Gne4s0dW
dfvUo7VPBWOzQLnklyXQpmlg7RmmBV3Q2GvJTGH+6G3VVn3IDto1D39b4H8e+bSp
iqrv7tsy2UvVhPhgp4tbsgt5vqgYc8+/Qatu8wCvrbO1RsXAKMjHkwKmbDR/5eDI
yA+OGwfn7FTdipEsCZQRrsQ76adhIPnqMrSqwSRF8WHDrQk0kWfBP3uODge2O4QJ
c2I/K9Kf10Z/SfKwfipPsvbOXDlvoCOh5yjf9J6cpZeRb3UjopYbmDMorv/z1/Qf
EU7FNg4AE92cMJxWFQyVtpVI/UjWLPQEWUKzISoxFKfN5PFdoxCSyYp2vsBC9EbE
/12aBX5368K8kRktZw3OZqhWPY9HtX1CxPpa2MxVdWhz+mZb5evL2CUs2pgeb/zx
6wkKM7pSJVsy/xKyAQ8/IUUcmxsK8ws0Ywv9bGvRheVPUfXzhj63eU4NwEn3F5Q0
2FfqOXijA1rTiAAMkYzBqzF1mw8/GjQI1lXWsksSGX8xE/y3JqTbcHqYUAdmE2oD
rDlMZezGbOowqRfpgXo9YnHfppCFTI3hqRbp+E+E332pFa/utMM=
=RqTU
-----END PGP SIGNATURE-----

--E187YRO8KGM40JwS--
