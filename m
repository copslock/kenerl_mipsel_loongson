Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2003 09:26:00 +0000 (GMT)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:14819 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225541AbTKTJZs>; Thu, 20 Nov 2003 09:25:48 +0000
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 44BA04B46C; Thu, 20 Nov 2003 10:25:44 +0100 (CET)
Date: Thu, 20 Nov 2003 10:25:43 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: How reliable is GCC-3.3.1 wrt building mipsel-linux kernel?
Message-ID: <20031120092543.GH1037@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <3FBACA0F.7070207@avtrex.com> <20031119233023.GA30962@linux-mips.org> <3FBC0AF7.90600@avtrex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cjXvCArabh/jFWdZ"
Content-Disposition: inline
In-Reply-To: <3FBC0AF7.90600@avtrex.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--cjXvCArabh/jFWdZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-11-19 16:29:43 -0800, David Daney <ddaney@avtrex.com>
wrote in message <3FBC0AF7.90600@avtrex.com>:
> Ralf Baechle wrote:
> >On Tue, Nov 18, 2003 at 05:40:31PM -0800, David Daney wrote:

> Which options have other people used with gcc 3.3.1 with good results?

It's a question of what you call "good results". If there are bugs in
the kernel sources which only show up with a really aggressive HEAD
compiler, then IMHO it's a good result to see the compiled kernel crash,
just because there actually *is* a bug.

Companies however tend to accept a slower/more bloated/whatever software
(produced by an older compiler) in order not to start hunting down the
remaining (and possibly hard to find) bugs...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--cjXvCArabh/jFWdZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/vIiXHb1edYOZ4bsRAhWFAJoDReLOswoENweswqijTl7qASjt6wCgkfXA
+4Yo1RZ7uQISG/L/vxPGQA0=
=wwMt
-----END PGP SIGNATURE-----

--cjXvCArabh/jFWdZ--
