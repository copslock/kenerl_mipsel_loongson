Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 22:32:47 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:35786
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8225439AbVBBWcb>; Wed, 2 Feb 2005 22:32:31 +0000
Received: from iria.infostations.net (iria.infostations.net [71.4.40.31])
	by mail-relay.infostations.net (Postfix) with ESMTP id 13CCE9F86C;
	Wed,  2 Feb 2005 14:32:50 -0800 (PST)
Received: from host-69-19-150-206.rev.o1.com ([69.19.150.206])
	by iria.infostations.net with esmtp (Exim 4.41 #1)
	id 1CwT3a-00086X-2j; Wed, 02 Feb 2005 14:33:06 -0800
Subject: Re: Problems with PCMCIA on AMD Alchemy DB1100
From:	Josh Green <jgreen@users.sourceforge.net>
To:	ppopov@embeddedalley.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4200230A.6020002@embeddedalley.com>
References: <1107304567.2912.34.camel@SillyPuddy.localdomain>
	 <4200230A.6020002@embeddedalley.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YJUinRZhDb8owL//gUVr"
Date:	Wed, 02 Feb 2005 14:33:17 -0800
Message-Id: <1107383597.21173.6.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-YJUinRZhDb8owL//gUVr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Seems the "Badness in local_bh_enable at kernel/softirq.c:140" error I
reported has been fixed (patch that caused the problem was reverted in
bk), here is a reference to this and a patch (had to replace " <at> "
with @ since they got munged by GMANE):

http://article.gmane.org/gmane.linux.kernel/273477


On Tue, 2005-02-01 at 16:47 -0800, Pete Popov wrote:
> > The other problem I've experienced is a kernel oops when ejecting a
> > card.  While it isn't a problem for my project (should never be
> > inserting/ejecting cards) I thought I'd mention it.  Here is the oops
> > output, I wasn't able to use ksymoops since I'm having trouble building
> > a cross compiled version (buildroot didn't install libbfd, etc from
> > binutils), so this may or may not be useful:
>=20
> I'll take a look at this.
>=20
> Pete
>=20


I tried ejecting a card and it seemed to work fine.  The oops could have
been related to the ds.c bug.  At any rate, everything seems to be
running great at this point and I have yet to see any other problems.
	Best regards,
	Josh Green


--=-YJUinRZhDb8owL//gUVr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAVUrRoMuWKCcbgQRAsMiAJkBkZUVSSxsERLHwRh5CN1Fcx8nzwCfWKAc
i5VGjKQ8h/bbVN9r/mmxHsk=
=x/6V
-----END PGP SIGNATURE-----

--=-YJUinRZhDb8owL//gUVr--
