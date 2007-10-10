Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 11:23:57 +0100 (BST)
Received: from tool.snarl.nl ([82.95.241.19]:31755 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20021989AbXJJKXt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2007 11:23:49 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id E39495E1E6;
	Wed, 10 Oct 2007 12:23:42 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SuFaY+teJ+u8; Wed, 10 Oct 2007 12:23:42 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 293365DFD5; Wed, 10 Oct 2007 12:23:42 +0200 (CEST)
Date:	Wed, 10 Oct 2007 12:23:42 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	kaka <share.kt@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: cross compiling kernel image for MIPS platform in Linux Intel
	box
Message-ID: <20071010102341.GN22574@dusktilldawn.nl>
References: <eea8a9c90710100301k391adf0bt6b6ff4f5803b0ecd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+2GlJm56SCtLHYlr"
Content-Disposition: inline
In-Reply-To: <eea8a9c90710100301k391adf0bt6b6ff4f5803b0ecd@mail.gmail.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--+2GlJm56SCtLHYlr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kaka,

On Wed, Oct 10, 2007 at 03:31:34PM +0530, kaka wrote:
> 1.  Could not load vmlinuz:I/O error

This can be a problem of all kind. Please be more specific. How
do you load the image? What is your environment? For instance, an
objcopy step is needed for loading with yamon. Because yamon
needs an srec file to load.


> 2. The size of the image is huge.

Try to use modules.


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--+2GlJm56SCtLHYlr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHDKgtbxf9XXlB0eERAmLmAKCZ9tkIHPyejsUb4Jk3YzUFRT9VbgCg5hhA
f06IUdlU2V87B7EwDVCrz4U=
=Hh7b
-----END PGP SIGNATURE-----

--+2GlJm56SCtLHYlr--
