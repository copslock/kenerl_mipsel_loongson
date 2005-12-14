Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2005 13:46:20 +0000 (GMT)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:15831 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133589AbVLNNqD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Dec 2005 13:46:03 +0000
Received: from hulk.enneenne.com
	([192.168.32.38] helo=localhost.localdomain ident=Debian-exim)
	by goldrake.enneenne.com with esmtp (Exim 4.54)
	id 1EmWbc-00080f-5O; Wed, 14 Dec 2005 14:27:25 +0100
Received: from giometti by localhost.localdomain with local (Exim 4.54)
	id 1EmWt1-0001Fm-4p; Wed, 14 Dec 2005 14:41:39 +0100
Date:	Wed, 14 Dec 2005 14:41:39 +0100
From:	Rodolfo Giometti <giometti@linux.it>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org
Message-ID: <20051214134139.GN22061@hulk.enneenne.com>
References: <20051202190108.GF28227@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G+DT6X5ssgZ56VG3"
Content-Disposition: inline
In-Reply-To: <20051202190108.GF28227@cosmic.amd.com>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 192.168.32.38
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: [PATCH] ALCHEMY:  Add SD support to AU1200 MMC/SD driver
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: No (on goldrake.enneenne.com); Unknown failure
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--G+DT6X5ssgZ56VG3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2005 at 12:01:08PM -0700, Jordan Crouse wrote:
> Add SD support to the AU1200 MMC driver.  This can
> be added post 2.6.15, I'm just sending them out today so the various
> maintainers can get them queued up.=20

According to AMD Application Note titled "MultiMediaCard Support Using
the AMD Alchemy Au1200 and Au1100 Processors" I'd like to test your
driver on my Au1100 based board.

Can you please told me the Linux kernel version where the patch apply
to?

Do you think there should be some issue to keep in consideration
regarding the Au1100?

Thanks in advance,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--G+DT6X5ssgZ56VG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDoCETQaTCYNJaVjMRAjl7AKCvljANJqJc7oBx0fNHn93KH/G+OgCeLTC6
i7V30tiXdsFlnUtD9Qz7DNM=
=MkPw
-----END PGP SIGNATURE-----

--G+DT6X5ssgZ56VG3--
