Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 09:03:27 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:31718 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225203AbUGMIDW>; Tue, 13 Jul 2004 09:03:22 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 20F8C4B67D; Tue, 13 Jul 2004 10:03:21 +0200 (CEST)
Date: Tue, 13 Jul 2004 10:03:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Help with MOP network boot install on DECstation 5000/240
Message-ID: <20040713080320.GC18841@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org> <000701c468ae$141c3e50$0a9913ac@swift>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PcDVawgyoD+Fem/v"
Content-Disposition: inline
In-Reply-To: <000701c468ae$141c3e50$0a9913ac@swift>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--PcDVawgyoD+Fem/v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-13 15:49:30 +0800, Collin Baillie <collin_no_spam_for_me@xo=
rotude.com>
wrote in message <000701c468ae$141c3e50$0a9913ac@swift>:

[Thanks for *not* hijacking threads]

> I'm trying to install linux-mips on a DECsation 5000/240 I have in my
> posession. It has the 5.1b rom so tftp boot is apparently out.
>=20
> I've setup mopd on a linux (i386) box here and I'm getting the following =
on
> my DECstation:
>=20
> >>boot 3/mop
[...]
> I've tried with both the ecoff and the elf kernels (2.4.18) listed on
> Karel's web pages.

So it seems to try to get a file some times and gives up on it.

> I was wondering if anyone on the list has had any success installing via =
MOP
> onto a DECstation 5000/240 and would be able to offer me any assistance.

Maybe you'd try Debian's install image?

By the way, which mopd are you using? There are several of them around,
some quite unuseable...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--PcDVawgyoD+Fem/v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA85dIHb1edYOZ4bsRAkZUAJ92ropZuea1jtsR5LeozUZ/5kq5aQCdEOQ2
tzyqf5hwDPG9jd2k8soak60=
=4hE8
-----END PGP SIGNATURE-----

--PcDVawgyoD+Fem/v--
