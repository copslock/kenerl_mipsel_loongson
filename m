Received:  by oss.sgi.com id <S42281AbQJJXj0>;
	Tue, 10 Oct 2000 16:39:26 -0700
Received: from air.lug-owl.de ([62.52.24.190]:17158 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S42273AbQJJXis>;
	Tue, 10 Oct 2000 16:38:48 -0700
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id C964086CA; Wed, 11 Oct 2000 01:38:05 +0200 (CEST)
Date:   Wed, 11 Oct 2000 01:38:04 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Problem w/ serial console after power-on
Message-ID: <20001011013803.A5873@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've got a DECStation 5000/120 and tried to start some hacking,
but no success: I can read everything the box outputs to its
serial lines, but anything I type into my minicom seems to end
up in /dev/null... The cable is okay, but what could be wrong
instead? Any hints?

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
KN02-BA V5.7e
3/misc/kbd
?STF (4: Ln#0 Kbd self test)

3/misc/mouse
?STF (4: Ln#1 Pntr self test)

?IO:  3/rz0/vmunix  (bb rd)
>>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjnjqFsACgkQHb1edYOZ4buI0ACfSYcBCeIcFlKvcD3TtFdcJJTp
bBIAni5U5GQ/o0JZk6utyLDFLXSW6i4v
=3DgI
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
