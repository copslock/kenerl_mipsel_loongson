Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 00:13:00 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:41985 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990504AbdK3XMtW3QU3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 00:12:49 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 30 Nov 2017 23:12:22 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 30 Nov
 2017 15:12:03 -0800
Date:   Thu, 30 Nov 2017 23:12:01 +0000
From:   James Hogan <james.hogan@mips.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     David Daney <david.daney@cavium.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH v4 2/8] MIPS: Octeon: Enable LMTDMA/LMTST operations.
Message-ID: <20171130231200.GJ5027@jhogan-linux.mipstec.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-3-david.daney@cavium.com>
 <20171130213635.GH27409@jhogan-linux.mipstec.com>
 <54c83e6b-35e2-be38-e4f1-87eb420938cb@caviumnetworks.com>
 <20171130225614.GJ27409@jhogan-linux.mipstec.com>
 <c90ac3a5-7230-38ff-691a-3d94a25702cd@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3FyYKcuUbgqNYeqV"
Content-Disposition: inline
In-Reply-To: <c90ac3a5-7230-38ff-691a-3d94a25702cd@caviumnetworks.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1512083541-321458-11978-14241-5
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187479
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61252
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

--3FyYKcuUbgqNYeqV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 03:09:33PM -0800, David Daney wrote:
> On 11/30/2017 02:56 PM, James Hogan wrote:
> > On Thu, Nov 30, 2017 at 01:49:43PM -0800, David Daney wrote:
> >> On 11/30/2017 01:36 PM, James Hogan wrote:
> >>> On Tue, Nov 28, 2017 at 04:55:34PM -0800, David Daney wrote:
> >>>> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
> >>>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> >>>> Signed-off-by: David Daney <david.daney@cavium.com>
> >>>> ---
> >>>>    arch/mips/cavium-octeon/setup.c       |  6 ++++++
> >>>>    arch/mips/include/asm/octeon/octeon.h | 12 ++++++++++--
> >>>>    2 files changed, 16 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octe=
on/setup.c
> >>>> index a8034d0dcade..99e6a68bc652 100644
> >>>> --- a/arch/mips/cavium-octeon/setup.c
> >>>> +++ b/arch/mips/cavium-octeon/setup.c
> >>>> @@ -609,6 +609,12 @@ void octeon_user_io_init(void)
> >>>>    #else
> >>>>    	cvmmemctl.s.cvmsegenak =3D 0;
> >>>>    #endif
> >>>> +	if (OCTEON_IS_OCTEON3()) {
> >>>> +		/* Enable LMTDMA */
> >>>> +		cvmmemctl.s.lmtena =3D 1;
> >>>> +		/* Scratch line to use for LMT operation */
> >>>> +		cvmmemctl.s.lmtline =3D 2;
> >>>
> >>> Out of curiosity, is there significance to the value 2 and associated
> >>> virtual address 0xffffffffffff8100, or is it pretty arbitrary?
> >>
> >> Yes, there is significance.
> >>
> >> CPU local memory starts at 0xffffffffffff8000, each line is 0x80 bytes.
> >> so the 2nd line starts at 0xffffffffffff8100
> >=20
> > What I mean is, why is 2 chosen instead of any other value?
>=20
> That is explained in the change log of patch 5/8:
>=20
>=20
>      1st 128-bytes: Use by IOBDMA
>      2nd 128-bytes: Reserved by kernel for scratch/TLS emulation.
>      3rd 128-bytes: OCTEON-III LMTLINE

Ah yes. Perhaps it deserves a brief comment in the code, or even an
enum.

Cheers
James

--3FyYKcuUbgqNYeqV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlogkEAACgkQbAtpk944
dno/VQ//R327DASVMh5v/eOdFcua6kZsgAaZYRV5Xn0MbQY6VHb/pvVWJBGEcpcS
1a784u62NaBzdoxR2D+nc+HnnmR1EgZZUl2B94+QKXWF1D+TfiXUreHUsAdrtJ4p
jN1e+jp0frTjzCxGNDUwiBgWrX45i0B2/J9YKP+dfk4AiGBpIKUXERNcdf/4B9gq
+0jKxzHfw/DiYvQuXwxT0KSGP83s1J3NYPfphOeUFTAEi53+HjOd76hLdgN+zP2t
WyhcMd8Wjh59daPG/PYwkaIhcIACiz8a+dhmjW4NxRIIx9siHFf6WVUdWR1mVg1A
92J5yp0mxP6h40yaZIs1fi61dqOqaUQ6wxOR0kT5VMz31YHG49Ic5/n1Q9O3/cTD
KrPsBR/Ax24V73pjDzrA8mt7KjomH+gx6E0ASVAWDnYW2dt66pxXRLrrWA4J7YqY
2EcoatS3U1ZOJFA/BsjgMEnZBdYnD/JxfJAgRiUdoTkXaUDz17xAbZCjzKYsm7df
4fB73hF/i5+tZc1uyPu+uUEMDpz7sYPzG5QqXCjfdAoHKlMKKVCFV3AaBD9X8DM/
1oxkkCaAe0R48jXmIhw3o4YFuBdC3kJSn36US6cvg2DF2StPb3eoI2Y/mt9bOwbh
LnOOB4Y2mcoV64QQJjKAKKBbItZ6nCMjx2nsIEO0pbLqM+LVacM=
=qtEc
-----END PGP SIGNATURE-----

--3FyYKcuUbgqNYeqV--
