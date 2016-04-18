Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 11:10:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56249 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006623AbcDRJKoucjbb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 11:10:44 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5E42A41F8E12;
        Mon, 18 Apr 2016 10:10:39 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 18 Apr 2016 10:10:39 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 18 Apr 2016 10:10:39 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 74EDC44582064;
        Mon, 18 Apr 2016 10:10:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 18 Apr 2016 10:10:39 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 18 Apr
 2016 10:10:38 +0100
Date:   Mon, 18 Apr 2016 10:10:38 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, "Adam
 Buchbinder" <adam.buchbinder@gmail.com>, David Daney
        <david.daney@cavium.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul
 Gortmaker <paul.gortmaker@windriver.com>, Aneesh Kumar K.V
        <aneesh.kumar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Markos Chandras
        <markos.chandras@imgtec.com>, Alex Smith <alex.smith@imgtec.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 05/12] MIPS: mm: Standardise on _PAGE_NO_READ, drop
 _PAGE_READ
Message-ID: <20160418091038.GL7859@jhogan-linux.le.imgtec.org>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <1460716620-13382-6-git-send-email-paul.burton@imgtec.com>
 <20160415212200.GG7859@jhogan-linux.le.imgtec.org>
 <20160418090303.GA3741@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qyHYMwAXsHLOQihY"
Content-Disposition: inline
In-Reply-To: <20160418090303.GA3741@NP-P-BURTON>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: ebfc6934
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53042
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

--qyHYMwAXsHLOQihY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 18, 2016 at 10:03:03AM +0100, Paul Burton wrote:
> On Fri, Apr 15, 2016 at 10:22:00PM +0100, James Hogan wrote:
> > > @@ -1615,9 +1611,8 @@ build_pte_present(u32 **p, struct uasm_reloc **=
r,
> > >  			cur =3D t;
> > >  		}
> > >  		uasm_i_andi(p, t, cur,
> > > -			(_PAGE_PRESENT | _PAGE_READ) >> _PAGE_PRESENT_SHIFT);
> > > -		uasm_i_xori(p, t, t,
> > > -			(_PAGE_PRESENT | _PAGE_READ) >> _PAGE_PRESENT_SHIFT);
> > > +			(_PAGE_PRESENT | _PAGE_NO_READ) >> _PAGE_PRESENT_SHIFT);
> > > +		uasm_i_xori(p, t, t, _PAGE_PRESENT >> _PAGE_PRESENT_SHIFT);
> >=20
> > This code makes the assumption that _PAGE_READ was always at a higher
> > bit number than _PAGE_PRESENT, however this isn't true for _PAGE_NO_READ
> > in the defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
> > case, where the no read bit will have been shifted off the end of the
> > register value.
>=20
> Hi James,
>=20
> Note that as of this patch the PHYS_ADDR_T_64BIT && CPU_MIPS32 case is
> still the XPA case, until patch 7.
>=20
> XPA support hardcodes for RIXI being present, which whilst technically
> doesn't seem valid it's already in mainline & seems like a requirement
> unlikely to be violated - R6 mandates RIXI, and it seems unlikely any
> new R5 + XPA cores would come along at this point. That being the case,
> XPA kernels where _PAGE_PRESENT_SHIFT > _PAGE_NO_READ_SHIFT would always
> take the cpu_has_rixi path & not hit the problem you describe, or else
> would already be hitting problems elsewhere due to the lack of RIXI.

Good point, and the 36-bit addressing code added back in the next patch
doesn't seem susceptible :-)

>=20
> I agree it would be good to make that clearer though, so will add a
> panic or something in another patch.

Thanks

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>=20
> > Other than that, I can't fault this patch.
>=20
> Thanks for the review :)
>=20
> Paul

--qyHYMwAXsHLOQihY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXFKSOAAoJEGwLaZPeOHZ6XssP/1XZD4zz4n4wxETKvZcXa4+q
3IT2qypW1SAzzOT3B/gdiA3y3YskM2z1njY6DOqdyeimIbNNGvyWhX1Eu1OReVC4
uSgNVyRUP9fHKce3r6JLfxGc3TYAYW7e8fPMUUUqNvUcG9V+FAhNmtJ9EeqFnPmy
ejyynQVuzXYeQTDpWqsZKZo9b2lRfKeBWgk49VGB8vqx684Dn5rGCA6fAaIfYxqw
ARGR9qEqIz9PsZbqdCMAtBP9tbPvmPSBb4OreYxPm5FW6q46JMXqGktNyFSSkssK
ggw4dGIdynd3fIoO3ihfNrNZgBmiXBOxM6onnPVSrdZKMf3o8KFuQRm2q1suK8cp
mCW+UOpBcaGuZRJTtrh7W1NZGbPP0RwzBBlUrG8ysu8fQ7UP6eldFhwVdkskHRCk
wszzdpnJRyh3RZMzl+WA6UiufJxt8dbAeU/CWzb1iO8VY7rlAYhKkNS/fGVuIpvM
itx0HoA6sH2z6ftLMZrzrN76e1whabS68z4LBn+ZmoWcV96mhpEXz2dU+l8eX60R
6La8xnzgbSwe3uBGL7jnh6fm6XI419BYbG8RMd7Sl3VwXmU4hX3P8mpXc/AX2EiK
ZCROAHjBZGQPCjek2pNLG6d04L8OEb6bcTu6Sdcx6EWn2fL/mdMs3qMUGXegkAAp
DcaxIy27CxBRgWZYprAB
=FxLK
-----END PGP SIGNATURE-----

--qyHYMwAXsHLOQihY--
