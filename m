Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 12:03:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15735 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992466AbdGKKDuD0RC0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jul 2017 12:03:50 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 8F60141F8E67;
        Tue, 11 Jul 2017 12:14:22 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 11 Jul 2017 12:14:22 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 11 Jul 2017 12:14:22 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A476DEFDD033A;
        Tue, 11 Jul 2017 11:03:41 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Jul
 2017 11:03:44 +0100
Date:   Tue, 11 Jul 2017 11:03:43 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
CC:     Aleksa Sarai <asarai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Valentin Rothberg <vrothberg@suse.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        <linux-kernel@vger.kernel.org>, <linux-alpha@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-parisc@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-sh@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
Message-ID: <20170711100343.GP31455@jhogan-linux.le.imgtec.org>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zfao1/4IORAeFOVj"
Content-Disposition: inline
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59090
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

--Zfao1/4IORAeFOVj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 03:12:17AM +0300, Gleb Fotengauer-Malinovskiy wrote:
> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.
>=20
> Fixes: 54ebbfb1 ("tty: add TIOCGPTPEER ioctl")

I think its recommended these days to include at least 12 nibbles of
commit hash, i.e.

Fixes: 54ebbfb16034 ("tty: add TIOCGPTPEER ioctl")

(consider setting your git default to 12 with this):
git config core.abbrev 12

Cheers
James

> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> ---
>  arch/alpha/include/uapi/asm/ioctls.h   | 2 +-
>  arch/mips/include/uapi/asm/ioctls.h    | 2 +-
>  arch/parisc/include/uapi/asm/ioctls.h  | 2 +-
>  arch/powerpc/include/uapi/asm/ioctls.h | 2 +-
>  arch/sh/include/uapi/asm/ioctls.h      | 2 +-
>  arch/sparc/include/uapi/asm/ioctls.h   | 2 +-
>  arch/xtensa/include/uapi/asm/ioctls.h  | 2 +-
>  include/uapi/asm-generic/ioctls.h      | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/ua=
pi/asm/ioctls.h
> index ff67b837..1cd7dc7 100644
> --- a/arch/alpha/include/uapi/asm/ioctls.h
> +++ b/arch/alpha/include/uapi/asm/ioctls.h
> @@ -100,7 +100,7 @@
>  #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
>  #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
>  #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
> =20
>  #define TIOCSERCONFIG	0x5453
>  #define TIOCSERGWILD	0x5454
> diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi=
/asm/ioctls.h
> index 68e19b6..1609cb0 100644
> --- a/arch/mips/include/uapi/asm/ioctls.h
> +++ b/arch/mips/include/uapi/asm/ioctls.h
> @@ -91,7 +91,7 @@
>  #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
>  #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
>  #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
> =20
>  /* I hope the range from 0x5480 on is free ... */
>  #define TIOCSCTTY	0x5480		/* become controlling tty */
> diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/=
uapi/asm/ioctls.h
> index 674c68a..d0e3321 100644
> --- a/arch/parisc/include/uapi/asm/ioctls.h
> +++ b/arch/parisc/include/uapi/asm/ioctls.h
> @@ -60,7 +60,7 @@
>  #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
>  #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
>  #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
> =20
>  #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
>  #define FIOCLEX		0x5451
> diff --git a/arch/powerpc/include/uapi/asm/ioctls.h b/arch/powerpc/includ=
e/uapi/asm/ioctls.h
> index bfd609a..e3b1046 100644
> --- a/arch/powerpc/include/uapi/asm/ioctls.h
> +++ b/arch/powerpc/include/uapi/asm/ioctls.h
> @@ -100,7 +100,7 @@
>  #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
>  #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
>  #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
> =20
>  #define TIOCSERCONFIG	0x5453
>  #define TIOCSERGWILD	0x5454
> diff --git a/arch/sh/include/uapi/asm/ioctls.h b/arch/sh/include/uapi/asm=
/ioctls.h
> index eec7901..787bac9 100644
> --- a/arch/sh/include/uapi/asm/ioctls.h
> +++ b/arch/sh/include/uapi/asm/ioctls.h
> @@ -93,7 +93,7 @@
>  #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
>  #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
>  #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
> =20
>  #define TIOCSERCONFIG	_IO('T', 83) /* 0x5453 */
>  #define TIOCSERGWILD	_IOR('T', 84,  int) /* 0x5454 */
> diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/ua=
pi/asm/ioctls.h
> index 6d27398..f5df72b 100644
> --- a/arch/sparc/include/uapi/asm/ioctls.h
> +++ b/arch/sparc/include/uapi/asm/ioctls.h
> @@ -88,7 +88,7 @@
>  #define TIOCGPTN	_IOR('t', 134, unsigned int) /* Get Pty Number */
>  #define TIOCSPTLCK	_IOW('t', 135, int) /* Lock/unlock PTY */
>  #define TIOCSIG		_IOW('t', 136, int) /* Generate signal on Pty slave */
> -#define TIOCGPTPEER	_IOR('t', 137, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('t', 137) /* Safely open the slave */
> =20
>  /* Little f */
>  #define FIOCLEX		_IO('f', 1)
> diff --git a/arch/xtensa/include/uapi/asm/ioctls.h b/arch/xtensa/include/=
uapi/asm/ioctls.h
> index 98b004e..47d82c0 100644
> --- a/arch/xtensa/include/uapi/asm/ioctls.h
> +++ b/arch/xtensa/include/uapi/asm/ioctls.h
> @@ -105,7 +105,7 @@
>  #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
>  #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
>  #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
> =20
>  #define TIOCSERCONFIG	_IO('T', 83)
>  #define TIOCSERGWILD	_IOR('T', 84,  int)
> diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic=
/ioctls.h
> index 06d5f7d..14baf9f2 100644
> --- a/include/uapi/asm-generic/ioctls.h
> +++ b/include/uapi/asm-generic/ioctls.h
> @@ -77,7 +77,7 @@
>  #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
>  #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
>  #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
> =20
>  #define FIONCLEX	0x5450
>  #define FIOCLEX		0x5451
>=20
> --=20
> glebfm
>=20

