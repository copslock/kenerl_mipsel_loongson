Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 12:08:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43930 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009235AbbGMKIN11QJr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 12:08:13 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 006B141F8DED;
        Mon, 13 Jul 2015 11:08:08 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 13 Jul 2015 11:08:08 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 13 Jul 2015 11:08:08 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3A30A68CB1C4C;
        Mon, 13 Jul 2015 11:08:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 13 Jul 2015 11:08:07 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 13 Jul
 2015 11:08:07 +0100
Message-ID: <55A38E0C.4030102@imgtec.com>
Date:   Mon, 13 Jul 2015 11:08:12 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] MIPS: Remove "__weak" definition from arch-specific
 linkage.h
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150712231203.11177.67274.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712231203.11177.67274.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="BD6KHp2lJhjfp8ElKgBALSePdQ05BH6Bf"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: f107b6f
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48224
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

--BD6KHp2lJhjfp8ElKgBALSePdQ05BH6Bf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/07/15 00:12, Bjorn Helgaas wrote:
> "__weak" is defined in include/linux/compiler-gcc.h.  We shouldn't need=
 an
> arch-specific definition.
>=20
> Remove the "__weak" definition from arch/mips/include/asm/linkage.h.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

asm/linkage.h is only included from linux/linkage.h, which includes
linux/compiler.h first, so no chance of build problems AFAICT, therefore:=


Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
>  arch/mips/include/asm/linkage.h |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/mips/include/asm/linkage.h b/arch/mips/include/asm/li=
nkage.h
> index 2767dda..99651b0 100644
> --- a/arch/mips/include/asm/linkage.h
> +++ b/arch/mips/include/asm/linkage.h
> @@ -5,7 +5,6 @@
>  #include <asm/asm.h>
>  #endif
> =20
> -#define __weak __attribute__((weak))
>  #define cond_syscall(x) asm(".weak\t" #x "\n" #x "\t=3D\tsys_ni_syscal=
l")
>  #define SYSCALL_ALIAS(alias, name)					\
>  	asm ( #alias " =3D " #name "\n\t.globl " #alias)
>=20


--BD6KHp2lJhjfp8ElKgBALSePdQ05BH6Bf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVo44MAAoJEGwLaZPeOHZ6MEcP/15D0HZKkxF9eU7EKvmTjQBn
aqqoyTsz7GNYvPediO6ZslLItzHRNf6g8FGv2CgxKFgf9ISgrcydruj/hGwoG52n
iVrkSmvKF1rboX9bZ5yG7CN/TJATh9xzM83n3dHiAEr9kN+MHmZKom1rIQ+DT6Zj
2qLmaGko/SVo2VAQBdzPx79wDQpONLb28K3p208OE2OHAF28I7LnfxuYsPJR+oyz
WHps4CjeJOSly1HNCfSGFwOT+ipHe0kKI57LRyJ+R1Q4HdSLiCXOHhqBQpXYp8FW
LifsEqCH2ZD9AKG9CYblbkZKOLy+R1AMUxpsR4f3DTvZvYAbxNdwSZC975aN8U3e
R5KIDBkmM3VA4UR48JFCcwVU6byv1Vo+Ia+cImNmzRCW93OZTYwN5leiUzGQmLFK
2xulKP0V+GAqzhSOza90uM1xHgMQQWFKip1q5sb9L4pNH1Khzj51kO9DYgADCCtw
2RmYZIz6FH9xVXPBQzaSZf2eCjQAUDJyFqCNUysSg/nwVACu4MIqKY89reAOiim+
IF0bUkS5kFhRIbTmqUd6qBhPNX1fJ9Hp87tPB9+YeJatiCvE+T37h9y2Spkb6va5
eRSdij1hX3xnOpIZLV93Y9aVkasmoE2ppdlbDPKzPV9IvNW4VDiVe26vyZ0q13ys
BR93fw7fply73mFDILJF
=jBfV
-----END PGP SIGNATURE-----

--BD6KHp2lJhjfp8ElKgBALSePdQ05BH6Bf--
