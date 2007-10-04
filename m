Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 13:26:13 +0100 (BST)
Received: from [203.94.56.252] ([203.94.56.252]:59520 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S20022366AbXJDM0E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 13:26:04 +0100
Received: (qmail 7132 invoked from network); 4 Oct 2007 12:24:55 -0000
Received: from unknown (HELO ?IPv6:2001:388:c116:1:2e0:4dff:fe01:536?) (2001:388:c116:1:2e0:4dff:fe01:536)
  by 2001:388:c116:1::1 with ESMTPS (DHE-RSA-AES256-SHA encrypted); 4 Oct 2007 12:24:55 -0000
Message-ID: <4704DB98.1070905@gentoo.org>
Date:	Thu, 04 Oct 2007 22:24:56 +1000
From:	Stuart Longland <redhatter@gentoo.org>
User-Agent: Thunderbird 2.0.0.0 (X11/20070512)
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	Kumba <kumba@gentoo.org>, Ed Stafford <ed.stafford@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: What is the current state of the Octane/IP30 support?
References: <41370a610710021341g749742dejec06b3a38477fd47@mail.gmail.com> <47033156.7090703@gentoo.org> <Pine.LNX.4.64.0710030902110.14583@anakin>
In-Reply-To: <Pine.LNX.4.64.0710030902110.14583@anakin>
X-Enigmail-Version: 0.95.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/%7Eredhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig9CDA26EDC92FD680444C5095"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CDA26EDC92FD680444C5095
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven wrote:
> On Wed, 3 Oct 2007, Kumba wrote:
>> For the most part, Impact-based systems run great.  You get X, unaccel=
erated,
>> no 3D, and a framebuffer.  VPro, framebuffer, but no X.  USB kinda weo=
rks if
>                                    ^^^^^^^^^^^^^^^^^^^^^
> What's the reason for not having X? X doesn't support the frame buffer =
layout?
>=20
> Gr{oetje,eeting}s,

My understanding, is there are two problems:

o VPro (and IMPACT) have its own dedicated memory separate from the
system memory, thus one cannot use fbdev to run X.  ("framebuffer"
perhaps is bad terminology)
o No-one except SGI seems to know how to load images into the video
memory using DMA.  Thus the shadowfb approach used to construct the
IMPACT X11 driver, isn't possible for VPro.

If someone could figure the latter problem out... we could have full
VPro support, including OpenGL, which would be sweet.  But apparently
this has been less than trivial to achieve.  Certainly well beyond my
limited skills. ;-)

Regards,
--=20
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
=2E . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--------------enig9CDA26EDC92FD680444C5095
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHBNuZuarJ1mMmSrkRCt9dAJ4zmNzbgrJ8SMgq6mPT+vp/k0OEcQCeL9z5
5xXuzwslmOQohgUlgWC99x4=
=DJXO
-----END PGP SIGNATURE-----

--------------enig9CDA26EDC92FD680444C5095--
