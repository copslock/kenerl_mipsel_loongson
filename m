Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 15:53:25 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:17173 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6816886AbaDGNxXOFCkC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 15:53:23 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 65CD241F8E28;
        Mon,  7 Apr 2014 14:53:16 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 07 Apr 2014 14:53:16 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 07 Apr 2014 14:53:16 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 929089F22ADCB;
        Mon,  7 Apr 2014 14:53:13 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 7 Apr
 2014 14:53:16 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 7 Apr 2014 14:53:15 +0100
Received: from localhost (192.168.154.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 7 Apr
 2014 14:53:15 +0100
Date:   Mon, 7 Apr 2014 14:53:15 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH v4 2/2] MIPS: make FPU emulator optional
Message-ID: <20140407135315.GX14803@pburton-linux.le.imgtec.org>
References: <1396868224-252888-1-git-send-email-manuel.lauss@gmail.com>
 <1396868224-252888-2-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2+K7TauFN1Oc3ugB"
Content-Disposition: inline
In-Reply-To: <1396868224-252888-2-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.79]
X-ESG-ENCRYPT-TAG: 86d0bfe3
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39677
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

--2+K7TauFN1Oc3ugB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2014 at 12:57:04PM +0200, Manuel Lauss wrote:
> This small patch makes the MIPS FPU emulator optional. The kernel
> kills float-users on systems without a hardware FPU by sending a SIGILL.

One issue with this is that if someone runs a kernel with the FPU
emulator disabled on hardware that has an FPU, they're likely to hit
seemingly odd behaviour where FP works just fine until they hit a
condition the hardware doesn't support. To make it clear that using FP
without the emulator is a bad idea, perhaps it would be safer to disable
FP entirely rather than only the emulator? Then userland can die the
first time it uses FP instead of when it happens to operate on a
denormal.

Unless there are FPUs which never generate an unimplemented operation
exception, in which case perhaps more Kconfig is needed to identify such
systems & allow the emulator to be disabled for those only.

Thanks,
    Paul

