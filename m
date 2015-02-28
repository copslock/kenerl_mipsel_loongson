Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Feb 2015 02:37:10 +0100 (CET)
Received: from ozlabs.org ([103.22.144.67]:50804 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007597AbbB1BhIWJMa4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Feb 2015 02:37:08 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 32054140146;
        Sat, 28 Feb 2015 12:37:03 +1100 (AEDT)
Date:   Sat, 28 Feb 2015 12:36:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] seccomp: switch to using asm-generic for seccomp.h
Message-ID: <20150228123656.538301ef@canb.auug.org.au>
In-Reply-To: <20150228005228.GA23638@www.outflux.net>
References: <20150228005228.GA23638@www.outflux.net>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; i586-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OELWuzD5PC91fjVQFZ1t_+c"; protocol="application/pgp-signature"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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

--Sig_/OELWuzD5PC91fjVQFZ1t_+c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Fri, 27 Feb 2015 16:52:29 -0800 Kees Cook <keescook@chromium.org> wrote:
>
> diff --git a/arch/arm/include/asm/seccomp.h b/arch/arm/include/asm/seccom=
p.h
> index 52b156b341f5..66ca6a30bf5c 100644
> --- a/arch/arm/include/asm/seccomp.h
> +++ b/arch/arm/include/asm/seccomp.h
> @@ -1,11 +1 @@
> -#ifndef _ASM_ARM_SECCOMP_H
> -#define _ASM_ARM_SECCOMP_H
> -
> -#include <linux/unistd.h>
> -
> -#define __NR_seccomp_read __NR_read
> -#define __NR_seccomp_write __NR_write
> -#define __NR_seccomp_exit __NR_exit
> -#define __NR_seccomp_sigreturn __NR_rt_sigreturn
> -
> -#endif /* _ASM_ARM_SECCOMP_H */
> +#include <asm-generic/seccomp.h>

I think that these cases (where you replace the file by a stub that
just include <asm-generic/seccomp.h>) can be replaced by removing the
file completely and adding

generic-y =3D seccomp.h

to <ARCH>/include/asm/Kbuild

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/OELWuzD5PC91fjVQFZ1t_+c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU8Ru9AAoJEMDTa8Ir7ZwVpvIP/jZNouddKAUOjxkrLO0Cmwgl
4N0nD+bHWvWZB0ecfKFFbj9Uk1sd9o2JlJVD3gCRXdoqfS6+wTdxttX3RDzW39QB
0Xo0ivy6naWah73Ux95XN3W8ZH7Wq1oJpV5MNiJj2JbSFnkit6KwmueLV0+ELbIX
xrsu3ZlgDwXxZAFuj5z05SPUmGEj4PCgnr2/+xfYNYb1Uw3ZKikrlApJTT3oiiBW
dcpnN2xdDREFTcE6FtroCLPSj7oglx5fONowhxpcdHLIa77Lg/OQD1stfcsnNRiL
8dCJhe1G/wpv/BeRnJ43Xgdb0B/9W5AlIUi3Z/O0EXaHSwKIxShgd6+7o0f/AmUY
ohHqjJAfhILz5o/ivI54PGG0Z8QwLKfCYbqicG8mK3iIo1s9WwK/0oP1BJD9Mf/f
hsMnNdvqABbardBVdoGyjIwn6gds4CQnGVhdViuV2YZA2ZIL8TDqh/vnx1BlLvR1
FjJti/BF8zjnR1bNPvosMaIQLYGhbRfCc4EqoZHIHSkBcM8LOI/xwLCFtZtl/q/2
Tv9CUz35WCBNwZZObh/ZCzsJ4FWIPQA4rJyDuAToORVRWwmFXYtZSi113+MwFW31
cM1fVgakXfIZ04j4qJaKd/EdouMuIggrbhqGhz7GybnD1c5rOV4kZeducuM2ysT6
cjY2pr0NiBKGphJ3yISb
=VLZN
-----END PGP SIGNATURE-----

--Sig_/OELWuzD5PC91fjVQFZ1t_+c--
