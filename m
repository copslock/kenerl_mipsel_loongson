Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27Kxv016994
	for linux-mips-outgoing; Thu, 7 Mar 2002 12:59:57 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27Kxo916989
	for <linux-mips@oss.sgi.com>; Thu, 7 Mar 2002 12:59:51 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id A6318A0F1; Thu,  7 Mar 2002 20:59:48 +0100 (CET)
Date: Thu, 7 Mar 2002 20:59:48 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux MIPS <linux-mips@oss.sgi.com>
Subject: Warning: persistent break condition on serial port 0.
Message-ID: <20020307195948.GE25044@lug-owl.de>
Mail-Followup-To: Linux MIPS <linux-mips@oss.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've got an Indy R4k6 some time ago (I managed to run Linux on it using
nfsroot) and now I attempted to really install it. However, I've now
got some problem with the serial port: I can read the boot-up messages,
but I cannot intercept the bootstrap (as I could do it some weeks
ago):

                         Running power-on diagnostics...

Warning: persistent break condition on serial port 0.
Warning: persistent break condition on serial port 0.


                           Starting up the system...

               To perform system maintenance instead, press <Esc>

So I get warnings about a "persistent break condition", but that's
not caused by the cable I use (I've used it weeks ago and it worked).

Did I manage to kill the serial port? Any other hint on this?

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyHxrMACgkQHb1edYOZ4bsVqACghPUT08Y0kIQsWm/ABdxjfTXk
wFoAn1AGepIBBR35U1y4cwLrteMaX/zA
=pp2f
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
