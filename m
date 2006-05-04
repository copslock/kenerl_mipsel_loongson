Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 11:12:56 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:5058 "HELO tool.snarl.nl")
	by ftp.linux-mips.org with SMTP id S8133713AbWEDKMk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 May 2006 11:12:40 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 356125E5B2;
	Thu,  4 May 2006 12:12:34 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 09015-01-2; Thu, 4 May 2006 12:12:33 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id D28865DF61; Thu,  4 May 2006 12:12:33 +0200 (CEST)
Date:	Thu, 4 May 2006 12:12:33 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	safiudeen Ts <safiudeen@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux-2.6.16 on DB1100
Message-ID: <20060504101233.GJ11097@dusktilldawn.nl>
References: <20060504065657.GI11097@dusktilldawn.nl> <BAY18-F5B011E1AD8FC316E77126ADB40@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2RPQY0WN3yNjQaZ"
Content-Disposition: inline
In-Reply-To: <BAY18-F5B011E1AD8FC316E77126ADB40@phx.gbl>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--p2RPQY0WN3yNjQaZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Safiudeen,

On Thu, May 04, 2006 at 09:10:34AM +0000, safiudeen Ts wrote:
> please tell me wether I should apply any patches to this Linux-2.6.16=20
> kernel to make it works with db1100
There do not exist patches that will help you with your problem.
I do not know at the moment what exactly goes wrong, but I have a
2.6.16 kernel running on a db1100 without your problems. There do
exist some small problems with the standard 2.6.16 git, but they
are not related to your problem (IMHO).

To help you out a bit I have put a minimal working kernel at

	http://snarl.nl/~freddy/misc/mips.linux-2.6.16-minimal/

Try the srec file and see what happens. Use the YAMON commands
below, althought I tried your command's too and it booted.
Althought it gave a kernel panic, since it was obviously not able
to mount a root partition. This is because your command (the
start environment variable in YAMON) is not compatible with the
setup I have over here.

	YAMON> load tftp://192.168.0.5/vmlinux-2.6.16-minimal.srec
	YAMON> go .

If this works for you, you can find at the URL mentioned above
the config file I used to build the kernel and that should
provide you with a starting point to continue exploring the
system.
At that same URL are two small patches that should solve the
small problems with the standard 2.6.16 git I mentioned before.

Good luck!

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--p2RPQY0WN3yNjQaZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEWdORbxf9XXlB0eERAuRRAKCLnQ6atPzajVM4qEop1OijmceQ8ACeO/hN
XWtLRIi9+CfaddBVzh81BAU=
=pwAj
-----END PGP SIGNATURE-----

--p2RPQY0WN3yNjQaZ--
