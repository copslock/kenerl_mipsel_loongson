Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Sep 2004 09:55:21 +0100 (BST)
Received: from shawidc-mo1.cg.shawcable.net ([IPv6:::ffff:24.71.223.10]:56636
	"EHLO pd3mo1so.prod.shaw.ca") by linux-mips.org with ESMTP
	id <S8224924AbUI0IzO>; Mon, 27 Sep 2004 09:55:14 +0100
Received: from pd4mr2so.prod.shaw.ca
 (pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0I4O008HWZFZ5LB0@l-daemon> for linux-mips@linux-mips.org; Mon,
 27 Sep 2004 02:55:11 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
 by pd4mr2so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0I4O005F4ZFZ8V00@pd4mr2so.prod.shaw.ca> for
 linux-mips@linux-mips.org; Mon, 27 Sep 2004 02:55:11 -0600 (MDT)
Received: from curie.orbis-terrarum.net
 (S01060050da688d47.vc.shawcable.net [24.80.109.92])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0I4O00E9QZFYOK@l-daemon> for linux-mips@linux-mips.org; Mon,
 27 Sep 2004 02:55:11 -0600 (MDT)
Received: (qmail 17900 invoked by uid 10000); Mon, 27 Sep 2004 01:55:10 -0700
Date: Mon, 27 Sep 2004 01:55:10 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: 2.6 kernel work for XXS1500
To: linux-mips@linux-mips.org
Mail-followup-to: linux-mips@linux-mips.org
Message-id: <20040927085510.GD10739@curie-int.orbis-terrarum.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=oJ71EGRlYNjSvfq7;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6i
Return-Path: <robbat2@orbis-terrarum.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robbat2@gentoo.org
Precedence: bulk
X-list: linux-mips


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a general announcement of some work being done to update XXS1500
support to a 2.6 kernel level. Testers welcome.

This isn't ready for CVS inclusion yet, still needs more testing and
validation, but to stop the hordes of people emailing me about it (Hi
Marcel), here it is being publicly announced:
http://dev.gentoo.org/~robbat2/xxs1500/linux-xxs1500-20040927.patch-dangero=
us.gz
Applies against latest CVS.

Contains:
- Kconfig stuff for the BCM5222 Dual PHY.
- XXS1500 PCI IRQ stuff
- MTD access to the onboard flash (Pete's code)
- Kconfig stuff for MTD flash
- drivers/pcmcia/au1000_generic.c: cleanup debug code
- drivers/pcmcia/au1000_xxs1500.c: port to 2.6
- Move include/asm-mips/xxs1500.h to include/asm-mips/mach-xxs1500/xxs1500.h

No warranty on it, I don't trust my PCMCIA code entirely yet.

=46rom the original codebase:
a) au_writel((au_readl(GPIO2_PINSTATE) & ~(1<<14))|(1<<30), GPIO2_OUTPUT);
b) au_writel((au_readl(GPIO2_PINSTATE) | (1<<14))|(1<<30), GPIO2_OUTPUT);

The 1<<14 indicates a specific location to set, and the 1<<30 says to
enable output on that location.
In arch/mips/au1000/xxs1500/board_setup.c, snippet a is commented as
'turn off power'.
In drivers/pcmcia/au1000_xxs1500.c, snippet a is commented as 'turn on
power', and snippet b is commented as 'turn off power'.

Your guess is as good as mine as to which does what.

I've replaced them with two macros:
XXS1500_GPIO2_PCMCIA_POWER_ON
XXS1500_GPIO2_PCMCIA_POWER_OFF

Due to the number of times they occur.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFBV9VuPpIsIjIzwiwRAsRXAJ4yH+A5Y+0eI3WOtn0GwJF7EcqcEgCfWwcE
a/A0S1RbZB9TfOR48i2pM5A=
=w81n
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
