Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 16:44:39 +0100 (BST)
Received: from tool.snarl.nl ([82.95.241.19]:15629 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20022150AbXHGPoS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2007 16:44:18 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id D0CBE5E1DA;
	Tue,  7 Aug 2007 17:43:42 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iKaSeLnTeL91; Tue,  7 Aug 2007 17:43:42 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 59AFB5DFA1; Tue,  7 Aug 2007 17:43:42 +0200 (CEST)
Date:	Tue, 7 Aug 2007 17:43:42 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: ELF to S-Record convertor
Message-ID: <20070807154342.GX4004@dusktilldawn.nl>
References: <40378e40708070832g1aa613fcg7e486d0d778bb84f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HLiOwqdVwqQciAhA"
Content-Disposition: inline
In-Reply-To: <40378e40708070832g1aa613fcg7e486d0d778bb84f@mail.gmail.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--HLiOwqdVwqQciAhA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mohamed,

On Tue, Aug 07, 2007 at 05:32:00PM +0200, Mohamed Bamakhrama wrote:
> Does anyone know of any open source tool for converting ELF images to
> S-Record images?

Have you already looked into objcopy?


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--HLiOwqdVwqQciAhA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGuJMtbxf9XXlB0eERAnbTAKC4FEldLlOkuo0LFOyft3Wp9K/XfACg1M8X
ZuWxEPFiB9yaSjdUME0zURE=
=1tvw
-----END PGP SIGNATURE-----

--HLiOwqdVwqQciAhA--
