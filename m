Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 10:47:42 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:27362 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20038526AbWI2Jrk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2006 10:47:40 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 16B465DF7F;
	Fri, 29 Sep 2006 11:47:30 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id euaHksNAESym; Fri, 29 Sep 2006 11:47:29 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id A6B035DF06; Fri, 29 Sep 2006 11:47:29 +0200 (CEST)
Date:	Fri, 29 Sep 2006 11:47:29 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	David Lee <receive4me@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: HELP: opcode not supported on this processor
Message-ID: <20060929094729.GM17027@dusktilldawn.nl>
References: <5ee285ba0609290235v7b518495u2dccb1ef82b117d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vTfKKTivj/mQoluA"
Content-Disposition: inline
In-Reply-To: <5ee285ba0609290235v7b518495u2dccb1ef82b117d0@mail.gmail.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--vTfKKTivj/mQoluA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Sep 29, 2006 at 05:35:48PM +0800, David Lee wrote:
> /tmp/ccwOZSG3.s:5143: Error: opcode not supported on this processor: mips1
> (mips1) `ll $4,16($2)'
> /tmp/ccwOZSG3.s:5145: Error: opcode not supported on this processor: mips1
> (mips1) `sc $4,16($2)'

Are you sure you want to assemble for the mips1 target?

I know these both opcodes are valid MIPS32 opcodes, but don't
know if they exist for the mips1 target.

You might want to look for something like

	http://www.cs.cornell.edu/courses/cs314/2005FA/resources/MIPS_Vol2.pdf

but this one is for MIPS32. If you need mips1 you better search
for a likewise document.


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--vTfKKTivj/mQoluA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFHOuxbxf9XXlB0eERAjTjAKCisVWs1p8ViEDGQnWexpfoQ6c3kACgxn/y
GRv42zeXJWfW62Iy6eC54dI=
=I9OS
-----END PGP SIGNATURE-----

--vTfKKTivj/mQoluA--
