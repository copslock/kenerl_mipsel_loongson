Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2006 08:18:38 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:23267 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S8133349AbWGRHS2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2006 08:18:28 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id CA92A5DFB3;
	Tue, 18 Jul 2006 09:18:19 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YtxDHEdGdTmV; Tue, 18 Jul 2006 09:18:19 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 6FEAA5DF86; Tue, 18 Jul 2006 09:18:19 +0200 (CEST)
Date:	Tue, 18 Jul 2006 09:18:19 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	hemanth.venkatesh@wipro.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Mounting rootfs from Alchemy Flash fails
Message-ID: <20060718071819.GW5162@dusktilldawn.nl>
References: <2156B1E923F1A147AABDF4D9FDEAB4CB09D11E@blr-m2-msg.wipro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nqu5fpgjE+BQlEdo"
Content-Disposition: inline
In-Reply-To: <2156B1E923F1A147AABDF4D9FDEAB4CB09D11E@blr-m2-msg.wipro.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--nqu5fpgjE+BQlEdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hemanth,

On Tue, Jul 18, 2006 at 10:47:16AM +0530, hemanth.venkatesh@wipro.com wrote:
> We have updated Alchamy-flash.c  to specify  flash size 32 MB
> and physical address as 0X1E000000.

Isn't 32MB the default in 2.6.14 for the DB1100 board? If I
memorized it correctly you don't have to update anything. It
should work out of the box, since the DB1100 comes standard with
32MB flash.


> We found that probe function is failing and vendor command set
> is not found, log attached below. Any inputs for resolving the
> problem are appreciated.

Have you checked dip-switch S5? Both switches should be on (white
switches both near the 1 and 2 instead of the text cts-2)


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--nqu5fpgjE+BQlEdo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEvIs7bxf9XXlB0eERAgB/AJ9Td9xi+HL1d4Go2clI2sifDc7Q2gCgzbrd
Nt1A4YtljqEX1nDMqBjGZGE=
=MHsw
-----END PGP SIGNATURE-----

--nqu5fpgjE+BQlEdo--
