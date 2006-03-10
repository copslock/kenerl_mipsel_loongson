Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2006 05:06:38 +0000 (GMT)
Received: from pops.net-conex.com ([204.244.176.3]:6053 "EHLO
	mail.net-conex.com") by ftp.linux-mips.org with ESMTP
	id S8133429AbWCJFG2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Mar 2006 05:06:28 +0000
Received: from orbis-terrarum.net (S01060050da688d47.vc.shawcable.net [24.80.100.253])
	by mail.net-conex.com (8.13.4/8.12.11) with ESMTP id k2A5F6d8024059
	for <linux-mips@linux-mips.org>; Thu, 9 Mar 2006 21:15:07 -0800
Received: (qmail 4417 invoked by uid 10000); 9 Mar 2006 21:15:10 -0800
Date:	Thu, 9 Mar 2006 21:15:10 -0800
From:	"Robin H. Johnson" <robbat2@orbis-terrarum.net>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IDT Interprise Processor Support for Linux  2.6.x
Message-ID: <20060310051510.GB16755@curie-int.vc.shawcable.net>
Mail-Followup-To: linux-mips@linux-mips.org
References: <73943A6B3BEAA1468EE1A4A090129F4316B15A73@corpbridge.corp.idt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <73943A6B3BEAA1468EE1A4A090129F4316B15A73@corpbridge.corp.idt.com>
User-Agent: Mutt/1.5.11
Return-Path: <robbat2@orbis-terrarum.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robbat2@orbis-terrarum.net
Precedence: bulk
X-list: linux-mips


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2006 at 05:08:49PM -0800, Tiwari, Rakesh wrote:
> The attached patch adds support for the IDT Interprise series of processo=
r=20
> based on the MIPS 4KC and Cronus (RC32300) core.
I'm not Ralf, but I gave your patch a quick once-over anyway for the
hell of it.

I see a lot of duplicated code, esp in arch/mips/idt-boards and the
network drivers.

Is it possible to have a kernel capable of booting on all IDT boards?
Could such a kernel detect what board it's actually running on - or
enough elements of the board configuration to provide more generic
drivers?

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFEEQtePpIsIjIzwiwRAuOOAJ4+amrbfm/L/hynW5SCqLvRLdLXfACg7EoZ
hlD2QgVnrMPdI7RVN1mdIS4=
=djnu
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
