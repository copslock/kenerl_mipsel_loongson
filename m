Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Apr 2003 01:30:36 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:22449
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8224861AbTD0Aaa>; Sun, 27 Apr 2003 01:30:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 04F7C2BC32
	for <linux-mips@linux-mips.org>; Sun, 27 Apr 2003 02:30:28 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 24450-07
 for <linux-mips@linux-mips.org>; Sun, 27 Apr 2003 02:30:26 +0200 (CEST)
Received: from bogon.sigxcpu.org (kons-d9bb54a3.pool.mediaWays.net [217.187.84.163])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 908002BC31
	for <linux-mips@linux-mips.org>; Sun, 27 Apr 2003 02:30:26 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id C423C1735D; Sun, 27 Apr 2003 02:27:25 +0200 (CEST)
Date: Sun, 27 Apr 2003 02:27:25 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: arcboot 0.3.6
Message-ID: <20030427002725.GG17621@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I've uploaded arcboot 0.3.6 (the bootloader for SGI mips machines) to=20
 http://honk.physik.uni-konstanz.de/linux-mips/arcboot/
Here are the more interesting bits from the changelog:
  * fix command line handling, now things like
        boot linux root=3D/dev/sda1 single
    should work as expected, no need to mess with OSLoadOptions
  * fix booting arbitrary files
        boot /vmlinux root=3D/dev/sda1
    will now properly boot OSLoadPartition/vmlinux
  * search for OSLoadPartition if the envvar is bogus
  * adding other 32bit IPs to arcboot is now a two line change
    in common/subarch.h
+ lots of other minor bugfixes. Is anybody really missing support for
booting IRIX? If so It be nice to have someone who's willing to test
some changes since I don't run IRIX myself.
Regards,
 -- Guido

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+qyPtn88szT8+ZCYRAsy0AJ9Z9fE+L6i5jYowKyeI996E4WUr5gCeMafC
ieEoy1OVXbCT6Cx73Q8bd50=
=6zpN
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
