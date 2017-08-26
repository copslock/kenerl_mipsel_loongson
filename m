Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Aug 2017 02:35:06 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49223 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994820AbdHZAe4UtzdF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Aug 2017 02:34:56 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dlP3k-0007d5-IO; Sat, 26 Aug 2017 01:34:44 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dlP3f-0006ed-Cr; Sat, 26 Aug 2017 01:34:39 +0100
Message-ID: <1503707679.3688.66.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 032/134] MIPS: Loongson-3: Select
 MIPS_L1_CACHE_SHIFT_6
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, akpm@linux-foundation.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        "Steven J . Hill" <Steven.Hill@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        John Crispin <john@phrozen.org>
Date:   Sat, 26 Aug 2017 01:34:39 +0100
In-Reply-To: <CAAhV-H5r8Mv8YjBBBooXc4zmaZkNq9MHBpxtTZ4V-YozC8w4xQ@mail.gmail.com>
References: <lsq.1503061998.818387115@decadent.org.uk>
         <lsq.1503062000.223402560@decadent.org.uk>
         <CAAhV-H5r8Mv8YjBBBooXc4zmaZkNq9MHBpxtTZ4V-YozC8w4xQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-TL66Rw3xCyC5oDGx1tss"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-TL66Rw3xCyC5oDGx1tss
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-08-21 at 10:24 +0800, Huacai Chen wrote:
> 3.16 doesn't need this, because 3.16 doesn't support Loongson-3 R2/R3.

Thanks, I'll drop this.

Ben.

> Huacai
>=20
> > On Fri, Aug 18, 2017 at 9:13 PM, Ben Hutchings <ben@decadent.org.uk> wr=
ote:
> > 3.16.47-rc1 review patch.=C2=A0=C2=A0If anyone has any objections, plea=
se let me know.
> >=20
> > ------------------
> >=20
> > > > From: Huacai Chen <chenhc@lemote.com>
> >=20
> > commit 17c99d9421695a0e0de18bf1e7091d859e20ec1d upstream.
> >=20
> > Some newer Loongson-3 have 64 bytes cache lines, so select
> > MIPS_L1_CACHE_SHIFT_6.
> >=20
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Cc: John Crispin <john@phrozen.org>
> > Cc: Steven J . Hill <Steven.Hill@caviumnetworks.com>
> > Cc: Fuxin Zhang <zhangfx@lemote.com>
> > Cc: Zhangjin Wu <wuzhangjin@gmail.com>
> > Cc: linux-mips@linux-mips.org
> > Patchwork: https://patchwork.linux-mips.org/patch/15755/
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > [bwh: Backported to 3.16: adjust context]
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> > =C2=A0arch/mips/Kconfig | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -1193,6 +1193,7 @@ config CPU_LOONGSON3
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CPU_SUPPORTS_HUG=
EPAGES
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WEAK_ORDERING
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WEAK_REORDERING_=
BEYOND_LLSC
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select MIPS_L1_CACHE_SHIFT_6
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0The Loongson 3 processor implements the MIPS64R2=
 instruction
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0set with many extensions.
> >=20
> >=20
--=20
Ben Hutchings
One of the nice things about standards is that there are so many of
them.


--=-TL66Rw3xCyC5oDGx1tss
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlmgwh8ACgkQ57/I7JWG
EQn/xBAAyyNJnOjZ82J2cpCfsO05oGIvNrDhQYU34zjejruHdi25PVcSbXQGrwVq
7yH/WZjE7NtUMwpWdZ7CrCnfTg71S6sXzAni7BUqIzDAWVdHYA0rM5Ep/djd9O9u
YmhfjPiQEsuCX7/OuXvYem5aMTDLKv6LiPuFQ7Idy6r4OOaFF6MugFCwdyJsmsOG
7MI0ceas4duQSUe+ri25wyFlI9SLEy/qEJ7ev54A62q2W3b/hXl6wKlfpNnJ+ocJ
JVwJtb5hkm8jmdT7EnR97Uzvgiz78ZoUBa02Xkj+Dwz7Is9r70CE2ZvrjkTW1ftJ
AWwrRvXzcck1WOxWH9yVvKnh29xZZ+kgm8BP/VsfJA04LN1qVouUUqTGHol87mSN
imSptbn+8CRtfUu4jdESEsQE22YDlqJmmmxr5XvY+Q0OULw1zBLqGYbaJLNebsHW
aOzSC9l+tt4B9jmJz/pQuXz6h38JDRVY6n/lJbGlkqQxPZ/kaXLjj/ACVgBIqPSh
nFdsG+zCNJGz67q/tIX6lnYvXrwm+MjYaeIv9PvzzZTWfdOhsLOSAyqQF9/ZBBfU
D6Su/kaIiufV/nX3YsRS3+r/3ZL7Fr713HCy05Vy61HW3f2yttxLvd38CpjzBHru
HRj864il4xnCIWCz1RlwshkUahahpQnPZlLgcaMnkT0p5w6PO8s=
=mTh1
-----END PGP SIGNATURE-----

--=-TL66Rw3xCyC5oDGx1tss--
