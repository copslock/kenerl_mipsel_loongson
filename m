Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f972Zw704525
	for linux-mips-outgoing; Sat, 6 Oct 2001 19:35:58 -0700
Received: from straylight.cyberhqz.com (root@h24-76-98-250.vc.shawcable.net [24.76.98.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f972ZqD04520
	for <linux-mips@oss.sgi.com>; Sat, 6 Oct 2001 19:35:52 -0700
Received: (from rmurray@localhost)
	by straylight.cyberhqz.com (8.9.3/8.9.3/Debian 8.9.3-21) id TAA18389
	for linux-mips@oss.sgi.com; Sat, 6 Oct 2001 19:35:51 -0700
From: Ryan Murray <rmurray@cyberhqz.com>
Date: Sat, 6 Oct 2001 19:35:51 -0700
To: linux-mips@oss.sgi.com
Subject: bug in binutils 2.11.90.0.31 strip ?
Message-ID: <20011006193551.A17821@cyberhqz.com>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm running into a problem while building gcc 3.0 from 010922.

The built libobjc.so.1.0.0 is fine until stripped:

before strip:

libobjc.so.1.0.0:     file format elf32-tradlittlemips

Program Header:
0x70000000 off    0x000000b4 vaddr 0x000000b4 paddr 0x000000b4 align 2**2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**12
         filesz 0x0001a440 memsz 0x0001a440 flags r-x
    LOAD off    0x0001a440 vaddr 0x0005a440 paddr 0x0005a440 align 2**12
         filesz 0x00000b30 memsz 0x00000b90 flags rw-
 DYNAMIC off    0x000000cc vaddr 0x000000cc paddr 0x000000cc align 2**2
         filesz 0x00003621 memsz 0x00003621 flags rwx

after strip:

libobjc.so.1.0.0:     file format elf32-tradlittlemips

Program Header:
0x70000000 off    0x000000b4 vaddr 0x000000b4 paddr 0x000000b4 align 2**2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**4
         filesz 0x0001a440 memsz 0x0001a440 flags r-x
    LOAD off    0x0001a440 vaddr 0x0005a440 paddr 0x0005a440 align 2**4
         filesz 0x00000b30 memsz 0x00000b90 flags rw-
 DYNAMIC off    0x000000cc vaddr 0x000000cc paddr 0x000000cc align 2**2
         filesz 0x00003621 memsz 0x00003621 flags rwx

The change in alignment in the newly-stripped library makes it unusable.

This happens on both big endian and little endian targets.

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7v7+GN2Dbz/1mRasRArVgAKDvkVf3VEp50QenmPYeIRWijK38jgCePoUK
lkRJqrswQEp/PhiqFgrnzV4=
=ikjl
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
