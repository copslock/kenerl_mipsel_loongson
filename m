Received:  by oss.sgi.com id <S553660AbQJSKOx>;
	Thu, 19 Oct 2000 03:14:53 -0700
Received: from air.lug-owl.de ([62.52.24.190]:32260 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553651AbQJSKOf>;
	Thu, 19 Oct 2000 03:14:35 -0700
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id D359F85E6; Thu, 19 Oct 2000 12:14:32 +0200 (CEST)
Date:   Thu, 19 Oct 2000 12:14:32 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Swap on DECStation
Message-ID: <20001019121432.E9832@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Making my first steps on DECStations, I see the follwoing behavior:

- Running juite a number of processes like
        void main(void){for(;;);}
 is no real problem. They don't want any memory;)

- *But* only running two processes which malloc() a large memory
  region (read: 10MB each on my 5000/120 w/ 8MB RAM *but* enough
  swap to provide that virtual memory) will lock up the box quite
  predictably...

Is there any advice you can give me on how to start debugging the
process of swapping in/out pages? I really don't know enough about
Linux' VM system and it's arch-dependand backend on MIPSel.

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjnuyYcACgkQHb1edYOZ4bt2dACdFzp3v+RUlIYa+0FqRLRTgnkC
0gIAn0AyiX+NnTDCrZMffns/EMr+IRjx
=+DOZ
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
