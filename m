Received:  by oss.sgi.com id <S553755AbQJQPfo>;
	Tue, 17 Oct 2000 08:35:44 -0700
Received: from air.lug-owl.de ([62.52.24.190]:31246 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553687AbQJQPf2>;
	Tue, 17 Oct 2000 08:35:28 -0700
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 3479A85CD; Tue, 17 Oct 2000 17:35:26 +0200 (CEST)
Date:   Tue, 17 Oct 2000 17:35:25 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Re: base.tgz
Message-ID: <20001017173525.C22796@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20001016043346.A6656@lug-owl.de> <20001017041449.A17546@lug-owl.de> <20001017162724.H4890@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001017162724.H4890@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Oct 17, 2000 at 04:27:24PM +0200
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2000 at 04:27:24PM +0200, Florian Lohoff wrote:
> On Tue, Oct 17, 2000 at 04:14:50AM +0200, Jan-Benedict Glaw wrote:

[Some less interesting packages]

> We should include them without syslinux, lilo, mbr which
> are i386 specific. All others might need some special
> hacking ...

Will see what I can do;) First of all, I'll combine all the .deb's
I've currently fetched up. Btw, Geert asked for pciutils. Are there
MIPSel machines with PCI bus(ses)?

>   from util-linux
>=20
> The util-linux stuff is tricky - I have made a debian-mips package
> from it using wesolows patches - The packages are at
> ftp://ftp.rfc822.org/pub/local/debian-mips/temp-packages
> One could easily build these for mipsel ...

Thanks. I'll try to compile it for mipsel as soon as I've got a=20
working toolchain. Currently, I'm only able to x-compile kernels
on a ia32 machine...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjnscb0ACgkQHb1edYOZ4btKLwCgherIams16hddbLE7NxNmDbnB
4NAAoIm9uybQTWaS6f4f1hqYZY88JQUI
=qLSy
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
