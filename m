Received:  by oss.sgi.com id <S553936AbQKLT5E>;
	Sun, 12 Nov 2000 11:57:04 -0800
Received: from air.lug-owl.de ([62.52.24.190]:11281 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553900AbQKLT4t>;
	Sun, 12 Nov 2000 11:56:49 -0800
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id AE96D826A; Sun, 12 Nov 2000 20:56:46 +0100 (CET)
Date:   Sun, 12 Nov 2000 20:56:46 +0100
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Re: Boot Problem on DS 5000/240
Message-ID: <20001112205645.B26606@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20001111154721.B9307@lug-owl.de> <20001112175843.A1201@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001112175843.A1201@excalibur.cologne.de>; from karsten@excalibur.cologne.de on Sun, Nov 12, 2000 at 05:58:43PM +0100
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2000 at 05:58:43PM +0100, Karsten Merker wrote:
> On Sat, Nov 11, 2000 at 03:47:22PM +0100, Jan-Benedict Glaw wrote:
>=20
> > I've got some problem booting another DECStation I've got:
> >=20
> > =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D=
 =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D
> > KN03-AA V5.1b
>           ^^^^^
> This firmware release has no working tftp support. Boot via MOP,

Nov 12 19:38:12 bootserver mop_srvr[21803]: Client 08:00:2b:2f:69:0a: has u=
nknown device type 0x76

Has anybody get correct values for mop_srvr.c?
struct  client_data clnt_data[]=3D{
                { "PMAX"        , 0x43, 0x80700000, 1024 },
                { "MVAX_II"     , 0x05, 0x00000000, 1004 },
                { ""            , 0x00, 0x00000000, 0 } };
                                  ^^^^

???

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjoO9f0ACgkQHb1edYOZ4bs0JwCfXPXpVNPHVEuu1tXXvKh1R+Of
lx8AoInRLlY/0rM16xXMrkvdyLT//lqU
=wbv6
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
