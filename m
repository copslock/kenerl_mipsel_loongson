Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27M6He19529
	for linux-mips-outgoing; Thu, 7 Mar 2002 14:06:17 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27M6B919523
	for <linux-mips@oss.sgi.com>; Thu, 7 Mar 2002 14:06:11 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id AB7A89F6C; Thu,  7 Mar 2002 22:06:09 +0100 (CET)
Date: Thu, 7 Mar 2002 22:06:09 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: Warning: persistent break condition on serial port 0.
Message-ID: <20020307210609.GG25044@lug-owl.de>
Mail-Followup-To: Linux MIPS <linux-mips@oss.sgi.com>
References: <20020307195948.GE25044@lug-owl.de> <20020307204020.GF25044@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline
In-Reply-To: <20020307204020.GF25044@lug-owl.de>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-03-07 21:40:20 +0100, Jan-Benedict Glaw <jbglaw@lug-owl.de>
wrote in message <20020307204020.GF25044@lug-owl.de>:
> On Thu, 2002-03-07 20:59:48 +0100, Jan-Benedict Glaw <jbglaw@lug-owl.de>
> wrote in message <20020307195948.GE25044@lug-owl.de>:
> >                          Running power-on diagnostics...
> > Warning: persistent break condition on serial port 0.
> > Warning: persistent break condition on serial port 0.
> >                            Starting up the system...
> >                To perform system maintenance instead, press <Esc>
>=20
> I've now modified the cable: it's only signal ground and the receiving
> wire, so I really can only receive the Indy's messages. I cannot
> send anything anymore, but I still get those messages. I think this
> means that the box is now a paperweight: no way to access it, because
> I cannot even set console to ttyS1...

Things are getting better: I am root on that machine through a telnet
login (Irix 6.2 is running). Is there a way to set the console
device to ttyd1? Maybe that could work...

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyH1kAACgkQHb1edYOZ4bt0yACeILFRTEZiwizs5kc+BsEHZWEq
M6oAn2hIC8TurD0m07vDbE9vmoXitpRp
=9L5Q
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
