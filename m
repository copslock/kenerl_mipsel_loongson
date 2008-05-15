Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 08:22:10 +0100 (BST)
Received: from minnie.intcom.nl ([217.115.199.145]:25996 "EHLO
	minnie.intcom.nl") by ftp.linux-mips.org with ESMTP
	id S20034191AbYEOHWG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 May 2008 08:22:06 +0100
Received: from localhost (minnie.intcom.nl [127.0.0.1])
	by minnie.intcom.nl (Postfix) with ESMTP id 816042F28C5;
	Thu, 15 May 2008 09:22:05 +0200 (CEST)
X-Virus-Scanned: IntCom scan amavisd-new at minnie.intcom.nl
Received: from minnie.intcom.nl ([127.0.0.1])
	by localhost (minnie.intcom.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id klEZ5GQH0b5O; Thu, 15 May 2008 09:22:04 +0200 (CEST)
Received: by minnie.intcom.nl (Postfix, from userid 1000)
	id C928A2F37EA; Thu, 15 May 2008 09:21:58 +0200 (CEST)
Date:	Thu, 15 May 2008 09:21:58 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Ramgopal Kota <rkota@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Enabling JFFS as Root FS
Message-ID: <20080515072158.GJ4505@dusktilldawn.nl>
References: <Pine.LNX.4.64.0805131444360.15369@wrl-59.cs.helsinki.fi> <20080513232507.GA24102@linux-mips.org> <20080513180225.194f400b.akpm@linux-foundation.org> <20080514150859.GA9898@linux-mips.org> <E06E3B7BBC07864CADE892DAF1EB0FBD07CEB326@NT-SJCA-0752.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oHxSCaSS3y4TqjY8"
Content-Disposition: inline
In-Reply-To: <E06E3B7BBC07864CADE892DAF1EB0FBD07CEB326@NT-SJCA-0752.brcm.ad.broadcom.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--oHxSCaSS3y4TqjY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Remgopal,

On Wed, May 14, 2008 at 08:58:47AM -0700, Ramgopal Kota wrote:
> Now I want to have the rootfs (jffs) on flash. Is there any document
> which tells me how to do that ?

As a learning exercise you could start by reading the Filesystem
Hierarchy Standard: http://www.pathname.com/fhs/. This is a great
document to give you some insight into a Unix filesystem.

With that basic knowledge you can start to build your own
filesystem. It's not that hard. Just use a standard Debian
(that's what I did) mipsel installation and copy everything you
need from it to your own filesystem.

What do you need and what not? Well, you start with /sbin/init,
since that is the very first process the Linux kernel starts when
it is done with itself. So make sure that is in place. Next use
ldd to find out what libraries it needs. Copy those in place too.
Run ldd too for every library, to get it's dependings too.

Next you put /etc/inittab in place. Read it carefully and follow
all its scripts in it. Of course copy those in place too and all
the tools all those scripts need. Again, for all the tools run
ldd to find the libraries needed. In the start it looks like a
lot, but you'll soon find out most basic pieces of the system use
the same libraries over and over again.

You can also copy the /dev directory from the Debian installation
to your own filesystem.

This way you will build a very basic and clean system and more
important you will learn how a Linux system boots. For me back
then it was a real eye opener when I read the aforementioned FHS
document and just started by following all scripts mentioned in
/etc/inittab. It takes some time, but it's worth the exercise!

Good luck!


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--oHxSCaSS3y4TqjY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIK+SWbxf9XXlB0eERAu4jAKDXNOpmM+zVgxhs3UrohUSmtyBG6gCeP6xK
b3QtP10cbzROSYacjItDZkQ=
=BNSq
-----END PGP SIGNATURE-----

--oHxSCaSS3y4TqjY8--
