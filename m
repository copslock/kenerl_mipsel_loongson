Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2004 14:25:04 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:50346 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225875AbUEMNZD>; Thu, 13 May 2004 14:25:03 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 8980F4B5B5; Thu, 13 May 2004 15:25:01 +0200 (CEST)
Date: Thu, 13 May 2004 15:25:01 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: IOC3 interrupt management
Message-ID: <20040513132501.GC1912@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <Pine.GSO.4.10.10405111949550.8069-100000@helios.et.put.poznan.pl> <20040513001405.GC18513@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="92jpbWK/k6ZbIj2k"
Content-Disposition: inline
In-Reply-To: <20040513001405.GC18513@linux-mips.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--92jpbWK/k6ZbIj2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-05-13 02:14:05 +0200, Ralf Baechle <ralf@linux-mips.org>
wrote in message <20040513001405.GC18513@linux-mips.org>:
> On Tue, May 11, 2004 at 07:56:40PM +0200, Stanislaw Skowronek wrote:

> So, Octane is different ...  I suggest you treat ethernet as a normal PCI
> device - the Linux PCI code doesn't know how to handle anything else.  Th=
en
> in ioc3-eth.c itself you can register the serial interface with 8250.c

Sig'ed.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--92jpbWK/k6ZbIj2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAo3ctHb1edYOZ4bsRAiKJAJ9mKHTJ4SGv4f1GHggXTTVHELRuCACcCQJQ
P7aEPtoT0z7ic0A7SyzVajY=
=sfsr
-----END PGP SIGNATURE-----

--92jpbWK/k6ZbIj2k--
