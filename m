Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2006 15:16:23 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:54693 "HELO tool.snarl.nl")
	by ftp.linux-mips.org with SMTP id S8133547AbWDTOQO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2006 15:16:14 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 6E1C35E58B;
	Thu, 20 Apr 2006 16:28:49 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 25788-01; Thu, 20 Apr 2006 16:28:48 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 89FC05DF5C; Thu, 20 Apr 2006 16:28:47 +0200 (CEST)
Date:	Thu, 20 Apr 2006 16:28:47 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Jon Anders Haugum <jonah@omegav.ntnu.no>
Cc:	Domen Puncer <domen.puncer@ultra.si>, linux-mips@linux-mips.org
Subject: Re: UART trouble on the DBAu1100
Message-ID: <20060420142847.GR11097@dusktilldawn.nl>
References: <20060413131117.GP11097@dusktilldawn.nl> <20060414060640.GE29489@domen.ultra.si> <20060420145753.C1601@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b//ZgE2eAae+kIBt"
Content-Disposition: inline
In-Reply-To: <20060420145753.C1601@invalid.ed.ntnu.no>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--b//ZgE2eAae+kIBt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Thu, Apr 20, 2006 at 03:11:34PM +0200, Jon Anders Haugum wrote:
> On Fri, 14 Apr 2006, Domen Puncer wrote:
> > On 13/04/06 15:11 +0200, Freddy Spierenburg wrote:
> > > All the received bytes stay in the input buffer of the UART
> > > only to be send up to userland as soon as the UART is asked
> > > to send a byte on the line itself.
> >=20
> > I may be way off, but maybe it's just flow control that needs
> > to be turned off.
>=20
> If this is uart 0, it's probably a problem with that uart having irq=20
> number 0. Which in the 8250 driver is interpreted as no interrupt.
No, it was actually all caused by the incorrect usage of the
non standard Au1x00 divisor latch. When I applied your patch all
worked and I was once again a happy man.

Thanks for the work!

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--b//ZgE2eAae+kIBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFER5qfbxf9XXlB0eERAv9cAKCbYr56WZPdjoEYAZqK4EO9iNjYewCg7Vro
CQmXGOPt7JhPrVkMFkEPHbo=
=64t0
-----END PGP SIGNATURE-----

--b//ZgE2eAae+kIBt--
