Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2004 00:56:43 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:4046
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8225285AbUL2A4i>; Wed, 29 Dec 2004 00:56:38 +0000
Received: from iria.infostations.net (iria.infostations.net [71.4.40.31])
	by mail-relay.infostations.net (Postfix) with ESMTP id DDA9AA1421;
	Wed, 29 Dec 2004 00:56:14 +0000 (Local time zone must be set--see zic manual page)
Received: from host-69-19-171-18.rev.o1.com ([69.19.171.18])
	by iria.infostations.net with esmtp (Exim 4.41 #1 (Gentoo))
	id 1CjSAF-0006PM-7e; Tue, 28 Dec 2004 16:58:13 -0800
Subject: RE: dbAu1550 (Cabarnet) - problems booting kernel - hangs at "Sen
	ding BOOTP" and root file system for MIPS (BE)
From: Josh Green <jgreen@users.sourceforge.net>
To: Prashant Viswanathan <vprashant@echelon.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <5375D9FB1CC3994D9DCBC47C344EEB59016543DF@miles.echelon.com>
References: <5375D9FB1CC3994D9DCBC47C344EEB59016543DF@miles.echelon.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lNfSlEGaqSuO1iYwzP3b"
Date: Tue, 28 Dec 2004 16:55:55 -0800
Message-Id: <1104281755.14675.13.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-lNfSlEGaqSuO1iYwzP3b
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-12-28 at 16:42 -0800, Prashant Viswanathan wrote:
> However, the kernel seems to hang in "Sending BOOTP Requests"
> <snip>
> Sending BOOTP requests .<6>eth0: link up
> eth1: link up
> ..... timed out!
> IP-Config: Reopening network devices...
> Sending BOOTP requests ....
> </snip>
>=20

Perhaps you don't have a bootp service on your network.  I usually put
ip=3Ddhcp (go to Device Drivers->Networking support->Networking options
and enable IP: DHCP support).

> The same happens whether I use "go . ip=3Dany" or "go . ip=3D10.2.11.185"=
 from
> yamon. All the other nodes on this network also use DHCP to get their
> addresses and they have no problems. The board itself boots using tftp so
> the network connectivity must be good.
>=20
> My next step would be to specify a root file system. Where can I find a r=
oot
> file system (or/and compiled package) for MIPS (BE)? I saw this thread (l=
ink
> below) on the mailing list, but none of these links work now.=20
> http://www.linux-mips.org/archives/linux-mips/2001-03/threads.html#00008
>=20

You could build your own tool chain and root file system, which is what
I did (I have a dbAu1100 board).  I used the buildroot package which is
part of the uclibc project:
http://www.uclibc.org/

You can download the buildroot CVS tarball here (just look for the
"Download tarball" link at the bottom:
http://www.uclibc.org/cgi-bin/cvsweb/buildroot/

It has a "make menuconfig" style configuration system and will build
busybox and other programs and create an ext2 file system, etc.  I opted
to build busybox and the mips kernel separately though (so I could more
easily configure them).  I now have a cross compiler and tool chain for
my x86 laptop.

>=20
> Thanks
> Prashant
>=20

Cheers.
	Josh Green


--=-lNfSlEGaqSuO1iYwzP3b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB0gCaRoMuWKCcbgQRAlifAKCYaTeSjiuFwOATtedE3gOEoDWiiwCdGKLq
9iUgryadeXfUktVUxCc3E7M=
=J3UI
-----END PGP SIGNATURE-----

--=-lNfSlEGaqSuO1iYwzP3b--
