Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 12:06:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40635 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010093AbbGWKGEPCAkl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jul 2015 12:06:04 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id CFCC641F8D35;
        Thu, 23 Jul 2015 11:05:58 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 23 Jul 2015 11:05:58 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 23 Jul 2015 11:05:58 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0FA6F439D4689;
        Thu, 23 Jul 2015 11:05:56 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 23 Jul 2015 11:05:58 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 23 Jul
 2015 11:05:58 +0100
Message-ID: <55B0BC94.2050106@imgtec.com>
Date:   Thu, 23 Jul 2015 11:06:12 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "David Daney" <ddaney@caviumnetworks.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>
Subject: Re: [PATCH 2/2] MIPS: Partially disable RIXI support.
References: <cover.1437644062.git.ralf@linux-mips.org> <6066e46d74d2314ecc19e6562afe33e369fe9557.1437644062.git.ralf@linux-mips.org>
In-Reply-To: <6066e46d74d2314ecc19e6562afe33e369fe9557.1437644062.git.ralf@linux-mips.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="mpPfmcRa8EOulXIuteBGN5egUG3okpCmu"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: f107b6f
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--mpPfmcRa8EOulXIuteBGN5egUG3okpCmu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23/07/15 10:10, Ralf Baechle wrote:
> Execution of break instruction, trap instructions, emulation of unalign=
ed
> loads or floating point instructions - anything that tries to read the
> instruction's opcode from userspace - needs read access to a page.
>=20
> RIXI (Read Inhibit / Execute Inhibit) support however allows the creati=
on of
> pags that are executable but not readable.  On such a mapping the attem=
pted
> load of the opcode by the kernel is going to cause an endless loop of
> page faults.
>=20
> The quick workaround for this is to disable the combinations that the k=
ernel
> currently isn't able to handle which are executable mappings.
>=20
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/mm/cache.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 77d96db..aab218c 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -160,18 +160,18 @@ static inline void setup_protection_map(void)
>  		protection_map[1]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_NO_EXEC);
>  		protection_map[2]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_NO_EXEC | _PAGE_NO_READ);
>  		protection_map[3]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_NO_EXEC);
> -		protection_map[4]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_NO_READ);
> +		protection_map[4]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT);
>  		protection_map[5]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT);
> -		protection_map[6]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_NO_READ);
> +		protection_map[6]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT);
>  		protection_map[7]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT);
> =20
>  		protection_map[8]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_NO_EXEC | _PAGE_NO_READ);
>  		protection_map[9]  =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_NO_EXEC);
>  		protection_map[10] =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
>  		protection_map[11] =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_NO_EXEC | _PAGE_WRITE);
> -		protection_map[12] =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_NO_READ);
> +		protection_map[12] =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT);
>  		protection_map[13] =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT);
> -		protection_map[14] =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_WRITE  | _PAGE_NO_READ);
> +		protection_map[14] =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_WRITE);
>  		protection_map[15] =3D __pgprot(_page_cachable_default | _PAGE_PRESE=
NT | _PAGE_WRITE);
> =20
>  	} else {
>=20


--mpPfmcRa8EOulXIuteBGN5egUG3okpCmu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVsLyUAAoJEGwLaZPeOHZ64XUP/24w6qs01Li5S/rbsW7BZngo
xLtSeOK9sVV3mtQFROoNyX2YeVj94cpVaBSFDqYvM0tbrq0C5BGolpdhsu2BFeSm
j2AIuGCCCsv5fKrgTsfloufAPdtuTYFrlpLudddr9HrjRIko/CDhXf9NQbSgaOMQ
N3WXgPT2f0WbUMzEevrtcVoOJHA7MmsBXL8JITsIaAO3eb+9fTf9GubSqlZrvvJI
QO+dqYfSLdGP/r1fWf80aF5hxCKHql8Juswrhg6IoE9HYHxgATQXZinI9TWRZMln
Zb2LMPCXKDqunQXbVIXa9PHBflLoy3yb5UQ4uIDrTNQC8os26got+66y+f7UYjau
ZnvMdZQYgDgiLJePoA8QJnczFXXfIcA/G2oRwz8m9t9OqvvFuQ06oUSiGeqUxFvG
SNnm3gQwV/MF+orEuWjitCgVzPS5/JZyn/hgYf03WFk6PZMdKOy/fR7vBz3dBXSa
acTrM0pRy7daM/UoEHUPmjdSNvkcPzHt003u/OOUp+pQZUGhaoqkgAznjYK6bEUy
iOrpWmuf8PsMynWp8xOuDnlbmxPo40t118zXRfFw/JV8eDw7+kmI29/CrwplwFl/
lcUWNLDAvOwyvpV+XJ+DlaH72W8kgAXC9zmyYvcw9UBwCMmxurz/CxEpfc73LDdQ
0ByFw0o5ZSmv3clCGq19
=ZYW/
-----END PGP SIGNATURE-----

--mpPfmcRa8EOulXIuteBGN5egUG3okpCmu--
