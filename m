Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 15:37:43 +0100 (CET)
Received: from hydra.gt.owl.de ([195.71.99.218]:49431 "EHLO hydra.gt.owl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492848AbZKYOce (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 15:32:34 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
        id 7388B32D60; Wed, 25 Nov 2009 15:32:32 +0100 (CET)
Date:   Wed, 25 Nov 2009 15:32:32 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Arnaud Patard <arnaud.patard@rtp-net.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org
Subject: Re: Syncing CPU caches from userland on MIPS
Message-ID: <20091125143232.GH13938@paradigm.rfc822.org>
References: <20091124182841.GE17477@hall.aurel32.net> <20091125140105.GB13938@paradigm.rfc822.org> <87pr76acu2.fsf@lechat.rtp-net.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <87pr76acu2.fsf@lechat.rtp-net.org>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200911251404@listme.rfc822.org
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25123
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2009 at 03:39:01PM +0100, Arnaud Patard wrote:
> > Would this only evict stuff from the ICACHE? When trying to execute
> > a just written buffer and with a writeback DCACHE you would need to=20
> > explicitly writeback the DCACHE to memory and invalidate the ICACHE.
>=20
> we already though about using BCACHE instead of ICACHE only but it
> didn't make any difference. the bug is still there.

My understanding is you need both ...

FLUSH/WRITEBACK the dcache and INVALIDATE the icache - the icache needs
to load the data which is in the dcache via memory.

Flo
--=20
Florian Lohoff                                         flo@rfc822.org
"Es ist ein grobes Missverst=E4ndnis und eine Fehlwahrnehmung, dem Staat
im Internet Zensur- und =DCberwachungsabsichten zu unterstellen."
- - Bundesminister Dr. Wolfgang Sch=E4uble -- 10. Juli in Berlin=20

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFLDUAAUaz2rXW+gJcRAjv8AJ9bif9B9aBIW1iJcsfObw2QR/8FEgCg3YsH
jX4EhAtG+Pemr/b7svsByg8=
=MOSU
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
