Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 23:21:32 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990432AbeCVWVUwJbZ4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Mar 2018 23:21:20 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E3F21837;
        Thu, 22 Mar 2018 22:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E3F21837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 22 Mar 2018 22:21:08 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
Message-ID: <20180322222107.GJ13126@saruman>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Content-Disposition: inline
In-Reply-To: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63160
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


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 03:55:16PM +0800, Huacai Chen wrote:
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/comp=
ressed/decompress.c
> index fdf99e9..5ba431c 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -78,11 +78,6 @@ void error(char *x)
> =20
>  unsigned long __stack_chk_guard;

=2E..

> diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed=
/head.S
> index 409cb48..00d0ee0 100644
> --- a/arch/mips/boot/compressed/head.S
> +++ b/arch/mips/boot/compressed/head.S
> @@ -32,6 +32,10 @@ start:
>  	bne	a2, a0, 1b
>  	 addiu	a0, a0, 4
> =20
> +	PTR_LA	a0, __stack_chk_guard
> +	PTR_LI	a1, 0x000a0dff
> +	sw	a1, 0(a0)

Should that not be LONG_S? Otherwise big endian MIPS64 would get a
word-swapped canary (which is probably mostly harmless, but still).

Also I think it worth mentioning in the commit message the MIPS
configuration you hit this with, presumably a Loongson one? For me
decompress_kernel() gets a stack guard on loongson3_defconfig, but not
malta_defconfig or malta_defconfig + 64-bit. I presume its sensitive to
the compiler inlining stuff into decompress_kernel() or something such
that it suddenly qualifies for a stack guard.

Cheers
James

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq0LFMACgkQbAtpk944
dnrmTQ/+JqSPbejJsFyxpccmWIyLBtYPujNEeohQv5ZthOfaooKRy7NvUQqirXxG
HKpHT1EqQtZsXxir/BZxdpo0rN+M/7kMWU9XKLtFqkiz88k1i+k4o7dlrdQcZOqy
HFBPtJnkchJrgBxxzPNxmHnWCxOFoYbK2HBxsn0cBGDm9sgLgXPkMwkAk29fG3uT
ViYFSUhnlmNAo4GBgUkxSFK3rDZZQWq7DFHaMrTEKeJo0SdLtmCt7YD25grSOp0K
klBR1sdHe+oIXQAcowD3xdsLNSNeRoRgtan2Y6ByBLs00+dE7A6D8buruvohh/m4
B37/oeHOEg65kmOVVSnhseaW92YfUyBEkGosJHgV0a9/BoNeN8r1deLgKGb/VYCC
bzOiN0pTzDzPZXvIsWEKibOMrrcm/2Et6Gkh4VawwFEKXZ2ZQAkvwUXFvBjXFwuq
3/V3+bLsrS6mdkvDGe3HcqNEdRhGcjt9uISxGhQtPe30aK9EgtTYH/Ol9GNe/R2l
b/1eEo5RGf0FAko1+xeE81q+xAUPoR4IECl5wj9LQy/KEP7rBSSJj2Ixxl2YMZGg
osFHqfdRh1ihHViu8OMMsT0/qTCH/H953rgGZySpK4twyChK92FMfF2uO7z18NHC
uAylLlojOuGKA0t6HsAEuB64oWg3HV2bYGu1p1yQK5XolLuLrWk=
=1hrp
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
