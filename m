Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2004 07:19:53 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:60807 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225273AbUF2GTs>; Tue, 29 Jun 2004 07:19:48 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id A88A34B802; Tue, 29 Jun 2004 08:19:46 +0200 (CEST)
Date: Tue, 29 Jun 2004 08:19:46 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips <linux-mips@linux-mips.org>
Subject: Re: Onetouch Touchscreen RS232 driver in Hardhat Linux ?
Message-ID: <20040629061946.GI20632@lug-owl.de>
Mail-Followup-To: linux-mips <linux-mips@linux-mips.org>
References: <20040629011617Z8225739-1530+4713@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6MpC4B+GiwQmKOrv"
Content-Disposition: inline
In-Reply-To: <20040629011617Z8225739-1530+4713@linux-mips.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--6MpC4B+GiwQmKOrv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-29 09:14:31 +0800, taoyong <taoyong2002cncq@yahoo.com.cn>
wrote in message <20040629011617Z8225739-1530+4713@linux-mips.org>:
> Hi linux-mips,
>    =20
>        We use the PB1000 board, and now need to add a touchscreen
> to the board. The touchscreen is Onetouch (RS232). We have got the
> driver in Linux ,which is for PC REDHAT Linux and XFree 86. The GUI
> we use  is Microwindows, we need to add the touchscreen to it. Have
> someone have the same experience? Would you please give me some
> advices?
[Please limit line length to about 70 chars to save *me* time for
reformatting, thanks]

Well, googling for it revealed there's source code for the driver
available, eg. at ftp://ftp.gnudd.com/pub/onetouch/onetouch-1.2.tar.gz .

However, if your vendor is only smart enough to point you to binaries,
you'd probably think about using another product for your application.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--6MpC4B+GiwQmKOrv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4QoCHb1edYOZ4bsRAohCAJ9LsLU57BJvLckOyzK4i7lkzP0gFgCfbXmm
VMq5KbgFqzwU7x4BdXRq/6o=
=j1Of
-----END PGP SIGNATURE-----

--6MpC4B+GiwQmKOrv--
