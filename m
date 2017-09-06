Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 15:36:31 +0200 (CEST)
Received: from smtp6-g21.free.fr ([IPv6:2a01:e0c:1:1599::15]:64151 "EHLO
        smtp6-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993085AbdIFNgW4EQ4w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2017 15:36:22 +0200
Received: from avionic-0141 (unknown [80.187.109.50])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 021AB7802E5;
        Wed,  6 Sep 2017 15:35:54 +0200 (CEST)
Date:   Wed, 6 Sep 2017 15:35:43 +0200
From:   Alban <albeu@free.fr>
To:     Rocco Folino <rocco.folino@gmail.com>
Cc:     Alban <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH] MIPS: ath79: support devicetree selection
Message-ID: <20170906153543.412774d5@avionic-0141>
In-Reply-To: <20170906123200.GA21761@void>
References: <b78cb3ef8df8531efdb7b011743ad3f38978015d.1503070362.git.rocco.folino@gmail.com>
        <20170906111435.GA1856@linux-mips.org>
        <20170906142005.67586253@avionic-0141>
        <20170906123200.GA21761@void>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jQU_dr4pSoNtL.jEuVZBYlU"; protocol="application/pgp-signature"
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59950
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

--Sig_/jQU_dr4pSoNtL.jEuVZBYlU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Sep 2017 14:32:00 +0200
Rocco Folino <rocco.folino@gmail.com> wrote:

> On Wed, Sep 06, 2017 at 02:20:05PM +0200, Alban wrote:
> > On Wed, 6 Sep 2017 13:14:35 +0200
> > Ralf Baechle <ralf@linux-mips.org> wrote:
> >  =20
> > > On Fri, Aug 18, 2017 at 05:32:42PM +0200, Rocco Folino wrote:
> > >  =20
> > > > Allow to choose devicetrees from Kconfig.
> > > >=20
> > > > Signed-off-by: Rocco Folino <rocco.folino@gmail.com> =20
> >=20
> > I don't really see the point of this patch. Building the dtb doesn't
> > take any significant time, so why add this extra complexity? =20
>=20
> Because you need to select the SoC type in order to enable some
> drivers, for example on the AR9331 to use the serial you need the
> CONFIG_SERIAL_AR933X which depends on the CONFIG_SOC_AR933X.

Seeing as this driver is the only one that make use of CONFIG_SOC_AR933X
I would prefer removing this dependency. It would also open the way to have
the driver built in COMPILE_TEST. A few more fixes might be needed but that
would be better than such a workaround.

Alban

--Sig_/jQU_dr4pSoNtL.jEuVZBYlU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZr/mvAAoJEHSUmkuduC28kxgQAORFiqXKg1pw3+lEg+hDkq2C
Mrjn8RYda6beNv7MgoCsPPzUEj9D0cNF7KrkQW48FPmdLl0ffqXRXgljEYOxSk6m
M7aiEiT954SqtWpxkIkV18E+wWmsaIUFeiS6occwl2l6h1Sk9dORMiqgXigCYNXP
kJ7KQVBt2V3Xs8uv8gCL/8kXGaSTkvgFwu8Sp7SnbBIVBIXihkOD9CCaQtZmS4Tv
MGg1qGdBV+BGBTRLavPuh0jchJXtv4GdYw1/NJeFAgeFHvt45o2X2RAnSDa7RcQy
mhdVMiN3K5KksiWyKeucZYI06DzlVZON7Pw4ABPcX9HMZoa6BtzFaeuaaouBF1Dh
yanSrxug9Kj1T9BxKkHSn162u5Ku1s8CeAO4IlsErXP0JK4nIDEmgFkxbz/tlSiT
c/iHGRwGk3Hu3adzwb45yVREGat9HQgzbyhTi9laoDWmM5wlT17INhfm8J3ETrPd
3RVy1IbOIlmvKE6svwGZENXrSisscSdFFBn7WKGP7y5pOVCirreFxcqBjj1LjHtz
TZLKR8dKcecVsQnoroI0gl5fBLAw9jzg3pGdzgLoOVrF1MqgiS+HHFncb7CppdS8
DKv2J3FqjjYr+42keoBRXD37OdPoLCcdD7TsUN7wSHI+TCS81xPWc9ItglAvbRTd
I7It/C/KXTjHPkdTe/Ei
=NCtQ
-----END PGP SIGNATURE-----

--Sig_/jQU_dr4pSoNtL.jEuVZBYlU--
