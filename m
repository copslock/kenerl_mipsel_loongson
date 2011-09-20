Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2011 05:19:39 +0200 (CEST)
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:55947 "EHLO
        qmta05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490965Ab1ITDTf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2011 05:19:35 +0200
Received: from omta24.emeryville.ca.mail.comcast.net ([76.96.30.92])
        by qmta05.emeryville.ca.mail.comcast.net with comcast
        id abFW1h0041zF43QA5rKNPE; Tue, 20 Sep 2011 03:19:22 +0000
Received: from [192.168.1.13] ([76.106.65.35])
        by omta24.emeryville.ca.mail.comcast.net with comcast
        id araU1h0030leNgC8kraUD1; Tue, 20 Sep 2011 03:34:29 +0000
Message-ID: <4E78061D.70603@gentoo.org>
Date:   Mon, 19 Sep 2011 23:18:53 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
MIME-Version: 1.0
To:     BSDero <bsdero@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Does the VIA VT6212 USB Host controller works on SGI/Mips?
References: <loom.20110920T021938-457@post.gmane.org> <4E77FD57.2000407@gentoo.org> <loom.20110920T044720-278@post.gmane.org>
In-Reply-To: <loom.20110920T044720-278@post.gmane.org>
X-Enigmail-Version: 1.2.1
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD26E2EE6C63D01ED742B9170"
X-archive-position: 31111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10311

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD26E2EE6C63D01ED742B9170
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/19/2011 22:50, BSDero wrote:

> I belongs to http://www.nekochan.net site and we would like to have thi=
s device
> working on Irix, so I'm looking for useful information about this in or=
der to
> have a suitable driver for this device in SGI workstations...=20
>=20
> Thanks by the info. Do u remember which type of VIA PCI USB controller?=
  It was
> a VT6212??
>=20
> :)


Sorry, not VIA.  ALi:
00:03.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog=
-if
10 [OHCI])
        Subsystem: ALi Corporation ASRock 939Dual-SATA2 Motherboard
        Flags: 66MHz, medium devsel, IRQ 21
        Memory at 280022000 (32-bit, non-prefetchable) [disabled] [size=3D=
4K]
        Capabilities: [60] Power Management version 2

VIA is UHCI, and that's what I had problems with.  But that was also seve=
ral
years ago and maybe it would work know if I actually knew where that card=

was.  PCI on many of the SGI systems is a strange beast...

--=20
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  A=
nd
our lives slip away, moment by moment, lost in that vast, terrible in-bet=
ween."

--Emperor Turhan, Centauri Republic


--------------enigD26E2EE6C63D01ED742B9170
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQIcBAEBAgAGBQJOeAYdAAoJENsjoH7SXZXjiAQP/0Jr6yKSxyxgDs1/RrH+qCJw
R3tiHnbzDe3qCqn1becMuRBN3H8A+EWguHBaEyxbv/6HPtJ92aD23JPd+W2Ihdv5
Y4129NlfVt/hbxvKVQOVj4uUSnZNi76YOURGPM3rflSilBM/AQEwoaBRCLx3HHp4
yhwvOUR8BhfqORn+Uc2hzz6hNJJqqSF5KvS8tJr9Qvftm7oud6egMJO9r/fE2Vtn
CgtqlfRxTQ5zGq3BATACRdrlEfVUShtK4td07z3U+RcbwBOjAgAgfKloMWcLdzAZ
QBftLZAaNsqwPnHwpwhcC+eXZoKb4ixJsTykwbI2n38pHb5s7wZLJ5upPxRVAm7F
JO7Pn5yim38LILow3iQu7PDAQ0Mpoq7a8Ijel7c3NHqqU9kYFudWXOocV60qSLeg
6vL5ITFZNpg2u6dPhbrfMwkcdtuA0V19i3C8oQtPYg9wAXVkPvPoTJSfSIn8j3uE
frgLYha6yiwWkwcIdPAqcIcc6oG52MyKrRaHywmxZz8DItNMrvOsuDEji+SprlV4
r9sGQgNuhfYdHDyal6Be/KCHvCVJ3hQpiTC38/WH1RJXYjMu/FJCwKBTqb9NmQZc
o1kYLdp58gQ7YmnxdLBpd8bFdWFG/Ir+F3t/fc67UTXnDW6M9KBBAjCNWqwAZyV7
ZK1BkKoxBkSXeFsoynjJ
=lOF/
-----END PGP SIGNATURE-----

--------------enigD26E2EE6C63D01ED742B9170--
