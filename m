Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 09:03:01 +0200 (CEST)
Received: from tool.snarl.nl ([213.84.251.124]:60052 "HELO tool.snarl.nl")
	by ftp.linux-mips.org with SMTP id S8133463AbWEaHCw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 09:02:52 +0200
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 33C445E4DA;
	Wed, 31 May 2006 09:02:46 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id baAxqqRmHVEP; Wed, 31 May 2006 09:02:45 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id D8FE05DF5C; Wed, 31 May 2006 09:02:45 +0200 (CEST)
Date:	Wed, 31 May 2006 09:02:45 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Bin Chen <binary.chen@gmail.com>
Cc:	zhuzhenhua <zzh.hust@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: how to disable interrupt in application?
Message-ID: <20060531070245.GG19451@dusktilldawn.nl>
References: <50c9a2250605301733t788c16f9k739c17e4a6a4efee@mail.gmail.com> <5800c1cc0605302311p2d1f024bm96ac6e08cda1bc2f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
Content-Disposition: inline
In-Reply-To: <5800c1cc0605302311p2d1f024bm96ac6e08cda1bc2f@mail.gmail.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 31, 2006 at 02:11:00PM +0800, Bin Chen wrote:
> On 5/31/06, zhuzhenhua <zzh.hust@gmail.com> wrote:
> >our project have a video decoder code run as application. there is
> >some short code want to be run uninterruptable. is there anyway to do
> >it?
> man sigprocmask
This way you can mask signals, but AFAIK your process is still
interruptable. What if the kernel scheduler decides another
process deserves some running time? Not something you can
suppress, if I'm correct.

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEfT+Vbxf9XXlB0eERAjbgAKCdA5etQu1zsNVjXYIWTR+i8JN9/QCaAxgb
Gis/rVp4W421er1CbXcP+gg=
=FXZf
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--
