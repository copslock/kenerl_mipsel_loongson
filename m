Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 01:31:44 +0100 (CET)
Received: from ozlabs.org ([203.10.76.45]:39171 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493633AbZKYAbk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 01:31:40 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id CF4DFB6F0A;
        Wed, 25 Nov 2009 11:31:34 +1100 (EST)
Subject: Re: Time to make PCI_MSI default y ?
From:   Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-pci <linux-pci@vger.kernel.org>, linux@arm.linux.org.uk,
        "tony.luck" <tony.luck@intel.com>, fenghua.yu@intel.com,
        "David S.Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Peter Anvin <hpa@zytor.com>, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <1259096952.16367.134.camel@pasglop>
References: <1259030388.20596.5.camel@concordia>
         <20091124125309.GB5749@linux-mips.org> <1259096952.16367.134.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-RVz3yeQHAyvYEEUvnxfu"
Date:   Wed, 25 Nov 2009 11:31:34 +1100
Message-ID: <1259109094.4017.5.camel@concordia>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Return-Path: <michael@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@ellerman.id.au
Precedence: bulk
X-list: linux-mips


--=-RVz3yeQHAyvYEEUvnxfu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-11-25 at 08:09 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2009-11-24 at 12:53 +0000, Ralf Baechle wrote:
> > On Tue, Nov 24, 2009 at 01:39:48PM +1100, Michael Ellerman wrote:
> >=20
> > > Having just hit a build-break caused by a distro building with
> > > PCI_MSI=3Dn, I set out to make it default y for powerpc. Unfortunatel=
y
> > > that's not possible, because it's in drivers/pci/Kconfig.
> > >=20
> > > So is it time to make it default y for everyone? It seems to me havin=
g
> > > it off is more likely to cause problems than having it on these days,
> > > though I'm not sure if that is true for all archs.
> > >=20
> > > An arch that really didn't want it default y could conditionally sele=
ct
> > > ARCH_SUPPORTS_MSI, like x86 does already.
> >=20
> > On MIPS the age of MSI only recently started; once single platform (Cav=
ium)
> > out of all the many uses it.  Cavium does a "select ARCH_SUPPORTS_MSI" =
but
> > not "select PCI_MSI" because not all platform variants actually have PC=
I.
> >=20
> > We should  not give a user a chance to select something wrong in kconfi=
g
> > thus automatically as many options for a platform as possible is a good
> > thing - after all the kconfig dialog for any given platfrom has become
> > painfully long.  And we really should have to avoid users having to kno=
w
> > that the Frobnic 2000 they're trying to upgrade the kernel for requires
> > MSI to work ...
>=20
> Still... select has nasty issues. I think default y is fine here. For
> platforms that don't need it, make sure their defconfigs don't have it
> set...
>=20
> Or maybe default y if (X86 || PPC)

Oh yeah I forgot we could do that. So we could either do that, or add a
ARCH_MSI_DEFAULT and use that as the if condition. If people really
care.

cheers



--=-RVz3yeQHAyvYEEUvnxfu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksMeuIACgkQdSjSd0sB4dJDdwCgnhD9XrrLpl3p2ixnZewInlnO
2rMAn2rFyVmTxDIznkutZov0DJUA0usN
=gF6g
-----END PGP SIGNATURE-----

--=-RVz3yeQHAyvYEEUvnxfu--