--Zfao1/4IORAeFOVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllkonYACgkQbAtpk944
dnr0zA/9HKpKqlgodicAvtqRseBGnkcEEKwmoKGq0rDDYUaoa7kW+9uKE8p2TJE6
jygBer5aCyRXY9z6+l6DYGaY2YxFWoe0mp7gdD49/4Cde+zGH4DX7ePZPnAG+uit
fweeIo9oG2f8Q4hnv6cD9Pi1svYugfZIPz5WuuI7LixlW87RbZONgpJqzgjiuRqv
n+/8HOqMIecu8UzQ940XaRA2YfoEJ4aqTVQXXbcSpcov/C/Jk0gUbch8HSSnuG4Z
UP1my0m61lKjmuIJhRK2lGcCprZfIuZyJmuTZySJjnEwCYChxkUkW1jmHUnoGREI
Go74baDV4H8e2AOmMzSn5wmRoU+evbgmyrSLT+qvvWfUxGYL3cKUg8SzRZLW3yvE
H7+q0gzMuYlAUeyQWxsyfuX28AqyHLgBxkvegO9AgET2QLgmv5S9uRGaGCXP8ct9
002gG6oqkHqB+FS0WI41R7svCx+QgYyxBNxkZPNA5/1VNbJGfMpr16BvOR9ARQO6
GcGnfsB61DcZrJLOHrYIyC5jPbpYyd3f60AU2cencEqiiO0IRmjFNB0Dspmf8CC9
BX5FJGlGgYVSODi8RAbWLWYdmXAKrt6+V0aBGqHOuNclC7TAC4dB02BYynTBRs0/
IFFylTMJwEm41p6tkrTnyG8SgAEK7ZU0SoZjJSpk+hENBUvRKqI=
=qoHc
-----END PGP SIGNATURE-----

--Zfao1/4IORAeFOVj--
