Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 22:17:27 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38827 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007493AbbE0UR0HUZdw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 22:17:26 +0200
Received: from dab-yat1-h-41-1.dab.02.net ([82.132.212.173] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1YxhlV-0006OM-RB; Wed, 27 May 2015 21:17:26 +0100
Received: from ben by deadeye with local (Exim 4.85)
        (envelope-from <ben@decadent.org.uk>)
        id 1Yxhl9-0006s0-5b; Wed, 27 May 2015 21:17:03 +0100
Message-ID: <1432757813.6319.31.camel@decadent.org.uk>
Subject: Re: [PATCH v2] MIPS: Octeon: Set OHCI and EHCI MMIO byte order to
 match CPU
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Paul Martin <paul.martin@codethink.co.uk>
Date:   Wed, 27 May 2015 21:16:53 +0100
In-Reply-To: <Pine.LNX.4.44L0.1505261136070.1519-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1505261136070.1519-100000@iolanthe.rowland.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-S/AlYncZdpdWH/fMF25o"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 82.132.212.173
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47697
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


--=-S/AlYncZdpdWH/fMF25o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-05-26 at 11:46 -0400, Alan Stern wrote:
> On Mon, 25 May 2015, Ben Hutchings wrote:
>=20
> > The Octeon OHCI is now supported by the ohci-platform driver, and
> > USB_OCTEON_OHCI is marked as deprecated.  However, it is currently
> > still necessary to enable it in order to select
> > USB_OHCI_BIG_ENDIAN_MMIO.  Make CPU_CAVIUM_OCTEON select that as well,
> > so that USB_OCTEON_OHCI is really obsolete.
>=20
> Good catch.
>=20
> > The old ohci-octeon and ehci-octeon drivers also only enabled big-endia=
n
> > MMIO in case the CPU was big-endian.
>=20
> This is true in the current kernel as well.  [eo]hci-platform.c enables
> big-endian MMIO only if the appropriate flag is set in the platform
> data or OF properties.

Oh, I see.

> >  Make the selections of
> > USB_EHCI_BIG_ENDIAN_MMIO and USB_OHCI_BIG_ENDIAN_MMIO conditional, to
> > match this.
>=20
> I'm not sure you want to do this.  [eo]hci-platform.c will fail with an=
=20
> error if the platform/OF data has the big-endian flag set but=20
> CONFIG_USB_[EO]HCI_BIG_ENDIAN_MMIO isn't defined.

The conditional selection should match the platform data in
arch/mips/cavium-octeon/octeon-platform.c

> > Fixes: 2193dda5eec6 ("USB: host: Remove ehci-octeon and ohci-octeon dri=
vers")
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> > v2: Make selections conditional
> >=20
> > This is also untested; I'm just comparing the old and new code.
>=20
> Is there anyone who can test this with both big-endian and=20
> little-endian hardware?

Failing that, the previous version of this patch ("MIPS: Octeon: Select
USB_OHCI_BIG_ENDIAN_MMIO") should be a safe fix.

The conditional selection in this patch is a possible optimisation on
top of that, and not a necessary fix as I thought.

Ben,

--=20
Ben Hutchings
Reality is just a crutch for people who can't handle science fiction.

--=-S/AlYncZdpdWH/fMF25o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIUAwUAVWYmP+e/yOyVhhEJAQpXaA/3biBt3xnu8X9RS5ivuMBdySTwjdnBmd82
ryxUyFOZYoZvq8rHKFdDTgBoYZtDkw0SuPzbmG5FgFEtTfvUzvdZZpTh19W2Z94s
4pfesTus2+rrta80Kikj6flkh4IZsG/b05FS+Rks7PRqZXxVR92lJ5Az3Ds0lPbH
DepnEJlsuJfazOV/Jhgli9anktK6nxfCskOILJL7JqS6CAt6ckGc/ltY0Fg1Qh7b
9OunadmFTtgY218//646cFqJ31P5kow9cHEP//EPcy9tTA58OKGb8SOZ5ds/4BBr
yTMZTv0jLNL3Goa+aJDYjZduziFRJvjBPcl9EHIYRioQPEEggx2+S/DlEii8QCOH
sBRGhCIhKSuVAIZq0+kA/p3ejh0QVeQU0VneDi4a47DvP6QNsf9WZcw0JdXK+XPV
EKWCuj4JDaHBCiYwSh7tFb9mrSIPft62/0dFSSaz8h1kXxS6SRTvNO13PD7L5xCX
QOmsf90fd46OVkQ3opPcwakVY89tgSMuV2f1L4+2o2F7qXzi2D3Q2dzE1lUIPXda
j5vXMMJabovDMPiFm1I+IiXzy1HtClzRjeBytub4PO6TB3sfqx2KFsnNFfVtnfIN
AAOK6UtqP9BWAMqgDqM84R9TklcP4YFPkUc1iJP8D3BVx6sYGLOyhBARS2fDm8Z7
+hOOj/8dqA==
=bOmC
-----END PGP SIGNATURE-----

--=-S/AlYncZdpdWH/fMF25o--
