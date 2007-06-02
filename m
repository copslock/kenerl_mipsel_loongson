Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jun 2007 19:45:29 +0100 (BST)
Received: from tool.snarl.nl ([82.95.241.19]:16139 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S28575744AbXFBSp1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 2 Jun 2007 19:45:27 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 892635DFC8;
	Sat,  2 Jun 2007 20:44:51 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id P0ED9M0KYBcb; Sat,  2 Jun 2007 20:44:51 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 3083C5DF9C; Sat,  2 Jun 2007 20:44:51 +0200 (CEST)
Date:	Sat, 2 Jun 2007 20:44:51 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	saravanan sar <sar_van81@yahoo.co.in>
Cc:	linux-mips@linux-mips.org
Subject: Re: porting linux to DBau1200
Message-ID: <20070602184450.GD28306@dusktilldawn.nl>
References: <858843.6401.qm@web94308.mail.in2.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <858843.6401.qm@web94308.mail.in2.yahoo.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sar,

On Sat, Jun 02, 2007 at 07:49:01AM +0100, saravanan sar wrote:
> has anyone successfully ported linux to DBau1200 board?

I am successfully running it on the DBAu1100 board, so I am most
sure it works on the 1200 board too. No worries on that part.


> YAMON> go
[cut]
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block=
(1,0).

You might want to try an NFS mount first, before loading a root
filesystem on the Flash memory that's part of the board.

Setup a root filesystem on a workstation and export it by means
of NFS. You might want to take a look at debootstrap (Debian
GNU/Linux), but there do exist an almost infite amount of other
ways to do just that. Probably an obvious note, but I like to
make it anyway: make sure you use mipsel binaries!!

Next you start from YAMON in a way like this:

	go . ip=3D10.42.69.2 nfsroot=3D10.42.69.1:/opt/debianfs/ rw

Of course you can use any IP address you like and the
'/opt/debianfs/' is only a suggestion to where the just created
root filesystem resides on your workstation.

Good luck!


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGYbqibxf9XXlB0eERAjSBAJ98GiMhR6Szx0GYAN9U4Av2q5iP2gCg6mu/
goZxNy5pK3+6ahLwYDqD+lA=
=6zWd
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
