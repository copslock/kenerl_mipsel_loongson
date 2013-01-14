Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 16:15:51 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:34023 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831947Ab3ANPPtvnVGJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Jan 2013 16:15:49 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 14 Jan 2013 07:15:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,468,1355126400"; 
   d="asc'?scan'208";a="276659674"
Received: from blue.fi.intel.com ([10.237.72.156])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jan 2013 07:15:39 -0800
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id C0CB4E0073; Mon, 14 Jan 2013 17:16:41 +0200 (EET)
Date:   Mon, 14 Jan 2013 17:16:41 +0200
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.8-rc1 build failure with MIPS/SPARSEMEM
Message-ID: <20130114151641.GA17996@otc-wbsnb-06>
References: <20121222122757.GB6847@blackmetal.musicnaut.iki.fi>
 <20121226003434.GA27760@otc-wbsnb-06>
 <20121227121607.GA7097@blackmetal.musicnaut.iki.fi>
 <20121230103850.GA5424@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20121230103850.GA5424@otc-wbsnb-06>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill.shutemov@linux.intel.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 30, 2012 at 12:38:50PM +0200, Kirill A. Shutemov wrote:
> On Thu, Dec 27, 2012 at 02:16:07PM +0200, Aaro Koskinen wrote:
> > Hi,
> >=20
> > On Wed, Dec 26, 2012 at 02:34:35AM +0200, Kirill A. Shutemov wrote:
> > > On MIPS if SPARSEMEM is enabled we've got this:
> > >=20
> > > In file included from /home/kas/git/public/linux/arch/mips/include/as=
m/pgtable.h:552,
> > >                  from include/linux/mm.h:44,
> > >                  from arch/mips/kernel/asm-offsets.c:14:
> > > include/asm-generic/pgtable.h: In function =E2=80=98my_zero_pfn=E2=80=
=99:
> > > include/asm-generic/pgtable.h:466: error: implicit declaration of fun=
ction =E2=80=98page_to_section=E2=80=99
> > > In file included from arch/mips/kernel/asm-offsets.c:14:
> > > include/linux/mm.h: At top level:
> > > include/linux/mm.h:738: error: conflicting types for =E2=80=98page_to=
_section=E2=80=99
> > > include/asm-generic/pgtable.h:466: note: previous implicit declaratio=
n of =E2=80=98page_to_section=E2=80=99 was here
> > >=20
> > > Due header files inter-dependencies, the only way I see to fix it is
> > > convert my_zero_pfn() for __HAVE_COLOR_ZERO_PAGE to macros.
> > >=20
> > > Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
> >=20
> > Thanks, this works.
> >=20
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>=20
> Andrew, could you take the patch?

ping?

--=20
 Kirill A. Shutemov

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ9CFZAAoJEAd+omnVudOMbdUP/24tVWl2QDuay6OFsj6muPt+
fyeM0Rjl+vwOi3UaIz5Xhckf7mVJEE1P/xMkxL2GLf8anJL4fRxrYDE30phPOuOz
YRQ4xGEDzjmfHNLQJgzgUdbcM03RwNazwteFYOHh67/Ag8CkPDUEqWgd/cmDjeKy
Q/DFpxuqrVmgRQ0Mekei5vMGDd/k05piDgGzglsORTcAKxmFTH8R7XA8TtX7VzyN
xI1+TA1hnGbS2lYJVNsoB1Q7FQUSHri06RtBzC8lbk5NDqrrNdilKqwZomuCPwuz
9Qbaiht0+LoVbipPylAspJpJ+wNMCLE7UpGsfwB326Y/io/1lW9D4UAWgYzIVcNw
o48a9v7C8GA0K5VWQg6Ps2t8FsRPsDDIE0asTp6w3yLhrwlvgl46kD5wVlXQDww9
C0CKqV4UYLkyhmK6vHsoH9E9+pgsg420Xd9B7bPmoMOQVshtor9PyMnqNT500v3W
feefsvorH+gDacvIzpHVd685dgi2EcGrNFv3St+qOlMUUJ7STBP8+WF7J8SpTY7/
4OqTyavnLuAwYoQ7fri5S7pBITAPLCrcBe4oIKWFY9d5l6hsCokeMka8en1LBimA
fGaI9i9dOim+aCKbMrCj4Lg18HIxJ45pAfoGnuvoRasslyFW8NhkIClQVI/gbmUq
LFUita7qoobzjt4YCPG7
=M1Vh
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
