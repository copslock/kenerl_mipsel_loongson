Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 May 2006 09:15:54 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:57535 "HELO tool.snarl.nl")
	by ftp.linux-mips.org with SMTP id S8133394AbWECIPn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 May 2006 09:15:43 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 16FCC5E59E;
	Wed,  3 May 2006 10:15:38 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06440-06; Wed, 3 May 2006 10:15:37 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id A52815DF61; Wed,  3 May 2006 10:15:37 +0200 (CEST)
Date:	Wed, 3 May 2006 10:15:37 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	"Charles C.K.Lai" <cklai@itri.org.tw>
Cc:	linux-mips@linux-mips.org
Subject: Re: How can I use DBAu1550 UART3 instead of UART0?
Message-ID: <20060503081537.GF11097@dusktilldawn.nl>
References: <00fa01c66e5f$eb0af470$8873608c@11088002601> <20060503071608.GE11097@dusktilldawn.nl> <017c01c66e86$811e56c0$8873608c@11088002601>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xf1frN3LpSrbXX2S"
Content-Disposition: inline
In-Reply-To: <017c01c66e86$811e56c0$8873608c@11088002601>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--xf1frN3LpSrbXX2S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Charles,

I'm not sure what you try to accomplish, so I'll try to answer
your question in two ways.

On Wed, May 03, 2006 at 03:52:08PM +0800, Charles C.K.Lai wrote:
> If I'd like to build my kernel starting with UART port 3,=20
> not starting with UART port 0,=20
Do you want UART port 3 to become /dev/ttyS0 and completely
ignore the fact that your CPU has a UART port 0 and 1 too? So you
just only want to use 1 UART namely port 3 of you CPU?
If this is the case you can start fiddling around with
drivers/serial/8250_au1x00.c and also have a loog at
include/asm/mach-au1x00/au1000.h

If you just want to have your serial console on UART port 3
instead of port 0 you have to do a little bit more. First you
need to tell yamon (the bootloader I expect you to use) to use
UART port 3 instead of port 0 and then you just boot the kernel
with the console=3D option. See Documentation/kernel-parameters.txt
for more information.

Hope this will help. Otherwist try to explain a little bit more
thoroughly what you try to accomplish. Good luck!

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--xf1frN3LpSrbXX2S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEWGapbxf9XXlB0eERAvgwAKCrRSmlRwMjNnATnh0LYYXrKHkBYQCdHb0Y
mUt1yYcaMT4OJbkj0Ku7AeM=
=0pza
-----END PGP SIGNATURE-----

--xf1frN3LpSrbXX2S--
