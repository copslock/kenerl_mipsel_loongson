Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2004 21:25:40 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:63147 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225747AbUDNUZh>; Wed, 14 Apr 2004 21:25:37 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id D924F4B60F; Wed, 14 Apr 2004 22:25:34 +0200 (CEST)
Date: Wed, 14 Apr 2004 22:25:34 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: questions about keyboard
Message-ID: <20040414202534.GS630@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <F71A246055866844B66AFEB10654E7860F1B0B@riv-exchb6.echostar.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JMCz+drDJ1SjddZX"
Content-Disposition: inline
In-Reply-To: <F71A246055866844B66AFEB10654E7860F1B0B@riv-exchb6.echostar.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--JMCz+drDJ1SjddZX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-14 14:18:18 -0600, Xu, Jiang <Jiang.Xu@echostar.com>
wrote in message <F71A246055866844B66AFEB10654E7860F1B0B@riv-exchb6.echosta=
r.com>:
> However, what I don't get is how can I get the key event from the kernel?=
  I
> tried to listen to all the ttyN, but none of them connect to the keyboard=
=2E =20
> I wonder how I can write a user space application that can get the key
> event?  Could somebody help me out?  Because it is an embedded device, th=
ere
> is no X.

Well, one of /dev/tty, /dev/tty0 or /dev/console should work. If you'd
likt to use the new'n'fancy style, use /dev/input/eventX .

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--JMCz+drDJ1SjddZX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfZ4+Hb1edYOZ4bsRAtgSAJ9dXSGVPTKKo3wTPHEGDAXw97j6qwCfQetG
XkGcwwZk7KvbiM+bl6RYJT4=
=kdun
-----END PGP SIGNATURE-----

--JMCz+drDJ1SjddZX--
