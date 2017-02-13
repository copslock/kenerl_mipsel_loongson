Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2017 09:37:57 +0100 (CET)
Received: from smtp5-g21.free.fr ([212.27.42.5]:26582 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993331AbdBMIhuNcikQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Feb 2017 09:37:50 +0100
Received: from tock (unknown [2.247.253.223])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id DD23F5FFCC;
        Mon, 13 Feb 2017 09:37:39 +0100 (CET)
Date:   Mon, 13 Feb 2017 09:37:36 +0100
From:   Alban <albeu@free.fr>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Allow compressed images to be loaded at the usual
 address
Message-ID: <20170213093736.1ee183f3@tock>
In-Reply-To: <CAOiHx=nwBgVnZp1x2TcDVNx1hA2KYwwQnYSbCsCOJpNo-SLJPg@mail.gmail.com>
References: <1486326077-17091-1-git-send-email-albeu@free.fr>
        <CAOiHx=nwBgVnZp1x2TcDVNx1hA2KYwwQnYSbCsCOJpNo-SLJPg@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4ILNor26cixMDxa7eSjnB/t"; protocol="application/pgp-signature"
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

--Sig_/4ILNor26cixMDxa7eSjnB/t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Feb 2017 13:22:37 +0100
Jonas Gorski <jonas.gorski@gmail.com> wrote:

> Hi,
>=20
> On 5 February 2017 at 21:21, Alban <albeu@free.fr> wrote:
> > From: Alban Bedel <albeu@free.fr>
> >
> > Normally compressed images have to be loaded at a different address to
> > allow the decompressor to run. This add an option to let vmlinuz copy
> > itself to the correct address from the normal vmlinux address.
> >
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >  arch/mips/Kconfig                |  8 ++++++++
> >  arch/mips/boot/compressed/head.S | 13 +++++++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index b3c5bde..8074fc5 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -2961,6 +2961,14 @@ choice
> >                 bool "Extend builtin kernel arguments with bootloader a=
rguments"
> >  endchoice
> >
> > +config ZBOOT_VMLINUZ_AT_VMLINUX_LOAD_ADDRESS
> > +       bool "Load compressed images at the same address as uncompresse=
d"
> > +       depends on SYS_SUPPORTS_ZBOOT
> > +       help
> > +         vmlinux and vmlinuz normally have different load addresses, w=
ith
> > +         this option vmlinuz expect to be loaded at the same address as
> > +         vmlinux.
> > +
> >  endmenu =20
>=20
> Okay, it took me a while to understand the intention of this change. I
> thought it was for supporting the case that VMLINUZ_LOAD_ADDRESS =3D=3D
> VMLINUX_LOAD_ADDRESS, but it is indented for  VMLINUZ_LOAD_ADDRESS !=3D
> VMLINUX_LOAD_ADDRESS, but still being loaded at VMLINUX_LOAD_ADDRESS.
>=20
> So I guess that this can only happen with vmlinuz.bin, as vmlinux's
> ELF header will cause it to be loaded at the expected address (for
> sane bootloaders at least).

Yes, this is for bootloaders that use raw images. Having to configure
different load addresses for compressed and uncompressed images was just
too annoying.

> >  config LOCKDEP_SUPPORT
> > diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compress=
ed/head.S
> > index 409cb48..a215171 100644
> > --- a/arch/mips/boot/compressed/head.S
> > +++ b/arch/mips/boot/compressed/head.S
> > @@ -25,6 +25,19 @@ start:
> >         move    s2, a2
> >         move    s3, a3
> >
> > +#ifdef CONFIG_ZBOOT_VMLINUZ_AT_VMLINUX_LOAD_ADDRESS =20
>=20
> With a bit of BAL trickery you could easily detect this at runtime and
> then conditionally copy without requiring any additional config
> symbols. Then you aren't limited to being executed from
> VMLINUX_LOAD_ADDRESS.

Could you expand a bit on what you mean with "BAL trickery"? I hoped
that it would be possible to auto detect the current running address,
but as I know very little about MIPS assembly I didn't found how that
could be done.

Alban

--Sig_/4ILNor26cixMDxa7eSjnB/t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoXBQAAoJEHSUmkuduC28KSYP/RdK2Rg5l+PjzXo5AOU7969+
wfQzFZEcK+i4134/SBFPHEvSEeE/nU+bq5zXm/rpT9LYj/PE2BVwRlQ7LG/RlUS0
eNJKEfM8KGHY7VlndH502xnAHvhuaEOu7Ipbjchoop7ElBdjgFmYdinrZeRaWMJO
fQs3PucHfDG+5hU+Cjz+URx6P2P31K3b2domW4Cza2TqD+lZfVWaOM+wXyu3RLsW
mQ0y56CuFnza7rZU12C2PzvD4+lmE21E+/guIBV+6ocDlLw62tma3y0bQTgaSsmR
XV3FzmbVEHQAUZNawenX80IIjfP8noXQmLX42f1EA3QSaTwwSmgucUYG1XrqxDI/
rFOQYIFGGKEilYeUjWSoatv8b5BXjDJ02mxmQDWdT1whYmcL+ZwtZ4CjC49W3exA
0NCXvY6QUPi6JZJtlDDaOevZZkJgFDY8An7wXN1dhFbDTuQcWk/d+e39gx2F4PCo
IWQVKu+gj3j+8zA2C13VDANHewnwH2eXYHo1fHtNMoArhQcGrKqkb65S9znNrpTD
n4beG8YJIAzpIioL7BeJTPzW7FyfwjstQYs/1JzrJER0OstEAvIyPYRjPXoNcs/M
pQl9ahhPiERUf1GSRIeY0r5R9yulnifMnknMfGoPr50FKKpJvq4yTlbbeGbAis/o
9EBMtdAXGkDc/sMfIiL4
=SAkT
-----END PGP SIGNATURE-----

--Sig_/4ILNor26cixMDxa7eSjnB/t--
