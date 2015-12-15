Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Dec 2015 22:06:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38361 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013883AbbLOVG2VnC9V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Dec 2015 22:06:28 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E3E0941F8E29;
        Tue, 15 Dec 2015 21:06:22 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 15 Dec 2015 21:06:22 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 15 Dec 2015 21:06:22 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 410B5E938F7C0;
        Tue, 15 Dec 2015 21:06:19 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 15 Dec 2015 21:06:22 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 15 Dec
 2015 21:06:22 +0000
Date:   Tue, 15 Dec 2015 21:06:22 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Nikolay Martynov <mar.kolya@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: Fix CPC_BASE_ADDR mask to match datasheet
Message-ID: <20151215210622.GP23944@jhogan-linux.le.imgtec.org>
References: <1449599222-8967-1-git-send-email-mar.kolya@gmail.com>
 <CALGY4fu3NUAsc-y7zqPx_o=ggea+1yvs_QYV9PyCVOkkgugUrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GvDmwISikgK05D7L"
Content-Disposition: inline
In-Reply-To: <CALGY4fu3NUAsc-y7zqPx_o=ggea+1yvs_QYV9PyCVOkkgugUrw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50634
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

--GvDmwISikgK05D7L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nikolay,

On Mon, Dec 14, 2015 at 07:31:29PM -0500, Nikolay Martynov wrote:
> Hi.
>=20
>   I just wanted to confirm that this is the right list for this kind
> of patches. Please let me know if I should submit it to some other
> place.

You have the right list. All patches to this list go into patchwork[1],
so they shouldn't get forgotten.

The patch looks correct to me based on interAptiv and P5600 manuals, and
the current uses of these definitions.
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks!
James

[1] http://patchwork.linux-mips.org

>=20
> Thanks!
>=20
> 2015-12-08 13:27 GMT-05:00 Nikolay Martynov <mar.kolya@gmail.com>:
> > According to 'MIPS32=C2=AE interAptivTM Multiprocessing
> > System Programmer=E2=80=99s Guide' CPC_BASE_ADDR takes bits [31:15].
> >
> > This change is tested ith mt7621 which wasn't working without it.
> >
> > Signed-off-by: Nikolay Martynov <mar.kolya@gmail.com>
> > ---
> >  arch/mips/include/asm/mips-cm.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mi=
ps-cm.h
> > index 6516e9d..f942ec2 100644
> > --- a/arch/mips/include/asm/mips-cm.h
> > +++ b/arch/mips/include/asm/mips-cm.h
> > @@ -286,8 +286,8 @@ BUILD_CM_Cx_R_(tcid_8_priority,     0x80)
> >  #define CM_GCR_GIC_BASE_GICEN_MSK              (_ULCAST_(0x1) << 0)
> >
> >  /* GCR_CPC_BASE register fields */
> > -#define CM_GCR_CPC_BASE_CPCBASE_SHF            17
> > -#define CM_GCR_CPC_BASE_CPCBASE_MSK            (_ULCAST_(0x7fff) << 17)
> > +#define CM_GCR_CPC_BASE_CPCBASE_SHF            15
> > +#define CM_GCR_CPC_BASE_CPCBASE_MSK            (_ULCAST_(0x1ffff) << 1=
5)
> >  #define CM_GCR_CPC_BASE_CPCEN_SHF              0
> >  #define CM_GCR_CPC_BASE_CPCEN_MSK              (_ULCAST_(0x1) << 0)
> >
> > --
> > 2.6.3
> >
>=20
>=20
>=20
> --=20
> Martynov Nikolay.
> Email: mar.kolya@gmail.com
>=20

--GvDmwISikgK05D7L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcIDOAAoJEGwLaZPeOHZ6agEP/itFQbEpi5rJI+Vs4ubpqThO
+gnV2MSzSffhKpC8ibHiVcNxIVNhV4Wdryfuq1CigJ7tN/PuXQEbhder4KwKUwCN
RoL8kjTdnwr+SXvJcTmxJINpIoRrQO3A5Ab6YyAB0MTNPX6DNz44hYs7lfNPugvm
vlzEgeH3oPgaV3ClSJvboivW4FLSt+pobPNGBampoPrnSmy/QSgG+ucKsOgytYRs
3NEpiMHezg5tYspHaNY5K5rP2Nt+tTDeNf5K6kKDeLMcBsbqAySah661rVi67zvq
MNRl+lbEmCP7DwjpdnTDTWLAE7saW/pv/sD6bIS8vHUV1C5baNoMmdOLBbph6crF
YiA2TOhj+4CsAomzye9gkyOcsLbp6jikLLrueJbaDHaYjWNPlXMt8xZ4QWBq1MjQ
lZXSZlutnF8HyGAS7Ym2J3amvB984plx6rCZOtlW8pNEY1n3lSMm1HJtxEt3Apnr
e12RKzfV3dj+cHvq4eR4uFQiSlJBbOAR9dOtyhJ+0LzngDbi2Rpp9yZvCBZTQ1xp
9ZPC4XwoQYrnEPIfUxIuW5RrJK/aMvUdPxwqhTxA/agJqOjpCl7XTj2bhNIm9iki
dNLb/hPnFDY1MySx/mBGXC3HKcp0KAzLVsyioZ8j+hlbWhQGP4Pt1qiHpV1zCyUx
9qStlXYnMx9/DbTVKfGH
=BNwk
-----END PGP SIGNATURE-----

--GvDmwISikgK05D7L--
