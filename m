Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2004 00:47:53 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:29221
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224929AbUJBXrt>; Sun, 3 Oct 2004 00:47:49 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CDtbP-0001R4-00; Sun, 03 Oct 2004 01:47:47 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CDtbP-0006wA-00; Sun, 03 Oct 2004 01:47:47 +0200
Date: Sun, 3 Oct 2004 01:47:47 +0200
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20041002234747.GP21351@rembrandt.csv.ica.uni-stuttgart.de>
References: <4152D58B.608@longlandclan.hopto.org> <20040923154855.GA2550@paradigm.rfc822.org> <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de> <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thiemo Seufer wrote:
[snip]
> One more nop is enough to make it work. This should probably go in
> a hazard definition.

Same for 64bit kernels.


Thiemo


Index: arch/mips/mm/tlbex64-r4k.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/arch/mips/mm/tlbex64-r4k.S,v
retrieving revision 1.6
diff -u -p -r1.6 tlbex64-r4k.S
--- arch/mips/mm/tlbex64-r4k.S	15 Aug 2004 09:40:01 -0000	1.6
+++ arch/mips/mm/tlbex64-r4k.S	2 Oct 2004 23:45:14 -0000
@@ -116,6 +118,7 @@ LEAF(handle_vec1_r4k)
 	PTE_RELOAD k0 k1
 	mtc0_tlbw_hazard
 	tlbwr
+	nop
 	tlbw_eret_hazard
 	eret
=20
@@ -128,7 +131,8 @@ LEAF(handle_vec1_r4k)
 	ld	k1, 8(k1)			# get odd pte
 	PTE_RELOAD k0 k1
 	mtc0_tlbw_hazard
-	 tlbwr
+	tlbwr
+	nop
 	tlbw_eret_hazard
 	eret
 END(handle_vec1_r4k)

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAkFfPiEACgkQXNuq0tFCNaABwwCeMgHbhKsD29h5GjjnLJXUCyKc
vvsAn1bWP1XoKDL38ZdXzj5uwBRteKFK
=8h8K
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
