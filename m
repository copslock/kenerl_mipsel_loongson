Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Oct 2004 21:40:20 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:24100
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224929AbUJBUkP>; Sat, 2 Oct 2004 21:40:15 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CDqfu-0000Ao-00; Sat, 02 Oct 2004 22:40:14 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CDqfu-0006Pd-00; Sat, 02 Oct 2004 22:40:14 +0200
Date: Sat, 2 Oct 2004 22:40:14 +0200
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de>
References: <4152D58B.608@longlandclan.hopto.org> <20040923154855.GA2550@paradigm.rfc822.org> <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thiemo Seufer wrote:
[snip]
> > With this fix the machines goes userspace (reverse engineered by sound
> > of hard disk) but seems to die somewhere. Probably the same bug as seen
> > on other archs - die on first fork.
>=20
> The last problem happens only on r4000 and r4400, and occasionally
> also shows up as "illegal instruction" or "unaligned access". It
> turned out to be a broken TLB handler. I temporarily switched (for
> 32bit kernels) from except_vec0_r4000 to except_vec0_r45k_bvahwbug.
> This may cause an avoidable performance loss, but at least it allows
> my R4400SC-200 (V6.0) Indy to run current 2.6 CVS.

One more nop is enough to make it work. This should probably go in
a hazard definition.


Thiemo


Index: arch/mips/mm/tlbex32-r4k.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/arch/mips/mm/tlbex32-r4k.S,v
retrieving revision 1.1
diff -u -p -r1.1 tlbex32-r4k.S
--- arch/mips/mm/tlbex32-r4k.S  20 Jun 2004 23:52:17 -0000      1.1
+++ arch/mips/mm/tlbex32-r4k.S  2 Oct 2004 20:36:29 -0000
@@ -179,6 +179,7 @@
        P_MTC0  k1, CP0_ENTRYLO1                # load it
        mtc0_tlbw_hazard
        tlbwr                                   # write random tlb entry
+       nop
        tlbw_eret_hazard
        eret                                    # return from trap
        END(except_vec0_r4000)

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAkFfEi0ACgkQXNuq0tFCNaCPuQCeKukulTGwt+rNDbbdsR4bvEWe
XGcAniveFm83GSbzYns3yYtRX01B9sCZ
=4erS
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
