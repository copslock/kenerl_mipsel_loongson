Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2004 14:08:26 +0000 (GMT)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:58842 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225248AbUBLOIW>; Thu, 12 Feb 2004 14:08:22 +0000
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 90D384B520; Thu, 12 Feb 2004 15:08:21 +0100 (CET)
Date: Thu, 12 Feb 2004 15:08:21 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: questions about making a script file for YAMON command
Message-ID: <20040212140821.GT2725@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <8EAC52A94CD8D411A01000805FBB377606563AE8@gbrwgcms02.wgc.gbr.xerox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rPH0Y77Oimr1cvNq"
Content-Disposition: inline
In-Reply-To: <8EAC52A94CD8D411A01000805FBB377606563AE8@gbrwgcms02.wgc.gbr.xerox.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--rPH0Y77Oimr1cvNq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-02-12 13:45:25 -0000, Ren, Manling <Manling.Ren@gbr.xerox.com>
wrote in message <8EAC52A94CD8D411A01000805FBB377606563AE8@gbrwgcms02.wgc.g=
br.xerox.com>:
> Dear the technical support team,

No technical support team here, just a number of hackers...

> I am running YAMON on pb1100 board in Linux.  At the YAMON prompt, I need=
 to
> change some registers by using the command "edit -32 0x########"  several
> times.  I wonder if I can put all these "edit" commands into a script file

Personally, I don't know yamon since nobody offered a board using it to
me, but if it uses serial console, just prepare a text file containing
all the lines you need to type. Then, cut'n'paste the commands to
minicom or whatever you use...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--rPH0Y77Oimr1cvNq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAK4jVHb1edYOZ4bsRAiI1AJ9trM24mZhWymnAxa2BgmQ5KOAJPgCeN7SN
QXjCJjbKH4PMC33EGYX1cU8=
=hYUs
-----END PGP SIGNATURE-----

--rPH0Y77Oimr1cvNq--
