Received:  by oss.sgi.com id <S553694AbQJTNSw>;
	Fri, 20 Oct 2000 06:18:52 -0700
Received: from air.lug-owl.de ([62.52.24.190]:25104 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553682AbQJTNSe>;
	Fri, 20 Oct 2000 06:18:34 -0700
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 060967E92; Fri, 20 Oct 2000 15:18:30 +0200 (CEST)
Date:   Fri, 20 Oct 2000 15:18:30 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Cc:     Nicu Popovici <octavp@isratech.ro>
Subject: Re: [Fwd: CrossGcc steps!]
Message-ID: <20001020151830.E23056@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com,
	Nicu Popovici <octavp@isratech.ro>
References: <39F040D4.4BFB2E26@isratech.ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39F040D4.4BFB2E26@isratech.ro>; from octavp@isratech.ro on Fri, Oct 20, 2000 at 03:55:48PM +0300
X-Operating-System: Linux air 2.4.0-test8-pre1
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2000 at 03:55:48PM +0300, Nicu Popovici wrote:
> > Yupp. Your .config is wrong. What kind of machine do you exactly ghave?
>=20
> I have a Intel pentium III at 500 Mhz which is running RedHat 6.2.

No, I thought of your mips machine...

[ ] I've not got any MIPS based machine
[ ] I've got a MIPS based machine. It is called

	______________________________________

[ ] I've build a cross compiler with --target=3Dmips-linux
[ ] I've build a cross compiler with --target=3Dmipsel-linux

> > You need to have an *exactly* fitting config. You're responsible
> > to make it by config/oldconfig/menuconfig/xconfig, as what you prefer.
>=20
> Can you help me with the options ?

Therefor I'd need to know what machine you are compiling for...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjnwRiUACgkQHb1edYOZ4bvDyACffAqeRe8HmKty+4lEMrz7xW1F
aeAAn0GSgpJ25S0ZK1zDuW3N1AJIk4Tr
=VgVx
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
