Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2017 22:54:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30208 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990474AbdI2Uy1aRz2k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2017 22:54:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E15755BC46F93;
        Fri, 29 Sep 2017 21:54:16 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 29 Sep
 2017 21:54:21 +0100
Date:   Fri, 29 Sep 2017 21:54:20 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH v2 01/12] MIPS: Add nudges to writes for bit unlocks.
Message-ID: <20170929205343.GA24591@jhogan-linux.le.imgtec.org>
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
 <1506620053-2557-2-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <1506620053-2557-2-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60203
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

--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Thu, Sep 28, 2017 at 12:34:02PM -0500, Steven J. Hill wrote:
> From: Chad Reese <kreese@caviumnetworks.com>
>=20
> Flushing the writes lets other CPUs waiting for the lock to get it
> sooner.
>=20
> Signed-off-by: Chad Reese <kreese@caviumnetworks.com>
> Signed-off-by: David Daney <david.daney@cavium.com>

I think this needs your SOB too.

Cheers
James

> ---
>  arch/mips/include/asm/bitops.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitop=
s.h
> index fa57cef..da1b871 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -456,6 +456,7 @@ static inline void __clear_bit_unlock(unsigned long n=
r, volatile unsigned long *
>  {
>  	smp_mb__before_llsc();
>  	__clear_bit(nr, addr);
> +	nudge_writes();
>  }
> =20
>  /*
> --=20
> 2.1.4
>=20
>=20

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlnOsvwACgkQbAtpk944
dnqjohAAuC82aXZaQa88hYNxtQBFaJlZzECCYxJ/ewN/2eGnGgk47mSIdNvR5CRj
eVq53OZgrLKG+feIfv7oDZV5eg4g2foK+fnIYQA9yUKwtbLbRSPms56T3/u8z9Ye
knXP5PYs+xx+Yde76hydNk79CDML5HF7hFBhFfMn+ZKaficz62yOymkIekT5y1yh
jqx+strOEGQUJdK8w+dZgW3cohmT48V/wNSj6olJNzkWH8+JpifU0DSxrsY/x+kn
PBbkX15NH6qMtyqcTMlmRnx45Vc+Bir7LD3ScZrjl+iuHw2WKXWV/x9uxxHyrGPv
j7r27F7ol8EQ+psLbSO7qfM1wcnPek9dZU5ElMWlpUHeAAf9agp2WPfb0rPBSKVr
15s1pbGwmqV/KNrYdnWNPWQ3Oeg5oSlq/mOHVykWOJQEbRQkl+XK7xF6Ec4cF2yP
LouOAVaozgZx2QVXoBS+kJH9Zk8vjRQzxj0dNyhkUqSdJXrAdJ/OfhzENkICVrha
u3zJKeFSB5VQQcIBK87LHGRF3EeGhVzWecT7I+wDkBjzCATwIJofJUyG3lRJ5VDu
vnGbcUbt92KhalqTcoDLsG/Ukngk5IkwLz+vzd8+QsNqDQ7ye90u2JyxAD1wH04n
K4H7MZ7JL3TWKyo7spz/vhC3CXySXbkRi8AaCpclWiLALgJtRiI=
=hOfC
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
