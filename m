Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Feb 2013 15:23:35 +0100 (CET)
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:60189
        "EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816607Ab3BJDytx6MYe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Feb 2013 04:54:49 +0100
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
        by qmta09.westchester.pa.mail.comcast.net with comcast
        id yTgb1k0031YDfWL59TujZv; Sun, 10 Feb 2013 03:54:43 +0000
Received: from [192.168.1.13] ([69.251.154.25])
        by omta20.westchester.pa.mail.comcast.net with comcast
        id yTuh1k00F0Z8pnp3gTuigU; Sun, 10 Feb 2013 03:54:42 +0000
Message-ID: <51171A08.20302@gentoo.org>
Date:   Sat, 09 Feb 2013 22:54:48 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: prom start
References: <20130206160508.GR2118@belle.intranet.vanheusden.com>
In-Reply-To: <20130206160508.GR2118@belle.intranet.vanheusden.com>
X-Enigmail-Version: 1.5
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2PGLTWBNJCWMINDHNICSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20121106; t=1360468483;
        bh=mwMbqKzT8reVObD521VYpEapjt4P6oXsuuKLVsTyiTs=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=A6Pnef17wXtTz0SdqtHPNOKbeJBDoA680cghQQi3DSeCkLKYN+d8idZkzydIvGNku
         Yc5gYzGboMTwHLqk944x7AmKZjOWaBYYbcXXuT3wcHOguJH+zmyMxmcT8HffI47oIR
         Y0uNH6Yl70I3au+aU2+4QFfTqOdaxIAATTpoE0hzooP4AvUlu+5L0WJOu4uf+zO/G+
         It+dAaKIfI63w3yEodpOPL2OXk0WmUdJ+Mjrcav6zGQ6wwRW/GiTGZ3PGkXslUJjz+
         rL6HdD9xD/uRHYdK4MluGs/JoXCLd0lAszsOgb6/26Ylt/HMMyTUYg0F5vyGvBr/+y
         8hjokYCS5fXOQ==
X-archive-position: 35739
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2PGLTWBNJCWMINDHNICSC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/06/2013 11:05 AM, folkert wrote:
> Hi,
>=20
> Is this mailing list also meant for generic mips questions? (if not: an=
y
> suggestions for one that is?)
>=20
> If so: I'mm experimenting a bit with mips, specifically on SGI hardware=

> (Indigo). Now it seems all mips systems have the prom at 0xbfc00000. Bu=
t
> how does it start? The first 0x3c0 bytes seem to be nonsense. Somewhere=

> on the web I found that 0xbfc00884 is the starting point but after
> single stepping 5 instructions, the program counter jumps to 0x00000000=

> so I don't think that's the right one either. Also, reading the first 4=

> bytes from bfc00000 and using that as a pointer seems to be invalid too=
:
> 0bf000f0.
> Anyone with insights regarding the booting of the prom on sgi systems?
>=20
>=20
> Regards,
>=20
> Folkert van Heusden

The first Indigo?  IP12?  Or the Indigo2 series (IP22, IP26, or IP28)?

ARCS (the SGI prom) is a bit of black magic and voodoo.  It also terrifie=
s
the priests of Ancient Mu.

You might want to hunt down copies of the PROM images for other SGI syste=
ms,
such as IP22, IP32 (O2), IP30 (Octane) (the latter two are on certain IRI=
X
media) and analyze those in a disassembler and see if you can discern
something from there.

You might also try gxemul and see if it can boot one of those proms (it's=
 a
machine emulator like Qemu, but has some code tailored to SGI hardware in=

it).  Might give you some additional insight.

Would be curious about your results if you can learn anything else from i=
t
via your own work.

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


------enig2PGLTWBNJCWMINDHNICSC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (MingW32)

iQIcBAEBAgAGBQJRFxoPAAoJENsjoH7SXZXj6F8P/3DUdC+viQBkxZ0hR7Eoq269
g1WMRyRRsCVLbFSBThAiMoEPcFuZFdgn8KZMEgvMaCiUOCiMPCnSQL5MU7j4ffea
1eOyswMXjhsNXMq+WCOgQjrj/B0rT/a8qFNwSBbSUGY2I/a7Cmqpp3p8HnmIoIMa
qdE3bbopb/Q0bTQ/DGQitqy8NiGIthbEu24af+wwOuu8DVhaoSlhSTAnljYJ3BgO
/u4cgMmI060IjVg9CCzw4u68USBy68E7N3RO1eeoJuyxyBN11y4US4g8fxXHWDUb
drHOGsfVR2bx26WMt4nlO2VHHbAX7pU46weR6bubet2Oal252o7pe5KzH/DrU94z
Clqhs/A3/XgAq+8Vhbx2ab+Jv103MKeY2dgXpyfstg6fLpKdT/CUKWuPpRLOD9y+
hiKj89/Q7pkF2EETlJYpWM0TEtqI8USi4SMR6rgfmhQSDEEN199iHdPNoDIpTiG7
LA2py3YOHU3g2JmCIroelWZua1nL+Mw6QDHrFrlAsCebje5cdvEe8EAcyJOG2QOP
yGTeuZSy2Eo/khSelYvgxDfUoyyun6m07OoOqpOLorDzbdO4A02YKg45WsDHC/wp
3H3iD4FfvxgAn9RjXxHBpRE4k6h0CTRjpZdmm12RSAKWYR2DNLOftq5TgI2ytTC3
k915PNZwKb0qgDmps7hB
=q0OC
-----END PGP SIGNATURE-----

------enig2PGLTWBNJCWMINDHNICSC--
