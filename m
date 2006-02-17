Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 18:18:40 +0000 (GMT)
Received: from tool.snarl.nl ([213.84.251.124]:53668 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S8133718AbWBQSSa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 18:18:30 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id BA1F75DF5B;
	Fri, 17 Feb 2006 19:25:10 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30825-04-2; Fri, 17 Feb 2006 19:25:10 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 620AB5DF4D; Fri, 17 Feb 2006 19:25:10 +0100 (CET)
Date:	Fri, 17 Feb 2006 19:25:10 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Small time UART configuration fix for AU1100 processor
Message-ID: <20060217182510.GG14066@dusktilldawn.nl>
References: <20060217145406.GE14066@dusktilldawn.nl> <20060217172447.GA30429@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <20060217172447.GA30429@cosmic.amd.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jordan,

On Fri, Feb 17, 2006 at 10:24:47AM -0700, Jordan Crouse wrote:
> I think that Ralf already told you to send it to Russell King,
> but I'll toss it in my tree as well, in case he doesn't get it.
I have already send it to Russell yes, so...

> The comment probably isn't required, though - just remove it.
=2E..no chance to remove the comment anymore. Well, it actually
does not hurt that much (IMHO) and saves newbies like me some
searching. :-)

> I know this is a stupid question for an AMD employee to ask, but since
> I've only been associated with the AU1200, and to a limited extent the AU=
1550,
> do *ANY* of our boards have an UART2 on them?
Unfortunately I have no idea. I'm fairly new (two weeks actually)
to this architecture and the AU1100 is the only AMD board I have
access to. Sorry.

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl> http://snarl.nl/~freddy/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9hUGbxf9XXlB0eERAtrtAKCfQg7NTI2l38WCcPmzuB0np6EMmACeL4PK
YlxrLO0xkUleXxcykk7mw4g=
=lxuP
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