>=20
> Disabling the emulator shrinks vmlinux by about 54kBytes (32bit,
> optimizing for size).
>=20
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> v4: rediffed because of patch 1/2, should now work with micromips as well
> v3: updated patch description with size savings.
> v2: incorporated changes suggested by Jonas Gorski
>     force the fpu emulator on for micromips: relocating the parts
>     of the mmips code in the emulator to other areas would be a
>     much larger change; I went the cheap route instead with this.
>=20
>  arch/mips/Kbuild                     |  2 +-
>  arch/mips/Kconfig                    | 14 ++++++++++++++
>  arch/mips/include/asm/fpu.h          |  5 +++--
>  arch/mips/include/asm/fpu_emulator.h | 15 +++++++++++++++
>  4 files changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
> index d2cfe45..426c264 100644
> --- a/arch/mips/Kbuild
> +++ b/arch/mips/Kbuild
> @@ -16,7 +16,7 @@ obj- :=3D $(platform-)
> =20
>  obj-y +=3D kernel/
>  obj-y +=3D mm/
> -obj-y +=3D math-emu/
> +obj-$(CONFIG_MIPS_FPU_EMULATOR) +=3D math-emu/
> =20
>  ifdef CONFIG_KVM
>  obj-y +=3D kvm/
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 9b53358..3924396 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2482,6 +2482,20 @@ config MIPS_O32_FP64_SUPPORT
> =20
>  	  If unsure, say N.
> =20
> +config MIPS_FPU_EMULATOR
> +	bool "MIPS FPU Emulator"
> +	default y
> +	help
> +	  This option lets you disable the built-in MIPS FPU (Coprocessor 1)
> +	  emulator, which handles floating-point instructions on processors
> +	  without a hardware FPU.  It is generally a good idea to keep the
> +	  emulator built-in, unless you are perfectly sure you have a
> +	  complete soft-float environment.  With the emulator disabled, all
> +	  users of float operations will be killed with an illegal instr-
> +	  uction exception.
> +
> +	  Say Y, please.
> +
>  config USE_OF
>  	bool
>  	select OF
> diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
> index 4d86b72..c5203bb 100644
> --- a/arch/mips/include/asm/fpu.h
> +++ b/arch/mips/include/asm/fpu.h
> @@ -160,9 +160,10 @@ static inline int init_fpu(void)
>  		ret =3D __own_fpu();
>  		if (!ret)
>  			_init_fpu();
> -	} else {
> +	} else if (IS_ENABLED(CONFIG_MIPS_FPU_EMULATOR))
>  		fpu_emulator_init_fpu();
> -	}
> +	else
> +		ret =3D SIGILL;
> =20
>  	preempt_enable();
>  	return ret;
> diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm=
/fpu_emulator.h
> index 283e6f3..df0ca0c 100644
> --- a/arch/mips/include/asm/fpu_emulator.h
> +++ b/arch/mips/include/asm/fpu_emulator.h
> @@ -27,6 +27,7 @@
>  #include <asm/inst.h>
>  #include <asm/local.h>
> =20
> +#ifdef CONFIG_MIPS_FPU_EMULATOR
>  #ifdef CONFIG_DEBUG_FS
> =20
>  struct mips_fpu_emulator_stats {
> @@ -57,6 +58,20 @@ extern int do_dsemulret(struct pt_regs *xcp);
>  extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
>  				    struct mips_fpu_struct *ctx, int has_fpu,
>  				    void *__user *fault_addr);
> +#else	/* no CONFIG_MIPS_FPU_EMULATOR */
> +static inline int do_dsemulret(struct pt_regs *xcp)
> +{
> +	return 0;	/* 0 means error, should never get here anyway */
> +}
> +
> +static inline int fpu_emulator_cop1Handler(struct pt_regs *xcp,
> +				struct mips_fpu_struct *ctx, int has_fpu,
> +				void *__user *fault_addr)
> +{
> +	return SIGILL;	/* we don't speak MIPS FPU */
> +}
> +#endif	/* CONFIG_MIPS_FPU_EMULATOR */
> +
>  int process_fpemu_return(int sig, void __user *fault_addr);
> =20
>  /*
> --=20
> 1.9.1
>=20
>=20

--2+K7TauFN1Oc3ugB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTQq3LAAoJEIIg2fppPBxl+1sQAJCvfmuKKe30NCxArn5c8ZDF
GwxJd12FBDzG/sYoRSP5YlMsfogYZs+96rf/ZaIo+e54bGxuozfyE9pthLVH3pb1
/H3OHl86NBGJ+8b127b7dypE6ZKghhFWUE8tL3N87ZbAv14DBBOg86VfqvtSZp6B
8VfAdQS6IYMaXq3c6y8gRceHhOS8cgJWv//jKJgkIBzRmqFc3KljwLVSNThTDrnI
m+cP2HpBQf78fV3rwqkLzlIUIBfxsk80n9FO6JfdDM2rNKhexH5eqZ/oedxuymCG
ZNKx22mJGnwfeYGSHpi0jf4m9LjVJshqB8o2jaZiVQV5iofIPSiWlPEnoB0j52gV
6y7vwJsJ36KPH/UgNZV6WPZ4sBv01fu/Qqrx1R/dpJbp+YC66wbcix7yfqyXNcah
NgirYa2CZ310E/TVthoT4iAXk8mw1QKgXexH0J3oT2+xw+ihCQ+pJ3xtQCxRFGeq
/b45iMIrEAQidK9n2r91E4ocAwwPKfkPDzPdOYXtEoObhCOXN1MBOMUY8KYcvUhg
1+6zL7rUoBLL/kV2kEBGPSXOS5IaXssX/TzHzVEBiK0UXJaA2jOYcF82RKFzZ7sM
ydq9EritqA1XsunVQonI5spgn89GUKBCj3lI6nvpZQ8zIgEOSwAg+aZXRbC00/eG
t3HjgdHa5++vXN0V3trx
=pf9A
-----END PGP SIGNATURE-----

--2+K7TauFN1Oc3ugB--
