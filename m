Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2004 11:21:40 +0000 (GMT)
Received: from shawidc-mo1.cg.shawcable.net ([IPv6:::ffff:24.71.223.10]:57180
	"EHLO pd5mo1so.prod.shaw.ca") by linux-mips.org with ESMTP
	id <S8225278AbUBJLVk>; Tue, 10 Feb 2004 11:21:40 +0000
Received: from pd4mr3so.prod.shaw.ca
 (pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
 (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0HSV00LE68W24N@l-daemon> for linux-mips@linux-mips.org; Tue,
 10 Feb 2004 04:21:38 -0700 (MST)
Received: from pn2ml1so.prod.shaw.ca
 (pn2ml1so-qfe0.prod.shaw.ca [10.0.121.145]) by l-daemon
 (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0HSV001558W2OF@l-daemon> for linux-mips@linux-mips.org; Tue,
 10 Feb 2004 04:21:38 -0700 (MST)
Received: from curie.orbis-terrarum.net
 (h24-84-49-144.vc.shawcable.net [24.84.49.144])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0HSV00I098W1CO@l-daemon> for linux-mips@linux-mips.org; Tue,
 10 Feb 2004 04:21:37 -0700 (MST)
Received: (qmail 9318 invoked by uid 10000); Tue, 10 Feb 2004 03:21:37 -0800
Date: Tue, 10 Feb 2004 03:21:37 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: SGI O2 PANIC on mem=xxxM, and strange initrd behavior
To: linux-mips <linux-mips@linux-mips.org>
Cc: Ilya Volynets <ilya@theIlya.com>
Message-id: <20040210112137.GA9213@curie-int.orbis-terrarum.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=RnlQjJ0d97Da+TV1;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.5.1i
Return-Path: <robbat2@orbis-terrarum.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robbat2@gentoo.org
Precedence: bulk
X-list: linux-mips


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've recently picked up an SGI O2, 300mhz R12k, 512Mb RAM.
Playing with getting it working, using Ilya's minimal patches on top of
the LMO CVS HEAD, I noticed that it wasn't pulling up the correct amount
of RAM. I threw mem=3D512M onto the params, and found a kernel crash.

Boots mostly fine:
http://www.orbis-terrarum.net/~robbat2/sgio2/kernel.boot
Crashes:
http://www.orbis-terrarum.net/~robbat2/sgio2/kernel.crash
Decoded:
http://www.orbis-terrarum.net/~robbat2/sgio2/decoded.panic
Kernel config:
http://www.orbis-terrarum.net/~robbat2/sgio2/kernel.config

I've also got one weird problem where it never gets any further than the
init call to my busybox initrd.

Output using an old debian netboot initrd (from debian-mips-2.4.19.img):
serial console detected.  Disabling virtual terminals.  init started:
BusyBox v0.60.3-pre (2002.01.22-06:31+0000) multi-call binary

Output for using bleeding-edge Gentoo initrd that works perfectly for
an Indy and an I2:
init started:  BusyBox v1.00-pre7 (2004.02.10-08:42+0000) multi-call binary

In both cases, right after the init message, absolutely nothing happens.
I've tried putting commands in the linuxrc that would cause some
externally visible activity, but nothing.

I am wondering if it may have to with the virtual consoles (which I had
to turn off to get any serial output), but I doubt they are the problem.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFAKL7BsnuUTjSIToURAvIFAKCpZHb3Dv9Aeic4nfOQgv7ZTfAOSwCdF7rl
hfMMBPk6oLgj1ROBzhrZKSE=
=yHpX
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
