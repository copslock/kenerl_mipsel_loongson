Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 10:32:00 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:46811 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeABJbwvKYVu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 10:31:52 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 02 Jan 2018 09:31:31 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Jan 2018
 01:31:30 -0800
Date:   Tue, 2 Jan 2018 09:31:28 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Mathieu Malaterre <malat@debian.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] MIPS: Remove a warning when PHYS_OFFSET is 0x0
Message-ID: <20180102093127.GM5027@jhogan-linux.mipstec.com>
References: <20171226113717.15074-1-malat@debian.org>
 <20171226113717.15074-2-malat@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mXWEJCq0x1D2MX0F"
Content-Disposition: inline
In-Reply-To: <20171226113717.15074-2-malat@debian.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1514885490-298555-14381-449719-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188376
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
X-archive-position: 61814
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

--mXWEJCq0x1D2MX0F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2017 at 12:37:14PM +0100, Mathieu Malaterre wrote:
> Rewrite the comparison in `else if` statement, case where `min_low_pfn >
> ARCH_PFN_OFFSET` has already been checked in the first `if` statement:
>=20
>   if (min_low_pfn > ARCH_PFN_OFFSET) {
>=20
> Fix non-fatal warning:
>=20
> arch/mips/kernel/setup.c: In function =E2=80=98bootmem_init=E2=80=99:
> arch/mips/kernel/setup.c:461:25: warning: comparison of unsigned expressi=
on < 0 is always false [-Wtype-limits]
>   } else if (min_low_pfn < ARCH_PFN_OFFSET) {
>                          ^

What compiler version is that with out of interest? It isn't exactly new
code.

>=20
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> ---
>  arch/mips/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index f19d61224c71..073695ccc1aa 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -458,7 +458,7 @@ static void __init bootmem_init(void)
>  		pr_info("Wasting %lu bytes for tracking %lu unused pages\n",
>  			(min_low_pfn - ARCH_PFN_OFFSET) * sizeof(struct page),
>  			min_low_pfn - ARCH_PFN_OFFSET);
> -	} else if (min_low_pfn < ARCH_PFN_OFFSET) {
> +	} else if (ARCH_PFN_OFFSET - min_low_pfn > 0UL) {
>  		pr_info("%lu free pages won't be used\n",
>  			ARCH_PFN_OFFSET - min_low_pfn);
>  	}
> --=20
> 2.11.0
>=20

--mXWEJCq0x1D2MX0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpLUW8ACgkQbAtpk944
dnpS+w/+Npv5F1DWk80n5rtVhl0L6MODD2KN6Q/Ezdxxwjpqz9evVPaGmgPzUpCG
mgSdLjQyq3cQbwseKODap2QQqMSqXIXs9IOBt22l1kBk/upnIdgCVvtAJTTmXGCt
KwFt3OW1Cje6XfAdMF0TFkAxTMLdsKgb2gGYIoVJUowHC4w/xYfsF35txeYYN9dj
xV78bCd6sZeQws7c3kn5UixviCCoNW/IgyB+egHSuLTFOp7Jf9yIJdbdXCXt/SMg
jbFOEmeHsX7SzaE989qRc99oqKmkfVqqX/OLADPaDFSOAK3oSc2/j6HPrT5rh73N
T+deZjr8TNTb5NcMquU8lupeRjC+w6PV91rzY8drzpP5VY90jRsb3Qd9WHJTITUm
KW91k34zXPTOVD/e+H8BBnC0PRwjPO6XFJVUrUd3kdAhQ+4LuY0uglZFKXRal+Xu
6Dgsf4qGFqFB42MoMfyDiHMqQVhI6RWrW/fL+yR7iD5ehK/y0y3uC/myOfJJS2nj
TGGIASSUTS4cIcPHybFs4e36XSJ3fvrBgPhRz6xLng2tD4Pd1wH6mgeXmcodNgZ2
JG137E+ZB3k/8YzprmnCz6/uWObbZ9N1m7zGkZSWk/kqYkQ/CyTYpQRuEDW1cRot
bKpEfPM6xOfs+J0LL09tqQVDc5iwYhPuSSzSEOrjRhagJCas8ug=
=ch3w
-----END PGP SIGNATURE-----

--mXWEJCq0x1D2MX0F--
