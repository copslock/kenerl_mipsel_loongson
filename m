Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Dec 2002 12:48:27 +0000 (GMT)
Received: from mail.winnegan.de ([IPv6:::ffff:217.89.86.2]:47364 "EHLO
	mail.winnegan.de") by linux-mips.org with ESMTP id <S8225514AbSLYMs0>;
	Wed, 25 Dec 2002 12:48:26 +0000
Received: from keuner.winnegan.fake (unknown [192.168.53.67])
	by mail.winnegan.de (Postfix) with ESMTP id 14E4C13906
	for <linux-mips@linux-mips.org>; Wed, 25 Dec 2002 11:19:38 +0100 (CET)
Received: from bsb by keuner.winnegan.fake with local (Exim 3.36 #1 (Debian))
	id 18R8dW-0004QS-00
	for <linux-mips@linux-mips.org>; Wed, 25 Dec 2002 11:19:38 +0100
Date: Wed, 25 Dec 2002 11:19:38 +0100
To: linux-mips@linux-mips.org
Subject: Re: mips dvhtool
Message-ID: <20021225101938.GA7628@keuner.winnegan.fake>
Mail-Followup-To: linux-mips@linux-mips.org
References: <000701c2abbe$fa72aaf0$0a01a8c0@sohotower>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <000701c2abbe$fa72aaf0$0a01a8c0@sohotower>
User-Agent: Mutt/1.4i
From: Siggy Brentrup <bsb@winnegan.de>
Return-Path: <bsb@winnegan.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bsb@winnegan.de
Precedence: bulk
X-list: linux-mips


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 24, 2002 at 06:40:24PM -0800, Robert Rusek wrote:
> Can someone please direct me to where I can find the source or the rpm
> of the mips dvhtool package?

Quoting README.Debian:

  dvhtool for Debian
  ----------------------

  You can check out the original source from oss.sgi.com's cvs archive (password cvs):
  cvs -d:pserver:cvs@oss.sgi.com:/cvs login
  cvs -d:pserver:cvs@oss.sgi.com:/cvs dvhtool

   -- Guido Guenther <agx@debian.org>, Tue, 17 Oct 2000 00:14:57 +0200

Obviously the checkout command is missing on the 2nd cvs line.

 * Siggy

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+CYY694B/SGO8KQcRAoqTAKCSC00X8aDpxvY4RHnpgyx9iZwOjwCgvVpn
wV0waNEymEbo4kB/6uJyBss=
=OUEt
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
