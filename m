Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2006 08:42:45 +0000 (GMT)
Received: from tool.snarl.nl ([213.84.251.124]:61093 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S8133464AbWBRImf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Feb 2006 08:42:35 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id D36235E01F;
	Sat, 18 Feb 2006 09:49:18 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05168-01; Sat, 18 Feb 2006 09:49:17 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 7415F5DF5B; Sat, 18 Feb 2006 09:49:16 +0100 (CET)
Date:	Sat, 18 Feb 2006 09:49:16 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: replaced io_remap_page_range() with io_remap_pfn_range()
Message-ID: <20060218084916.GJ14066@dusktilldawn.nl>
References: <20060217145352.GD14066@dusktilldawn.nl> <20060217173448.GB30429@cosmic.amd.com> <20060217183155.GH14066@dusktilldawn.nl> <20060217200944.GF30429@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+Rs1qz93vBJxC1z"
Content-Disposition: inline
In-Reply-To: <20060217200944.GF30429@cosmic.amd.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--R+Rs1qz93vBJxC1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jordan,

On Fri, Feb 17, 2006 at 01:09:44PM -0700, Jordan Crouse wrote:
> I'm looking at the lmo tree right now, and its very definately
> fixed at au1200fb.c:1280.
You are right when you say that au1200fb.c is fixed.That one was
fixed in all my source too. But I'm talking about au1100fb.c,
which was probably forgotten. Maybe I should have stated that in
my email, that it's about au1100fb.c. Sorry for the confusion!

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl> http://snarl.nl/~freddy/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--R+Rs1qz93vBJxC1z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9t+Mbxf9XXlB0eERAhvzAKDeWTvIoZ1o0PJ8O3nlUWqM83i+4wCbBijc
ge9KyUxw/6Q87jzE0bb3JDI=
=o3+a
-----END PGP SIGNATURE-----

--R+Rs1qz93vBJxC1z--
