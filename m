Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2014 13:41:09 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:17372 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6816556AbaEOLlAWDVfA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 May 2014 13:41:00 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 8C41B41F8E8C;
        Thu, 15 May 2014 12:40:54 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 15 May 2014 12:40:54 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 15 May 2014 12:40:54 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 99C0C9F899606;
        Thu, 15 May 2014 12:40:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 15 May 2014 12:40:54 +0100
Received: from localhost (192.168.154.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 15 May
 2014 12:40:53 +0100
Date:   Thu, 15 May 2014 12:40:53 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     chenj <chenj@lemote.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
Message-ID: <20140515114053.GW34353@pburton-linux.le.imgtec.org>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
 <1400137743-8806-2-git-send-email-chenj@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E5HUUwS3R9LcK7+r"
Content-Disposition: inline
In-Reply-To: <1400137743-8806-2-git-send-email-chenj@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.79]
X-ESG-ENCRYPT-TAG: 2110538f
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--E5HUUwS3R9LcK7+r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2014 at 03:09:03PM +0800, chenj wrote:
> wsbh & movn are available on loongson3 CPU.
> ---
>  arch/mips/lib/csum_partial.S | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
> index 6cea101..ed88647 100644
> --- a/arch/mips/lib/csum_partial.S
> +++ b/arch/mips/lib/csum_partial.S
> @@ -277,9 +277,12 @@ LEAF(csum_partial)
>  #endif
> =20
>  	/* odd buffer alignment? */
> -#ifdef CONFIG_CPU_MIPSR2
> +#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)

Is there some reason CPU_LOONGSON3 can't select CPU_MIPSR2?

Thanks,
    Paul

> +	.set	push
> +	.set	arch=3Dmips32r2
>  	wsbh	v1, sum
>  	movn	sum, v1, t7
> +	.set	pop
>  #else
>  	beqz	t7, 1f			/* odd buffer alignment? */
>  	 lui	v1, 0x00ff
> @@ -726,9 +729,12 @@ LEAF(csum_partial)
>  	addu	sum, v1
>  #endif
> =20
> -#ifdef CONFIG_CPU_MIPSR2
> +#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)
> +	.set	push
> +	.set	arch=3Dmips32r2
>  	wsbh	v1, sum
>  	movn	sum, v1, odd
> +	.set	pop
>  #else
>  	beqz	odd, 1f			/* odd buffer alignment? */
>  	 lui	v1, 0x00ff
> --=20
> 1.9.0
>=20
>=20

--E5HUUwS3R9LcK7+r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTdKfFAAoJEIIg2fppPBxlk5YP/2NrmfBUSNX+46Co+bivpvd6
eYbdmeVVCnmPe3D5SSk9Enh8NcYxtKi9TffJUZdvMlcN44JSjXOkQP7Rwv4/hfsZ
Ln8lYpgpKbC51oOPZpwF4OftsnIwGPFn7eUrq4Es5ZwtGIwfHhrGExeyqqy3yc2C
1KMdtNwZFNT5I13+wzgdbULB6r5KiYocrtpt+gkbNOpHQhAaGRGtsFAc0ewJmE1j
RJ0xPwSfL62xhrQTsjb5f3OwvzCZJHyIzm7UP2pdpE8wGqujBNAsNyM8/eo8r/kQ
ZAZ7o+bkzMfo6GK4wngx0s5hsTKoXwzdAG0Zi7D/H/pWmY91qijDsrEDPEJFzb+y
/q+io75AXPnsrlpPjJku0i9fhofdtZD2mLOj6emft1pR5cdV4aikuG++VpDEo2lx
KaksIP2oTTIh+W71W/DYmPzUVHTWwcFUADY3wzmOfBW3eh4XPaIr9Uwx3FwHyCNT
GXXr6boUZxz4eLlRe7eh4krnf7zztJ8TKJTf0yJ3x61UrKIlYmNPc31f0m5W76NU
qw4igcJ0Hnc8OUGHUJfigREwVQQ/qhSb2xtt5beIVEepC5AhR4WJc8snDOQeXpTu
AIb4nTYaCLcttcDq7WyucCNhZUIZZ/CIhOItEUFARyAAvFzSBJUDNwiGqAsHwSKQ
zkBlq8K0IgphNwSnaMfE
=d7dE
-----END PGP SIGNATURE-----

--E5HUUwS3R9LcK7+r--
