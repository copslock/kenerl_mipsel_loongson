Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 16:25:26 +0100 (BST)
Received: from tool.snarl.nl ([82.95.241.19]:6161 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20027193AbXFGPZX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2007 16:25:23 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 91DFF5DFB2;
	Thu,  7 Jun 2007 17:25:17 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nXwd62cIA8h9; Thu,  7 Jun 2007 17:25:17 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 35C825DF94; Thu,  7 Jun 2007 17:25:17 +0200 (CEST)
Date:	Thu, 7 Jun 2007 17:25:17 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	saravanan <sar_van81@yahoo.co.in>
Cc:	linux-mips@linux-mips.org
Subject: Re: porting linux to DBau1200
Message-ID: <20070607152516.GD25907@dusktilldawn.nl>
References: <20070602184450.GD28306@dusktilldawn.nl> <687058.36765.qm@web94311.mail.in2.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <687058.36765.qm@web94311.mail.in2.yahoo.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Saravanan,

On Wed, Jun 06, 2007 at 12:19:41PM +0100, saravanan wrote:
> can you say me to create a simple rootfilesystem for MIPS?

Like I say'd in my previous email, have a look at debootstrap:

	http://packages.debian.org/stable/admin/debootstrap

It's a very easy and fast way to create a simple filesystem.

Good luck!


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGaCNcbxf9XXlB0eERAnBYAKCWEKzAKz4EarmCpvmqJ3jAuNuBVwCglpn4
2I9z2o513c8Dlxa+Tf4ytOQ=
=savZ
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
