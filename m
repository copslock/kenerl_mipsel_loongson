Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2003 14:18:44 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:19343 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225471AbTJXNSk>; Fri, 24 Oct 2003 14:18:40 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id A7E974A8E5; Fri, 24 Oct 2003 15:18:38 +0200 (CEST)
Date: Fri, 24 Oct 2003 15:18:38 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: configuring 2 ethernet ports
Message-ID: <20031024131838.GE12395@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <Pine.GSO.4.44.0310240905590.17395-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310240905590.17395-100000@ares.mmc.atmel.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-10-24 09:11:26 -0400, David Kesselring <dkesselr@mmc.atmel.com>
wrote in message <Pine.GSO.4.44.0310240905590.17395-100000@ares.mmc.atmel.c=
om>:
> I am trying to setup a pci wlan nic on a Malta board. I've compiled the
> driver into the kernel and I have setup

Which brand of wlan card?

> /etc/sysconfig/network-scripts/ifcfg-eth1. After boot, when I look at
> /proc/pci it looks like the system detected the card fine but ifconfig
> only shows eth0 (the builtin port). How is the pci id linked to a
> particular driver? What else do I need to do? I've scoured google but have

In 2.4.x, drivers tend to only have internal knowledge on which hardware
they work. So you need to give some 'alias eth1 wlanmodulename' in your
/etc/modules.conf file.

For 2.6.x, drivers export this table and (in theory), the hotplug
scripts *can* load a driver just upon the card showing up. However,
normally (for static network cards not handled by the hotplug API),
you'll just use the exactly same line, but in /etc/modprobe.conf.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/mSauHb1edYOZ4bsRAhd3AJ92aagsoSOcmkgXul2TyPhZt0FW4gCgiTsZ
jtpZCZ4GKUYDBEm8Rf3b5D0=
=eznI
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
