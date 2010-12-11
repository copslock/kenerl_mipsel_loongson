Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Dec 2010 21:35:05 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50558 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491910Ab0LKUfC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Dec 2010 21:35:02 +0100
Received: from [192.168.4.185] (helo=localhost)
        by shadbolt.decadent.org.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <ben@decadent.org.uk>)
        id 1PRW9h-0004nR-3f; Sat, 11 Dec 2010 20:34:57 +0000
Received: from ben by localhost with local (Exim 4.72)
        (envelope-from <ben@decadent.org.uk>)
        id 1PRW9g-0002nH-KI; Sat, 11 Dec 2010 20:34:56 +0000
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Namhyung Kim <namhyung@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20101201165517.GA5560@linux-mips.org>
References: <1291221282-9056-1-git-send-email-namhyung@gmail.com>
         <20101201165517.GA5560@linux-mips.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2vJGUNZKTMiI2T/S4QNl"
Date:   Sat, 11 Dec 2010 20:34:56 +0000
Message-ID: <1292099696.3136.46.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
X-SA-Exim-Connect-IP: 192.168.4.185
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: Re: [PATCH] MIPS: Fix build failure on mips_sc_is_activated()
X-SA-Exim-Version: 4.2.1 (built Wed, 25 Jun 2008 17:14:11 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
Precedence: bulk
X-list: linux-mips


--=-2vJGUNZKTMiI2T/S4QNl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-12-01 at 16:55 +0000, Ralf Baechle wrote:
> On Thu, Dec 02, 2010 at 01:34:42AM +0900, Namhyung Kim wrote:
>=20
> > The commit ea31a6b20371 ("MIPS: Honor L2 bypass bit") breaks
> > malta build as follows. Looks like not compile-tested :(
>=20
> Already fixed in the linux-mips git tree by an identical patch in
> commit 9a3475880131752d3d78ac25516fd3eab3fca871.
>=20
> Thanks anyway!

This isn't in Linus's tree yet; please ask him to pull it in time for
2.6.37.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-2vJGUNZKTMiI2T/S4QNl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUATQPga+e/yOyVhhEJAQJstg/+PaQfDbvpEoEPGWBdQaVuoPUPdmbrzKrN
E0TYmeKD9S+B/YcvTgMB/moprKyjkuHuG+1Az4IUDlMvuyEg5nzDocd5LWoBqB1Y
pkMLb8BurcMwD2rS192MlkSjgEfJolwyiusGzw4mu2YUKnrMfqbAZNymLQoSFVWz
ytN2wBQlQ5D0MfFIgncY9f9J70TiAZkMeBVFOgfBJWKj3c8lRWXQVbFjBbI7Spmd
E/d/2j76XQrb2sJRWCNRIr+ZRsDqiPJIDI8pRbveAZCtXKPXg8/mi1iVNq1XOsG+
CaDdos+U9vfgl+/2djF65nWcX8xQW4ls2+5Fkbv5eN8Po/Bqil8wRYfdrnYD5398
49ufElAs6YypenoaqLP17pvVij62y1DftuvHui5I2SlFCrwSUYrz6ckQvmPFjx0i
VfRCgonwPtSn5Sse5udmwmUScr+ZHcZL4jr/irg3xD5k87my6TOh4nttsdHR0upo
4pRiIuQbEqSp64GX94DpmnT7wiEwWMtL+MdrUspIst0wP4HERRGlxJbjViRML7A3
CSUg4iA8Xn9W944Xo24Q3PxniSWMs/zD4/KM16r+K/LdLLcRLh5uUeyqR9M7IRmc
2tbRxyKBBZeRx+8SEzxUhWoEPzhmhUDoRRGI377R923s3B0LYDWAR23JN42e9x0V
NBePjmAZLJc=
=o547
-----END PGP SIGNATURE-----

--=-2vJGUNZKTMiI2T/S4QNl--
