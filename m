Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2GMCQE13753
	for linux-mips-outgoing; Sat, 16 Mar 2002 14:12:26 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2GMCK913750
	for <linux-mips@oss.sgi.com>; Sat, 16 Mar 2002 14:12:20 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 0125D9EDF; Sat, 16 Mar 2002 23:13:46 +0100 (CET)
Date: Sat, 16 Mar 2002 23:13:46 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: DECStation kernel boot failure
Message-ID: <20020316221346.GE25044@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020315195946.GA3020@excalibur.cologne.de> <Pine.LNX.4.32.0203161129110.28645-100000@skynet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sxUMTo9WXJrtNoGr"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.32.0203161129110.28645-100000@skynet>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--sxUMTo9WXJrtNoGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-03-16 11:31:18 +0000, Dave Airlie <airlied@csn.ul.ie>
wrote in message <Pine.LNX.4.32.0203161129110.28645-100000@skynet>:

> > That was the LANCE driver for the 5000/200, which is different from
>=20
> Does the copy on my website still work ?
>=20
> http://www.skynet.ie/~airlied/mips/declance_2_3_48.c
>=20
> It was never merged as to do it properly required a re-write of the
> driver, which I never got around to, and I only had a DS5000/200, I still
> have one, but no build system at the moment ...

When I looked at that driver, the diff was quite small and only
included changes to in-driver code parts. So I _think_ it could
even run these days. I started to work on it some year ago, but
my changes are lost now - my laptop was stolen this week.

However, I think it could run. I can try to compile a kernel with
this driver, there's a running toolchain here:-)

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--sxUMTo9WXJrtNoGr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyTw5kACgkQHb1edYOZ4bubvACfdg0OiCPd3z2XvgimQLLGAkyp
fxAAn0DCAIrUvHemiwM9WS2FkRmv2ZLx
=SgTO
-----END PGP SIGNATURE-----

--sxUMTo9WXJrtNoGr--
