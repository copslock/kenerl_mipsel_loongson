Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2003 15:40:30 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:59280 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225476AbTJXOkX>; Fri, 24 Oct 2003 15:40:23 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 7353C4A949; Fri, 24 Oct 2003 16:40:12 +0200 (CEST)
Date: Fri, 24 Oct 2003 16:40:12 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: configuring 2 ethernet ports
Message-ID: <20031024144012.GF12395@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20031024131838.GE12395@lug-owl.de> <Pine.GSO.4.44.0310240931350.17395-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310240931350.17395-100000@ares.mmc.atmel.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-10-24 09:41:23 -0400, David Kesselring <dkesselr@mmc.atmel.com>
wrote in message <Pine.GSO.4.44.0310240931350.17395-100000@ares.mmc.atmel.c=
om>:
> On Fri, 24 Oct 2003, Jan-Benedict Glaw wrote:
> > On Fri, 2003-10-24 09:11:26 -0400, David Kesselring <dkesselr@mmc.atmel=
=2Ecom>
> > wrote in message <Pine.GSO.4.44.0310240905590.17395-100000@ares.mmc.atm=
el.com>:
> > > /etc/sysconfig/network-scripts/ifcfg-eth1. After boot, when I look at
> > > /proc/pci it looks like the system detected the card fine but ifconfig
> > > only shows eth0 (the builtin port). How is the pci id linked to a
> > > particular driver? What else do I need to do? I've scoured google but=
 have
> >
> > In 2.4.x, drivers tend to only have internal knowledge on which hardware
> > they work. So you need to give some 'alias eth1 wlanmodulename' in your
> > /etc/modules.conf file.
> >
> I am using 2.4. Why does eth1 need a modules.conf file and eth0 doesn't. I

This is the case if you've compiled the driver for eth0 directly into
the kernel. Then, it'll automatically be started and userspace got an
interface to configure.

If it isn't directly compiled in, you've to give it a chance to figure
out the correct driver, eg. by a module.conf "alias" line or by a simple
modprobe somewhere...

> do not have loadable modules configured for my kernel. Do I have to? I
> don't even have a current modules.conf file.

You don't *need* to have modules. ...but then, you need to have the
correct driver compiled in. If it's already compiled in, then it
apparently doesn't recognize the card. In this case, the PCI table
inside the module's code is missing the PCI vendor/device ID.

> I also checked /etc/sysconfig/hwconf. This has the pci listing for my card
> but does not recognize the vendor or id. I did add an entry in the kernel
> source pci_ids.h for my card.

That's not enough. By doing this, you tell the *readers* of this header
file that there's a new vendor or device. That doesn't tell the
*drivers* that they've got a new supported device. So if you compiled-in
the correct driver and 'ifconfig -a' doesn't show it, then it seems that
the (correct) driver incorrectly doesn't know your device IDs. Add those
to the driver's PCI ID table.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/mTnMHb1edYOZ4bsRAnXtAJ49GygvMaIXlEH9rggKn08JVaYrjwCfa7X8
5/dUJb3JSh3D9TuyDEWQTaA=
=g3Nk
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
