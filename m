Received:  by oss.sgi.com id <S42264AbQFRLWy>;
	Sun, 18 Jun 2000 04:22:54 -0700
Received: from belgarath.esg-guetersloh.mediapoint.de ([193.189.251.50]:17722
        "HELO belgarath.esg-guetersloh.mediapoint.de") by oss.sgi.com
	with SMTP id <S42353AbQFREQQ>; Sat, 17 Jun 2000 21:16:16 -0700
Received: by belgarath.esg-guetersloh.mediapoint.de (Postfix, from userid 1000)
	id D2ED851314; Sat, 17 Jun 2000 23:21:02 +0200 (CEST)
Date:   Sat, 17 Jun 2000 23:21:02 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     Chris Ruvolo <csr6702@osfmail.isc.rit.edu>
Cc:     linux-mips@oss.sgi.com, florian@void.s.bawue.de
Subject: Re: TFTP Problem Resolved!
Message-ID: <20000617232102.A1543@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: Chris Ruvolo <csr6702@osfmail.isc.rit.edu>,
	linux-mips@oss.sgi.com, florian@void.s.bawue.de
References: <Pine.LNX.4.21.0006162228001.504-100000@hork>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0006162228001.504-100000@hork>; from csr6702@osfmail.isc.rit.edu on Fri, Jun 16, 2000 at 11:30:24PM -0400
X-Operating-System: Linux belgarath.esg-guetersloh.mediapoint.de 2.0.35 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2000 at 11:30:24PM -0400, Chris Ruvolo wrote:
>=20
> To correct for this, either boot your tftp server with a 2.2.x kernel, or
> "echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc" before you boot the remote
> machine.

Thank you *very* much! I'd love to proceed, but unfotunately my
developement machine (laptop) stopped working;(

> This (mis)behavior has been observed on my Indy and another machine
> (Siemens?) that belongs to flawed on #mipslinux.

SNI RW320, which is (seems to be...) equivalent to SGI Indigo.

> PS: Yea!  My Indy works!  I've been so frustrated, I've been considering
> just getting rid of it and selling it on Ebay. :)  Now I'm glad I didn't.

Don't know if my machine would work. Is CVS at oss.sgi.com down? As
well as FTP? I'd love to re-start developement, but without sources...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEAREBAAYFAjlL674ACgkQHb1edYOZ4bsg9gCfbydO6nVz4NZd+kcOa5igds4E
40IAniY0YYmHMEViQDhqCLQjQP1/sCNI
=+POm
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
