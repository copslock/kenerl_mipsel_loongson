Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5UHhdnC022186
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 30 Jun 2002 10:43:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5UHhdi3022185
	for linux-mips-outgoing; Sun, 30 Jun 2002 10:43:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5UHhVnC022176
	for <linux-mips@oss.sgi.com>; Sun, 30 Jun 2002 10:43:32 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 801AD12FF6; Sun, 30 Jun 2002 19:47:17 +0200 (CEST)
Date: Sun, 30 Jun 2002 19:47:17 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1
Message-ID: <20020630174717.GI17216@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020629220513.GC17216@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dQAkT9kf8uI42z2+"
Content-Disposition: inline
In-Reply-To: <20020629220513.GC17216@lug-owl.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--dQAkT9kf8uI42z2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-06-30 00:05:13 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de>
wrote in message <20020629220513.GC17216@lug-owl.de>:
[...]
>   10:   bc600060  0xbc600060
> Code;  88016ce0 <r4k_flush_cache_range_d32i32+e4/16c>
>   14:   bc600080  0xbc600080

Well, I've bulid the same kernel with CONFIG_MIPS_UNCACHED and the box
is running^Wsnailing fine with it. I'm experiencing a little peformance
drop (100 BogoMips -> 2.79 BogoMips), but it comes up in finite time:-)

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--dQAkT9kf8uI42z2+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9H0QkHb1edYOZ4bsRArtaAJ0aYhyLh9Ydac4MtcwH+2+HPFRmrACfXxeP
7TNRBdIy6y/Oo4OnqK+F8Y8=
=+fGF
-----END PGP SIGNATURE-----

--dQAkT9kf8uI42z2+--
