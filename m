Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2003 00:06:35 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:14219
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8224802AbTF2XGc>; Mon, 30 Jun 2003 00:06:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 2B9512BC41; Mon, 30 Jun 2003 01:06:30 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 05228-03;
 Mon, 30 Jun 2003 01:06:27 +0200 (CEST)
Received: from bogon.sigxcpu.org (kons-d9bb55c2.pool.mediaWays.net [217.187.85.194])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 43ED92BC36; Mon, 30 Jun 2003 01:06:27 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 9F95F1737D; Mon, 30 Jun 2003 01:05:46 +0200 (CEST)
Date: Mon, 30 Jun 2003 01:05:46 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Achim Hensel <achim.hensel@ruhr-uni-bochum.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Which toolchain? Trouble at kernel-starting
Message-ID: <20030629230546.GA10792@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Achim Hensel <achim.hensel@ruhr-uni-bochum.de>,
	linux-mips@linux-mips.org
References: <20030629211136.23809a06.achim.hensel@ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20030629211136.23809a06.achim.hensel@ruhr-uni-bochum.de>
User-Agent: Mutt/1.5.4i
X-Virus-Scanned: by amavisd-new-20021227-p2 (Debian)
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 29, 2003 at 09:11:36PM +0200, Achim Hensel wrote:
> I want to start some work for the Indigo1 (IP20). So, I need a working
> kernel.
Several people worked on IP20 already. Maybe it's easier to start from
their work.

> Does anybody have some idea, which toolchain/kernel source was used for
> the debian tftp boot installer image?
apt-get source kernel-patch-2.4.19-mips
with Debian's GCC 2.95.4 and binutils about 2.12.90.0.1.
 -- Guido

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/3DKn88szT8+ZCYRAiR+AJ9/fpV06ah4NLEVOUSeDqaTajWQqACfQ8HB
JFWksbpFHUF6pw+HHuDxsvw=
=2jeM
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
