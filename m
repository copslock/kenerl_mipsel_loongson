Received:  by oss.sgi.com id <S553770AbQJPCdy>;
	Sun, 15 Oct 2000 19:33:54 -0700
Received: from air.lug-owl.de ([62.52.24.190]:50703 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553765AbQJPCdu>;
	Sun, 15 Oct 2000 19:33:50 -0700
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id B7A89803F; Mon, 16 Oct 2000 04:33:47 +0200 (CEST)
Date:   Mon, 16 Oct 2000 04:33:47 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: base.tgz
Message-ID: <20001016043346.A6656@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Flo gave me a DECStation some days (2 weeks or so?) ago. I now
finally got it running so far. My compiler is quite a bit old
(gcc version egcs-2.90.29 980515 (egcs-1.0.3 release), from SRPMS),
but it con compile actual CVS.

For first tests I used a kernel Flo compiled (R3k-240-test8-pre1
from ftp.rfc822.org:/pub/local/...), but with that one there was
no great chance to even copy some files. Actual CVS is quite
more stable (well, it doesn't survive a nmap scan, but I con
copy tenth of megabytes without any favourite segfaults/bus errors/
core dumps/ ...)

My next goal is to cleanly build something like base.tgz. Maybe
we can get a smooth debian installation in some days;)

So, and now I'll go to bed...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjnqaQoACgkQHb1edYOZ4bsriwCeJo6T4wXBr2vanYQpheb35w+Z
xLIAnR584HxfXHgYAb2L8h6caIuwpIw/
=vWU6
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
