Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 00:15:56 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:49379 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990399AbdKHXPtPduHY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 00:15:49 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 08 Nov 2017 23:15:30 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 8 Nov 2017
 15:15:29 -0800
Date:   Wed, 8 Nov 2017 23:15:27 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <paul.burton@mips.com>, <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: page.h: define virt_to_pfn()
Message-ID: <20171108231527.GQ15260@jhogan-linux>
References: <20170309211149.8339-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DBUa/BSa4z6QPQv1"
Content-Disposition: inline
In-Reply-To: <20170309211149.8339-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510182930-452060-12336-83540-1
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186736
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
X-archive-position: 60779
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

--DBUa/BSa4z6QPQv1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Thu, Mar 09, 2017 at 01:11:49PM -0800, Florian Fainelli wrote:
> Based on the existing definition of virt_to_page() which already does a
> PFN_DOWN(vir_to_phys(kaddr)).

I was just wondering if there was a particular motivation for this
change?

Cheers
James

>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/include/asm/page.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index 5f987598054f..ad461216b5a1 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -240,8 +240,8 @@ static inline int pfn_valid(unsigned long pfn)
> =20
>  #endif
> =20
> -#define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys((void *)  =
   \
> -								  (kaddr))))
> +#define virt_to_pfn(kaddr)   	PFN_DOWN(virt_to_phys((void *)(kaddr)))
> +#define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
> =20
>  extern int __virt_addr_valid(const volatile void *kaddr);
>  #define virt_addr_valid(kaddr)						\
> --=20
> 2.9.3
>=20

--DBUa/BSa4z6QPQv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloDkAgACgkQbAtpk944
dnoFwxAAu8k0IGNqPcaZOA5QKetgbTRwiGeL66VGU0KlG7gcU5KFFvslqQYFog52
WR/wptXdR2Pc5AVfCvBbGUiOe+8KMFvpCY6ezHIAzMNeOCbB7OSKiZ6xILuZMJiS
8x2sActrUi1TkhXrdMfGG2yMEv3hZcGrY2KgdyQxsH5Khg/sMs3ru11YHBghuG6Y
mOyaEj+yzGKlanQ1jDd1z1L6AETutrjE0/Qdsrf5T9BR2yc8lxQiAf66PXKXmT0N
qJTSSQme8Q1c8pd3gZNjFYZkWoLG64jcAfXQiZNqm1hg0BWxOyRlrAq/EiZ0qHU3
HSUkpAEiyE7kdDCeJtnZWkD9kMpy6D/1zbfjvtvQFX6lk8y47NsmB3K1HeKZIi0J
AkopbYtW+XmW0A6kkaitB0tmJZLq/62qUv2n10CctznU7wCUATfCRqalS8ErSFO3
6z25z8wtZJBCmutQjgZy6+vYeWdp60SKZFWHXF/wDhUec0h8n6zG4gc4+mYgwSDG
MaEkDesVOJMgdLzJDyV4ytJQzxu3JF2maDhXsE3yUtdl2lgNPRz7yn/F0LiRwpn/
LI3B+2jdUP8yJU2DYwqJQYEmUlXZ5Gmvx1ZBqLZh+W6n/VTNR57OAycO3mY+vWzB
YP4s7j/ETqK5rN06lVWcLU84Bz7qFO8DQXUSPr2J6wTQKbp1wz4=
=SfUn
-----END PGP SIGNATURE-----

--DBUa/BSa4z6QPQv1--
