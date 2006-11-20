Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2006 14:18:21 +0000 (GMT)
Received: from tool.snarl.nl ([213.84.251.124]:18830 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20038759AbWKTOSN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Nov 2006 14:18:13 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id AD4095E00E
	for <linux-mips@linux-mips.org>; Mon, 20 Nov 2006 15:18:07 +0100 (CET)
X-Quarantine-ID: <nxjF7iXQxzgs>
X-Amavis-Alert:	BAD HEADER MIME error: error: part did not end with expected
	boundary
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nxjF7iXQxzgs for <linux-mips@linux-mips.org>;
	Mon, 20 Nov 2006 15:18:06 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 7724F5DF3D; Mon, 20 Nov 2006 15:18:06 +0100 (CET)
Resent-From: freddy@dusktilldawn.nl
Resent-Date: Mon, 20 Nov 2006 15:18:06 +0100
Resent-Message-ID: <20061120141806.GH32045@dusktilldawn.nl>
Resent-To: linux-mips@linux-mips.org
Date:	Mon, 20 Nov 2006 15:16:07 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: au1xmmc.c: does it work?
Message-ID: <20061120141607.GG32045@dusktilldawn.nl>
References: <20061120094053.GA13509@roarinelk.homelinux.net> <20061120104922.GC32045@dusktilldawn.nl> <20061120120148.GA13740@roarinelk.homelinux.net> <20061120123740.GE32045@dusktilldawn.nl> <20061120132226.GB13740@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Content-Disposition: inline
In-Reply-To: <20061120132226.GB13740@roarinelk.homelinux.net>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips

ntent-Length: 1585
Lines: 52


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

On Mon, Nov 20, 2006 at 02:22:26PM +0100, Manuel Lauss wrote:
> > Broke in a different way?
>=20
> continuously issues CMD2 and CMD3 messages to the card, and
> lots of "au1xx(0): DEBUG: PENDING - 03000090" messages.

I now too see those PENDING messages, which I failed to notice
more early. Actually I have tried this patch last friday for the
first time and since it worked right away did not notice all
those messages.


> You only removed parts of the Db/Pb board specific stuff and
> disabled DMA, correct?

I did not wrote the patch myself, so I can't tell you without
seriously looking into it myself. As far as I know your statement
should be correct, but only carefull looking into it will provide
the true answer. And that's where I do not have time for right
now. I should not even be writing this email I guess. :)

Good luck!


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFYbinbxf9XXlB0eERAo/yAJoDQEY45xceTnf/oyRP5ltKuoIsiwCg9sJK
/RANsTrznfcDoWbRLPUVS9g=
=qIP0
-----END PGP SIGNATU
