Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2016 20:05:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32377 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992181AbcJFSFcPw3fo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Oct 2016 20:05:32 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 68CCD41F8D64;
        Thu,  6 Oct 2016 19:05:23 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 06 Oct 2016 19:05:23 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 06 Oct 2016 19:05:23 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id D1A1791CE9A0F;
        Thu,  6 Oct 2016 19:05:22 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Oct 2016
 19:05:26 +0100
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Oct
 2016 19:05:26 +0100
Date:   Thu, 6 Oct 2016 19:05:25 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
Message-ID: <20161006180525.GG19354@jhogan-linux.le.imgtec.org>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
 <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com>
 <20160921130852.GA10899@linux-mips.org>
 <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com>
 <alpine.LFD.2.20.1610021038190.25303@eddie.linux-mips.org>
 <20161005155653.GG15578@jhogan-linux.le.imgtec.org>
 <alpine.LFD.2.20.1610061709400.1794@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sLx0z+5FKKtIVDwd"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1610061709400.1794@eddie.linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55357
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

--sLx0z+5FKKtIVDwd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 06, 2016 at 05:18:26PM +0100, Maciej W. Rozycki wrote:
> Hi James,
>=20
> > >  This does look wrong to me, as I noted above EBase is 64-bit with MI=
PS64=20
> > > processors as from architecture revision 3.50.  Also I don't think we=
 want=20
> >=20
> > MIPS64 PRA (I'm looking at r5 and r6) seems to allow for write-gate not
> > to be implemented, in which case the register is only 32-bits.
>=20
>  Indeed, but we need to be prepared to handle the width of 64 bits and=20
> `cpu_has_mips64r6' does not seem to me to be the right condition.

The relevance of r6 is the assurance that reading a 32-bit COP0 register
with dmfc0 is no longer UNDEFINED (like r5 and before), but reads the
top 32-bits as reserved, i.e. read zero (may need manual sign
extension) and writes ignored.

>=20
>  ISTR a while ago we had a rather lengthy discussion as to how to detect=
=20
> the presence of the upper 32 bits without triggering undefined behaviour=
=20
> implied by 64-bit CP0 accesses to 32-bit CP0 registers.  As I believe we=
=20
> set EBase ourselves I think we are able to make the necessary checks and=
=20
> have an accurate condition here, still remembering however that it may go=
=20
> back as far as MIPSr3.

We only set ebase under certain circumstances, otherwise leaving it as
already set.

Cheers
James

--sLx0z+5FKKtIVDwd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX9pJlAAoJEGwLaZPeOHZ66ysP/3R9r0QOuKQp9hPyw7ehOhxW
3P2ecZL3QEzXPgMS0hZZxAAiTsNkF5vmBozac4bWFBqYTcU1eclQiDjviJzFF47k
6T2B1dKp+De1/l1ToTi92ANRznOirxs+ghbxlq9VRy97orEUjeB/7igdrfGsBsNJ
8DC5bAR+Q/sGUK7mqMhIm308lASmDlIjsRQBoQOddFnkWBCxiIGw1dBedELahyHZ
tiDgViDKxy1QScM0gvVODAc5/0BCUqeXp61TiPLPckHmH3++wDYR38qbUa/8OxTj
e5s8PWJiZOoFC1sISD37yIEXMIWkCMf9KgcWn3RW/i+uGC78HPkcoVwVUSO5p5Lc
tVudRZNlD4V5haRcJe+0XZ4u1p5kmNd+HegxeC7GnQ7Z4gwSlLqFJqrGkpI4rIrO
56HBRQR7gd4R5FF9eRpLaSbTD78ntVj8wzKEXCJXl0EbiQqBl7yFhuDUpEY8m+lI
m3QreWdRpJJjbQiPQQ+a/6TunbTaob0k9dPOltSem7KIyEEcgYMzmH8qhVLtvxrP
myJDweWPKBy7kLcrDNvtysETkRIQI4BamXhjMPO3ONQhPoGvLHkMuvoECctDLh8G
eEAsMpJ/9DA9xJv++YUEoHycKqG3KLaUZIhncY+aetjhN5UbGG4qBEQVYYqw/xGJ
yQIoAxM4j+vOetKylLMz
=Drkk
-----END PGP SIGNATURE-----

--sLx0z+5FKKtIVDwd--
