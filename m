Received:  by oss.sgi.com id <S553722AbQJRMjy>;
	Wed, 18 Oct 2000 05:39:54 -0700
Received: from air.lug-owl.de ([62.52.24.190]:45063 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553706AbQJRMjg>;
	Wed, 18 Oct 2000 05:39:36 -0700
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 6C5A485D5; Wed, 18 Oct 2000 14:39:34 +0200 (CEST)
Date:   Wed, 18 Oct 2000 14:39:34 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Re: CrossGcc Kernel fail.
Message-ID: <20001018143933.A32077@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
References: <39ED962F.3230FDEE@isratech.ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39ED962F.3230FDEE@isratech.ro>; from octavp@isratech.ro on Wed, Oct 18, 2000 at 03:23:11PM +0300
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2000 at 03:23:11PM +0300, Nicu Popovici wrote:
> Hello once again,
>=20
> cc1: warnings being treated as errors.

Linus once made errors of all warnings, but that's ages ago... What
kernel do you try to compile? Anything else than current CVS tree?

> Another question : in all the docs that I found says apply patch
> binutils-<version>-mips.patch, gcc-<version>-mips.patch and the same for
> glibc. I did a search for binutils-2.8.1-mips.patch and I did not find
> anything. Can anyone tell me where to find those patches ?

What's wrong with ftp://oss.sgi.com/pub/linux/mips/crossdev/srpms/* ?

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjntmgUACgkQHb1edYOZ4bumLgCePiSme081jB5l1onF0LLw9qiT
35wAn0FAUwgTajo3gIOXkqSOyAfYK5bg
=srx2
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
