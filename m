Received:  by oss.sgi.com id <S553891AbQKKOrq>;
	Sat, 11 Nov 2000 06:47:46 -0800
Received: from air.lug-owl.de ([62.52.24.190]:271 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553886AbQKKOra>;
	Sat, 11 Nov 2000 06:47:30 -0800
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 02E91826A; Sat, 11 Nov 2000 15:47:22 +0100 (CET)
Date:   Sat, 11 Nov 2000 15:47:22 +0100
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Boot Problem on DS 5000/240
Message-ID: <20001111154721.B9307@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've got some problem booting another DECStation I've got:

=3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D=
 =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D
KN03-AA V5.1b
3/misc/kbd
?STF (4: Ln#0 Kbd self test)

3/misc/mouse
?STF (4: Ln#1 Pntr self test)

>>cnfg
 3: KN03-AA  DEC      V5.1b    TCF0  ( 32 MB)
                                     (enet: 08-00-2b-2f-07-27)
                                     (SCSI =3D 7)

>>boot 3/tftp

???
? PC:  0x80021fe4<vtr=3DNRML>
? CR:  0x30000010<CE=3D3,EXC=3DAdEL>
? SR:  0x30080000<CU1,CU0,CM,IPL=3D8>
? VA:  0xa000ef3a
>>
=3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D=
 =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D

The box doesn't actually send anything down te wire...

Can anybody help me with the dump above?

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjoNW/kACgkQHb1edYOZ4buenQCfRZanTAUspRzDJXnzIWdDg9+n
qQ8An02UfqqcPvHb/frCFaAgX0vEm1+X
=4XjQ
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
