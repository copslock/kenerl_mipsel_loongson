Received:  by oss.sgi.com id <S553804AbQLXLku>;
	Sun, 24 Dec 2000 03:40:50 -0800
Received: from air.lug-owl.de ([62.52.24.190]:18451 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553794AbQLXLks>;
	Sun, 24 Dec 2000 03:40:48 -0800
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 7FA458041; Sun, 24 Dec 2000 12:40:41 +0100 (CET)
Date:   Sun, 24 Dec 2000 12:40:41 +0100
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Re: External SCSI connector on DECstations
Message-ID: <20001224124040.C25473@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20001224122539.B25473@lug-owl.de> <Pine.GSO.4.10.10012241231280.21709-100000@rose.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10012241231280.21709-100000@rose.sonytel.be>; from Geert.Uytterhoeven@sonycom.com on Sun, Dec 24, 2000 at 12:32:43PM +0100
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2000 at 12:32:43PM +0100, Geert Uytterhoeven wrote:
> On Sun, 24 Dec 2000, Jan-Benedict Glaw wrote:
> > I've got some trouble attaching devices to DECstation's external
> > SCSI connector. Is there any additional jumper (or sth like
> > that) on the mobo I need to remove in order to not automatically
> > terminate the bus (inside the DS) before the connector?
> >=20
> > ...or do I do something completely wrong?
>=20
> Is this an high-density 68-pin connector, like used for UW-SCSI?
> If yes, be careful! Many DECstations use these connectors, but are in fact
> narrow SCSI! So you need the correct (DEC) cable.

No, it's normal 50pin high density... I've tried with and w/o
external termination afterthat hdd, but no success... However,
I'll really need that connector because I need to disk-boot
two machines as they don't do bootp/tftp (but mop, and the
two tested mop servers can't handle these machines;( and
constantly plugging/unplugging hdds with those internal
flat ribbon cables isn't fun at all...

MfG, JBG


--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpF4LgACgkQHb1edYOZ4bs8tQCfUDUpqxcDoBnNlQA0mx/h0IJK
OzMAn19yHbJrMxpcs5vBVWA4OJhVOeP4
=a3cI
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
