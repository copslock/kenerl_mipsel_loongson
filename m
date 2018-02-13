Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 23:50:17 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994633AbeBMWuJ2LzQH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Feb 2018 23:50:09 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC522172D;
        Tue, 13 Feb 2018 22:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC522172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 13 Feb 2018 22:49:37 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     matt.redfearn@mips.com, antonynpavlov@gmail.com,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
Message-ID: <20180213224937.GF4290@saruman>
References: <1518182572-23376-1-git-send-email-matt.redfearn@mips.com>
 <mhng-a034032e-b23a-4c52-8965-1e9d6e133f43@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline
In-Reply-To: <mhng-a034032e-b23a-4c52-8965-1e9d6e133f43@palmer-si-x1c4>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62533
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


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 01:48:18PM -0800, Palmer Dabbelt wrote:
> On Fri, 09 Feb 2018 05:22:52 PST (-0800), matt.redfearn@mips.com wrote:
> > When these are included into arch Kconfig files, maintaining
> > alphabetical ordering of the selects means these get split up. To allow
> > for keeping things tidier and alphabetical, rename the selects to
> > GENERIC_LIB_*
> >
> > Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>=20
> Thanks!  Do you want me to take this in my tree?
>=20
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Since a new version of the "MIPS: use generic GCC library routines from
lib/" series would depend on it, and it makes sense for that series to
go via the MIPS tree, I think it would be simpler for this patch to also
be taken (with your ack) via the MIPS tree. Is that okay?

Thanks
James

>=20
> > ---
> >  arch/riscv/Kconfig |  6 +++---
> >  lib/Kconfig        | 12 ++++++------
> >  lib/Makefile       | 12 ++++++------
> >  3 files changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 2c6adf12713a..5f1e2188d029 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -99,9 +99,9 @@ config ARCH_RV32I
> >  	bool "RV32I"
> >  	select CPU_SUPPORTS_32BIT_KERNEL
> >  	select 32BIT
> > -	select GENERIC_ASHLDI3
> > -	select GENERIC_ASHRDI3
> > -	select GENERIC_LSHRDI3
> > +	select GENERIC_LIB_ASHLDI3
> > +	select GENERIC_LIB_ASHRDI3
> > +	select GENERIC_LIB_LSHRDI3
> >
> >  config ARCH_RV64I
> >  	bool "RV64I"
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index c5e84fbcb30b..946d0890aad6 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -584,20 +584,20 @@ config STRING_SELFTEST
> >
> >  endmenu
> >
> > -config GENERIC_ASHLDI3
> > +config GENERIC_LIB_ASHLDI3
> >  	bool
> >
> > -config GENERIC_ASHRDI3
> > +config GENERIC_LIB_ASHRDI3
> >  	bool
> >
> > -config GENERIC_LSHRDI3
> > +config GENERIC_LIB_LSHRDI3
> >  	bool
> >
> > -config GENERIC_MULDI3
> > +config GENERIC_LIB_MULDI3
> >  	bool
> >
> > -config GENERIC_CMPDI2
> > +config GENERIC_LIB_CMPDI2
> >  	bool
> >
> > -config GENERIC_UCMPDI2
> > +config GENERIC_LIB_UCMPDI2
> >  	bool
> > diff --git a/lib/Makefile b/lib/Makefile
> > index d11c48ec8ffd..7e1ef77e86a3 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -252,9 +252,9 @@ obj-$(CONFIG_SBITMAP) +=3D sbitmap.o
> >  obj-$(CONFIG_PARMAN) +=3D parman.o
> >
> >  # GCC library routines
> > -obj-$(CONFIG_GENERIC_ASHLDI3) +=3D ashldi3.o
> > -obj-$(CONFIG_GENERIC_ASHRDI3) +=3D ashrdi3.o
> > -obj-$(CONFIG_GENERIC_LSHRDI3) +=3D lshrdi3.o
> > -obj-$(CONFIG_GENERIC_MULDI3) +=3D muldi3.o
> > -obj-$(CONFIG_GENERIC_CMPDI2) +=3D cmpdi2.o
> > -obj-$(CONFIG_GENERIC_UCMPDI2) +=3D ucmpdi2.o
> > +obj-$(CONFIG_GENERIC_LIB_ASHLDI3) +=3D ashldi3.o
> > +obj-$(CONFIG_GENERIC_LIB_ASHRDI3) +=3D ashrdi3.o
> > +obj-$(CONFIG_GENERIC_LIB_LSHRDI3) +=3D lshrdi3.o
> > +obj-$(CONFIG_GENERIC_LIB_MULDI3) +=3D muldi3.o
> > +obj-$(CONFIG_GENERIC_LIB_CMPDI2) +=3D cmpdi2.o
> > +obj-$(CONFIG_GENERIC_LIB_UCMPDI2) +=3D ucmpdi2.o

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqDa4EACgkQbAtpk944
dnrexxAAr9wXIGdNT2PyTPao1ezK/P+aQyddq2sONCsHURGcXn3CiPYNTHLktj/W
Ef92Rxf2cW+vcnWt5mavdy322yE2iiNR6KgYOIkUXhdZ8Jax1xajLZPlcfxsT5en
sWprcgFwTS5KCfzVxOCcWJtk6NjGfqqje/R/KWMiIzk1yeF7nIalA7lE36rx4CqU
Q2nlgCNxsNLYnnTFYyYkAQ1RsYiiC2mh8AVF8ZcfWuAili58M2PKWVkHil+hAkBo
I1OHFBFNYhT7aAxYKxFRKp/6M9lmvmPnB7MPp2kde1iW3AGfF58Lo1lMJ+3ISSr2
aKBgPoX0MuOi0ZtXOFT7tbNWCiv3xVb4qdhuxF1JTW/W84B+MD9Je7xo6uSeW7hQ
CjTEBga2C+52pcT/pwoza2Vgj7X3YPZoUh5rJGasY/zo9PMeQOFIqEqj0p9q5rUn
70zzQ434xp/alcUkzUBN9OkA82mMFW6T5DYBszGolhMI86P/Cojx5qOcO4ORKMWb
8YHMzCqOJRZkVuRtATRpvCgbzEfF+YPpjBdAaIYJLZP54IgDFqlZJJ6+EBBPFyWD
DfA+Ob3QzYSR6T8iNoltatOkJiqmAHQUBBtD4cB8I+WjxzbQH+9fZrz45htROZHE
uQkGIVlYm/k0CVMEbD08GjNLFoxXCxjeUGlivV6woBLES6wGfgk=
=jPpu
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
