Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2010 06:56:02 +0100 (CET)
Received: from ozlabs.org ([203.10.76.45]:35687 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491187Ab0K2Fzj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Nov 2010 06:55:39 +0100
Received: by ozlabs.org (Postfix, from userid 1007)
        id B42131007D1; Mon, 29 Nov 2010 16:55:33 +1100 (EST)
Date:   Mon, 29 Nov 2010 16:55:29 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Michael Ellerman <michael@ellerman.id.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        sparclinux@vger.kernel.org
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-ID: <20101129055529.GB17113@yookeroo>
Mail-Followup-To: Michael Ellerman <michael@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        sparclinux@vger.kernel.org
References: <1290607413.12457.44.camel@concordia>
 <1290692075.689.20.camel@concordia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1290692075.689.20.camel@concordia>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <dgibson@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david@gibson.dropbear.id.au
Precedence: bulk
X-list: linux-mips


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 26, 2010 at 12:34:35AM +1100, Michael Ellerman wrote:
> On Thu, 2010-11-25 at 01:03 +1100, Michael Ellerman wrote:
> > Hi all,
> >=20
> > There were some murmurings on IRC last week about renaming the of_*()
> > routines.
> ...
> > The thinking is that on many platforms that use the of_() routines
> > OpenFirmware is not involved at all, this is true even on many powerpc
> > platforms. Also for folks who don't know the OpenFirmware connection
> > it reads as "of", as in "a can of worms".
> ...
> > So I'm hoping people with either say "YES this is a great idea", or "NO
> > this is stupid".
>=20
> I'm still hoping, but so far it seems most people have got better things
> to do, and of those that do have an opinion the balance is slightly
> positive.
>=20
> So here's a first cut of a patch to add the new names. I've not touched
> of_platform because that is supposed to go away. That will lead to some
> odd looking code in the interim, but I think is the right approach.
>=20
> Most of these are straight renames, but some have changed more
> substantially. The routines for the flat tree have all become fdt_foo().

I'm a little uneasy about using the same prefix as libfdt (fdt_foo())
for routines that have a different implementation and different names
/ semantics to the libfdt routines.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzzQFAACgkQaILKxv3ab8aptgCfdeFXAx2mw0aSkvLCjjeK6/in
bxcAn3B5S1BtG710FZ0hXoDDeRVuyxjk
=0pcc
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
