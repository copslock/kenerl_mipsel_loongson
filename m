Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 03:02:20 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40125 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012184AbaJWBCStfIl4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 03:02:18 +0200
Received: from [88.202.169.74] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1Xh6nB-0000MJ-Ro; Thu, 23 Oct 2014 02:02:17 +0100
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1Xh6nA-0000Pk-Pt; Thu, 23 Oct 2014 02:02:16 +0100
Message-ID: <1414026131.5994.20.camel@decadent.org.uk>
Subject: Re: Single MIPS kernel
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        Debian kernel maintainers <debian-kernel@lists.debian.org>
Date:   Thu, 23 Oct 2014 02:02:11 +0100
In-Reply-To: <20141022232233.GF12502@linux-mips.org>
References: <20141022083437.GB18581@linux-mips.org>
         <5447F155.60106@gmail.com> <20141022192018.GD12502@linux-mips.org>
         <1414016140.5994.9.camel@decadent.org.uk>
         <20141022232233.GF12502@linux-mips.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-EfFuqWW+XdryF2FG0CHj"
X-Mailer: Evolution 3.12.7-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 88.202.169.74
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-EfFuqWW+XdryF2FG0CHj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-10-23 at 01:22 +0200, Ralf Baechle wrote:
> On Wed, Oct 22, 2014 at 11:15:40PM +0100, Ben Hutchings wrote:
>=20
> > >=20
> > > That's probably more of an implementation detail.  I'm more concerned=
 about
> > > the overall bloat.  I think many embedded users are so addivted to be=
nchmark
> > > results that this going to make or break the whole scheme.
> >=20
> > If you can make relocation a configuration option (as on x86), it would
> > allow distributions to build multiplatform kernels without preventing
> > embedded users from building a kernel optimised for their specific
> > system.  But I know very little about MIPS or how intrusive the changes
> > for relocation would have to be.  Perhaps it would be too much of a
> > maintenance burden to make this an option.
>=20
> The scope of the changes is relativly limited - we're much more concerned
> about the impact on binary size, memory size or performance of the
> various approaches under discussion.
>=20
> I wonder kernels for which platforms would Debian want to unify?

I don't have high expectations for being able to unify those we
currently support.  Realistically, I expect that most development effort
will go into new platforms.  (What we saw with ARM was that
multi-platform was implemented for most ARMv7 platforms (for which we
now need only 2 configurations) but only slowly for older chips (4
configurations, and that's after dropping 2 platforms).)

Anyway, we have one 32-bit configuration for each byte order
(4kc-malta), and the following 64-bit configurations:

[big-endian]
r4k-ip22:      CONFIG_SGI_IP22, CONFIG_CPU_R4X00
r5k-ip32:      CONFIG_SGI_IP32, CONFIG_CPU_R5000
sb1-bcm91250a: CONFIG_SIBYTE_SWARM, CONFIG_CPU_SB1
5kc-malta:     CONFIG_MIPS_MALTA, CONFIG_CPU_MIPS64_R1
octeon:        CONFIG_CAVIUM_OCTEON_SOC

[little-endian]
sb1-bcm91250a: CONFIG_SIBYTE_SWARM, CONFIG_CPU_SB1
5kc-malta:     CONFIG_MIPS_MALTA, CONFIG_CPU_MIPS64_R1
loongson-2e:   CONFIG_MACH_LOONGSON, CONFIG_LEMOTE_FULOONG2E
loongson-2f:   CONFIG_MACH_LOONGSON, CONFIG_LEMOTE_MACH2F
loongson-3:    CONFIG_MACH_LOONGSON, CONFIG_LOONGSON_MACH3X

In general, I want our kernel packages to support any hardware that is
or has been generally available to buy, that can feasibly run a general
purpose distribution.  I'm somewhat hopeful that Prpl members will be
introducing new platforms that fit this description in the near future.

But I also want the packages to build natively in a few hours on each
architecture.  Currently, it takes about 17 hours on little-endian
(Loongson 3A, quad-core) and longer on big-endian (Octeon v0.3, 6 cores
used).  So I can't accept a further increase in the number of
configurations as new MIPS platforms appear.  Without multi-platform
support, we will have to drop one platform for each one we add, so we'll
have to be quite picky about adding them.

Ben.

--=20
Ben Hutchings
Q.  Which is the greater problem in the world today, ignorance or apathy?
A.  I don't know and I couldn't care less.

--=-EfFuqWW+XdryF2FG0CHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVEhTmOe/yOyVhhEJAQrx0BAAqO0XfwGpzH7mERQIfPUbXaU3r08t8qlE
tevZX3LQyb4mI67ynC8l2ykEnrrI4pJPO7UqUSedniMac5OlI/Qfz/WgK9nFElxZ
63JuWR/rWc4OxvVl8/b+W9CEukinx0DMVxgWjryso8MreftTCiOz9Ox0lFsCdWml
wi3YiOLqP6Ls9rBz3VPG4D4ubkua2YZC2yEd+1xZNzUHUb8uIDeMkem8lSmEWV9o
MqYQJKpKp6LYFMbTZQW7dAODI2u76q2P1gdlxUMTcU5Ymnv/xX2cUqL6W84149r+
Z9sXdqPtX+k//VCPT0Lu2Q3EMf+R5mmWjJucZZTmRxVWFzAZxAOQ64bGMmyPlZBO
mPRR5iZ5tsPmvQY9O5BCJJTA7Rkm3uoI/1kvAyBjgDMvTgMXTHjGBGUXZZzE4Ax2
mbuSoe408VazSNDI7DGmkgaQua1yGhn+ws7dVkoagXoeWVxEzU/+rOwm4qiV0o+j
+eZdTrWrk799xS4Z2ZddCksSsts8uBxguNpg/h57dZbWCKzxhJx8Ak8cbUISbq7u
fKhOUSHDKPKhngIxxrq005aR/ufoAAL3bIXSHBhR+90EKbCfMGMm5cZiFnwmGnKG
viqDOel94TwdJP3KuK20rMQmEOP9B5ARIAOSWRVLfaiGausbKlKZmDnaq9cvY9qn
0ImuBzTOIuw=
=JKRG
-----END PGP SIGNATURE-----

--=-EfFuqWW+XdryF2FG0CHj--
