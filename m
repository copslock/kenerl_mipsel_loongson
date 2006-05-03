Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 May 2006 08:16:26 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:51135 "HELO tool.snarl.nl")
	by ftp.linux-mips.org with SMTP id S8133394AbWECHQR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 May 2006 08:16:17 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 62D2A5E59E;
	Wed,  3 May 2006 09:16:11 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 19933-01; Wed, 3 May 2006 09:16:09 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id D19085DF61; Wed,  3 May 2006 09:16:08 +0200 (CEST)
Date:	Wed, 3 May 2006 09:16:08 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	"Charles C.K.Lai" <cklai@itri.org.tw>
Cc:	linux-mips@linux-mips.org
Subject: Re: How can I use DBAu1550 UART3 instead of UART0?
Message-ID: <20060503071608.GE11097@dusktilldawn.nl>
References: <00fa01c66e5f$eb0af470$8873608c@11088002601>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9nxfG+mZwdJSiAE"
Content-Disposition: inline
In-Reply-To: <00fa01c66e5f$eb0af470$8873608c@11088002601>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--/9nxfG+mZwdJSiAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Charles,

On Wed, May 03, 2006 at 11:16:01AM +0800, Charles C.K.Lai wrote:
> I have a AMD DBAu1550 Development board,=20
> if I have to use the uart port 3 instead of uart port 0,=20
> what can I do?=20
Using /dev/ttyS3 instead of /dev/ttyS0 might be the thing to do.
Do you see both ports get detected during boot ($ dmesg)? That
should give you a clue.

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--/9nxfG+mZwdJSiAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEWFi4bxf9XXlB0eERAo9kAJ9jfFtXGowmcAqRcb+TSgFbZCsX5wCg8Ebv
b1U6C6LvWIa5nsZnjeUIPRQ=
=BOVX
-----END PGP SIGNATURE-----

--/9nxfG+mZwdJSiAE--
