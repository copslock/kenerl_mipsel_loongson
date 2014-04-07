Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 17:06:13 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:46388 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6816199AbaDGPGLEamih (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 17:06:11 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7D32741F8E28;
        Mon,  7 Apr 2014 16:06:04 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 07 Apr 2014 16:06:04 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 07 Apr 2014 16:06:04 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7B4E947CC4F53;
        Mon,  7 Apr 2014 16:06:01 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 7 Apr
 2014 16:06:04 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 7 Apr 2014 16:06:03 +0100
Received: from localhost (192.168.154.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 7 Apr
 2014 16:06:03 +0100
Date:   Mon, 7 Apr 2014 16:06:03 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH v4 2/2] MIPS: make FPU emulator optional
Message-ID: <20140407150603.GA14803@pburton-linux.le.imgtec.org>
References: <1396868224-252888-1-git-send-email-manuel.lauss@gmail.com>
 <1396868224-252888-2-git-send-email-manuel.lauss@gmail.com>
 <20140407135315.GX14803@pburton-linux.le.imgtec.org>
 <CAOLZvyEZvVQb-3UdXtZa3P8V+fckqT4aCUY9=aKrkdX_GNGc1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kr6QJ6xGUOmSrVQA"
Content-Disposition: inline
In-Reply-To: <CAOLZvyEZvVQb-3UdXtZa3P8V+fckqT4aCUY9=aKrkdX_GNGc1g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.79]
X-ESG-ENCRYPT-TAG: 86d0bfe3
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39680
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

--kr6QJ6xGUOmSrVQA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2014 at 04:48:58PM +0200, Manuel Lauss wrote:
> On Mon, Apr 7, 2014 at 3:53 PM, Paul Burton <paul.burton@imgtec.com> wrot=
e:
> > On Mon, Apr 07, 2014 at 12:57:04PM +0200, Manuel Lauss wrote:
> >> This small patch makes the MIPS FPU emulator optional. The kernel
> >> kills float-users on systems without a hardware FPU by sending a SIGIL=
L.
> >
> > One issue with this is that if someone runs a kernel with the FPU
> > emulator disabled on hardware that has an FPU, they're likely to hit
> > seemingly odd behaviour where FP works just fine until they hit a
> > condition the hardware doesn't support. To make it clear that using FP
> > without the emulator is a bad idea, perhaps it would be safer to disable
> > FP entirely rather than only the emulator? Then userland can die the
> > first time it uses FP instead of when it happens to operate on a
> > denormal.
>=20
> Very good point, I understand.
> How about this addon-patch?  I don't want to sprinkle the whole codebase
> with #ifdef MIPS_FPU_SUPPORT lines.
> Untested, since I don't have any hardware with FPU.
>=20

Failing init_fpu seems reasonable to me, though you could probably just
return before the preempt_disable & avoid that bit of overhead.

Thanks,
    Paul

>=20
> > Unless there are FPUs which never generate an unimplemented operation
> > exception, in which case perhaps more Kconfig is needed to identify such
> > systems & allow the emulator to be disabled for those only.
>=20
> I'd rather keep the simple patch I sent, and maybe hide the option behind
> CONFIG_EXPERT so only people who want to save space and know what
> they're doing can disable it (e.g. OpenWRT).
>=20
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3924396..52de5b8 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2482,19 +2482,16 @@ config MIPS_O32_FP64_SUPPORT
>=20
>           If unsure, say N.
>=20
> -config MIPS_FPU_EMULATOR
> -       bool "MIPS FPU Emulator"
> +config MIPS_FPU_SUPPORT
> +       bool "MIPS FPU Support"
>         default y
>         help
> -         This option lets you disable the built-in MIPS FPU (Coprocessor=
 1)
> -         emulator, which handles floating-point instructions on processo=
rs
> -         without a hardware FPU.  It is generally a good idea to keep the
> -         emulator built-in, unless you are perfectly sure you have a
> -         complete soft-float environment.  With the emulator disabled, a=
ll
> -         users of float operations will be killed with an illegal instr-
> -         uction exception.
> +         Enable support for floating point math, be it hardware FPU or t=
he
> +         kernels' FPU emulator.  With this option disabled, any user of
> +         float math will be killed by illegal instruction exception,
> +         regardless of the availability of hardware floating point suppo=
rt.
>=20
> -         Say Y, please.
> +         Say Y, unless you have a pure soft-float userspace.
>=20
>  config USE_OF
>         bool
> diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
> index c5203bb..ed68719 100644
> --- a/arch/mips/include/asm/fpu.h
> +++ b/arch/mips/include/asm/fpu.h
> @@ -156,13 +156,14 @@ static inline int init_fpu(void)
>         int ret =3D 0;
>=20
>         preempt_disable();
> -       if (cpu_has_fpu) {
> -               ret =3D __own_fpu();
> -               if (!ret)
> -                       _init_fpu();
> -       } else if (IS_ENABLED(CONFIG_MIPS_FPU_EMULATOR))
> -               fpu_emulator_init_fpu();
> -       else
> +       if (IS_ENABLED(CONFIG_MIPS_FPU_SUPPORT)) {
> +               if (cpu_has_fpu) {
> +                       ret =3D __own_fpu();
> +                       if (!ret)
> +                               _init_fpu();
> +               } else
> +                       fpu_emulator_init_fpu();
> +       } else
>                 ret =3D SIGILL;
>=20
>         preempt_enable();
>=20
>=20
> Thanks,
>        Mano

--kr6QJ6xGUOmSrVQA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTQr7bAAoJEIIg2fppPBxl43sP/17wMkeqoyQ+vloUZB38tue6
F9QP0UP00S3uL2PcN6js7dGe20eIPtgBEKOzVyJ8Qz9Qud2jXPaK/o5BV1N3vfBC
Jf/QESQPqnifv/9nQkHgUF2A2oNDee2IWkELMW1Za9bNYx/h7+jLyHOWqKpYzYRv
YkwFbNYIKlxg67R35Q5lk31NPGM6N6u/lw7P/5J5i21Kn2nk0v1tzCO6QAOc56bD
qWWlTpFEHm8ZF9x57HLBe3vFiPhPgA8xJz4yEP1YSITXqbSmIM7awJEyhYDAIaMy
jpUwBE2A30OLHzXOfgy9/sBYV9kp+i/72UjkohFc0xjtIuwVWe8OCm65/sPcGSFt
F378w/gA2p0fmBLzIz5ROO37hNFkbYR9BM9DoG9Qjqt+aTV5n5FBRoDwQrtwIoo5
oec9D2qBUHigyAXbp6Cl7ACoNThjZ7sadxZClHyz+IOgJDn7uNGdjD8yvNydZl79
pmW7mBxjuQUxjWvpIQJpt54h2TQJnQHy5QOmARFnl+QTMb2IFxgoZeuzwc4LIzvC
0wR9aeLac8PetxHr9kwpLuQBssOf2mBivZ+Z7Z7O5f7FrGGYDTZrhRUNMZOWH6bu
Hj0dPdszmgSPyz7o2NbsGJC++JEACYvTg8H49ZCugg+oZtMmwcT48ar5e06goN/6
gk4dNYuBD3ykVvCSnR0P
=Lpa/
-----END PGP SIGNATURE-----

--kr6QJ6xGUOmSrVQA--
