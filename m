Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 15:03:59 +0100 (CET)
Received: from hydra.gt.owl.de ([195.71.99.218]:58690 "EHLO hydra.gt.owl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492788AbZKYOBG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 15:01:06 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
        id 51E2332D59; Wed, 25 Nov 2009 15:01:05 +0100 (CET)
Date:   Wed, 25 Nov 2009 15:01:05 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     linux-mips@linux-mips.org,
        Arnaud Patard <arnaud.patard@rtp-net.org>
Subject: Re: Syncing CPU caches from userland on MIPS
Message-ID: <20091125140105.GB13938@paradigm.rfc822.org>
References: <20091124182841.GE17477@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20091124182841.GE17477@hall.aurel32.net>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200911251404@listme.rfc822.org
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25121
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2009 at 07:28:41PM +0100, Aurelien Jarno wrote:
> Hi all,
>=20
> This question is not really kernel related, but still MIPS related, I
> hope you don't mind.
>=20
> Arnaud Patard and myself are trying to get qemu working on MIPS [1],
> which includes translating TCG code (internal representation) into MIPS
> instructions, that are then executed. Most of the code works, but we=20
> have some strange behaviors that seems related to CPU caches.
>=20
> The code is written to a buffer, which is then executed. Before the
> execution, the caches are synced using the cacheflush syscall:
>=20
> | #include <sys/cachectl.h>
> | =20
> |=20
> | static inline void flush_icache_range(unsigned long start, unsigned lon=
g stop)
> | {
> |     cacheflush ((void *)start, stop-start, ICACHE);
> | }

Would this only evict stuff from the ICACHE? When trying to execute
a just written buffer and with a writeback DCACHE you would need to=20
explicitly writeback the DCACHE to memory and invalidate the ICACHE.

> It seems this is not enough, as sometimes, some executed code does not
> correspond to the assembly dump of this memory region. This seems to be=
=20
> especially the case of memory regions that are written twice, due to
> relocations:
> 1) a branch instruction is written with an offset of 0
> 2) the offset is patched
> 3) cacheflush is called
>=20
> Sometimes the executed code correspond to the code written in 1), which
> means the branch is skipped.

Which proves my theory - as long as you have cache pressure you will happily
writeback the contents to memory before trying to execute (you invalidate
the ICACHE above) - In case you DCACHE does not suffer from pressure
the contents will not been written back and you'll execute stale code.

Flo
--=20
Florian Lohoff                                         flo@rfc822.org
"Es ist ein grobes Missverst=E4ndnis und eine Fehlwahrnehmung, dem Staat
im Internet Zensur- und =DCberwachungsabsichten zu unterstellen."
- - Bundesminister Dr. Wolfgang Sch=E4uble -- 10. Juli in Berlin=20

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFLDTihUaz2rXW+gJcRAnO1AJ4/Qof+YrAAglLHkfpM9i2uZANqCgCgp+Fa
0TXDzyKTdq6HdhaO+0hq8b8=
=H04T
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
