Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Apr 2004 17:22:09 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:32431
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225789AbUDDQWI>; Sun, 4 Apr 2004 17:22:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id AB8FE2BC42; Sun,  4 Apr 2004 18:22:07 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 17695-06; Sun, 4 Apr 2004 18:22:02 +0200 (CEST)
Received: from bogon.sigxcpu.org (xdsl-213-196-194-203.netcologne.de [213.196.194.203])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id D79982BC48; Sun,  4 Apr 2004 18:21:39 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 0250B4092; Sun,  4 Apr 2004 17:50:10 +0200 (CEST)
Date: Sun, 4 Apr 2004 17:50:10 +0200
From: Guido Guenther <agx@debian.org>
To: debian-mips@lists.debian.org, linux-mips@linux-mips.org
Cc: Karsten Merker <karsten@excalibur.cologne.de>
Subject: Re: Kernel vs. glibc problems
Message-ID: <20040404155010.GA1975@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@debian.org>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org,
	Karsten Merker <karsten@excalibur.cologne.de>
References: <20040404115212.GA22445@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20040404115212.GA22445@excalibur.cologne.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at honk.physik.uni-konstanz.de
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@debian.org
Precedence: bulk
X-list: linux-mips


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 04, 2004 at 01:52:12PM +0200, Karsten Merker wrote:
> On a DECstation 5000/20, having an R3000, the following combinations work:
> - Debian 2.4.19 plus Debian/Woody glibc (2.2.5)
> - Debian 2.4.19 plus Debian/Sarge glibc (2.3.2)
> - CVS 2.4.25 from 2004/03/25 plus Debian/Woody glibc (2.2.5)
> But running the same CVS 2.4.25 with the Debian/Sarge glibc (2.3.2)
> causes (at least) ls, sleep and tar to die with "illegal instruction".
What is the illegal instruction? Gdb should tell.
Cheers,
 -- Guido

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcC6yn88szT8+ZCYRAsWHAJwNBlVrPqOIq411ILBAJxax8ej+lwCdE/8i
GdFVRbK+wS6ZdNfgmhR6fac=
=riat
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
