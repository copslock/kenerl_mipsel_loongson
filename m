Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 18:18:08 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:47514
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225384AbTLISSH>; Tue, 9 Dec 2003 18:18:07 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 045362BC39
	for <linux-mips@linux-mips.org>; Tue,  9 Dec 2003 19:18:06 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 20046-06
 for <linux-mips@linux-mips.org>; Tue,  9 Dec 2003 19:17:44 +0100 (CET)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id B39102BC3C
	for <linux-mips@linux-mips.org>; Tue,  9 Dec 2003 19:17:29 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 39F5845EB; Tue,  9 Dec 2003 19:17:19 +0100 (CET)
Date: Tue, 9 Dec 2003 19:17:19 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
Message-ID: <20031209181719.GC13411@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <3FD5FE41.8040909@bitbox.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <3FD5FE41.8040909@bitbox.co.uk>
User-Agent: Mutt/1.5.4i
X-Virus-Scanned: by amavisd-new-20021227-p2 (Debian)
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,
On Tue, Dec 09, 2003 at 04:54:25PM +0000, Peter Horton wrote:
> The kernel boots okay from the HD, but I get strange segmentation faults=
=20
> and other errors whilst running Debian's "dpkg" to install packages. If=
=20
> I repeat the installation from scratch I get exactly the same errors in=
=20
> exactly the same places :-(
This has been reported several times. AFAIK 2.4.17 worked for several
people, but people who actually own the hardware will now better. It
would be a _huge_ help if somebody could track down the date in
linux-mips.org CVS where things broke exactly.
Cheers,
 -- Guido

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1hGvn88szT8+ZCYRAkjcAJ0QPE89Pylu/VjRpk0cydPtuGreHACfQtAs
f8PTURDHE/rn+gpG0ln/6e4=
=INm3
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
