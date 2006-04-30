Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Apr 2006 22:47:47 +0100 (BST)
Received: from godel.catalyst.net.nz ([202.78.240.40]:23727 "EHLO
	mail1.catalyst.net.nz") by ftp.linux-mips.org with ESMTP
	id S8133822AbWD3Vrh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 30 Apr 2006 22:47:37 +0100
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=pkunk.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtps (SSL 3.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1FaJlN-0002aU-Q3
	for linux-mips@linux-mips.org; Mon, 01 May 2006 09:47:33 +1200
Subject: Ugly error in dmesg
From:	Sam Cannell <sam@catalyst.net.nz>
To:	linux-mips@linux-mips.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-k+ZiYNlVLP2beo5KhtkD"
Date:	Mon, 01 May 2006 09:47:33 +1200
Message-Id: <1146433653.18721.10.camel@pkunk.wgtn.cat-it.co.nz>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Return-Path: <sam@catalyst.net.nz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@catalyst.net.nz
Precedence: bulk
X-list: linux-mips


--=-k+ZiYNlVLP2beo5KhtkD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

A couple of days ago I dropped Debian on an Indy I've had lying around
for a while.  I'd done the first stage of the install, rebooted, and
left it sitting at the last half of the Debian installer for a while.
When I looked at it an hour or two later, the kernel had spat out the
following:

Eeek! page_mapcount(page) went negative! (-1)
  page->flags =3D 14
  page->count =3D 0
  page->mapping =3D 00000000
Break instruction in kernel code[#1]:
Cpu 0
$ 0   : 00000000 1000cc00 ffffffff 8820fe38
$ 4   : 8820fe38 8820fe54 00000001 bf0f0000
$ 8   : 00002085 88260000 0084100b 014f0000
$12   : 89187972 ffffffff 00000029 88260000
$16   : 89125460 1000d000 89125460 10034000
$20   : 89d83d30 88832100 ffffffbf 00000000
$24   : 88260000 88110960
$28   : 89d82000 89d83d08 89333200 8805b06c
Hi    : 00000000
Lo    : 00000027
epc   : 880628b8 page_remove_rmap+0xd8/0xe4     Not tainted
ra    : 8805b06c unmap_vmas+0x508/0x680
Status: 1000cc03    KERNEL EXL IE
Cause : 00000024
PrId  : 00002020
Modules linked in: unix
Process sh (pid: 7040, threadinfo=3D89d82000, task=3D8a114ad8)

[ etc .. full dmesg output is at http://plaz.net.nz/indy-dmesg.txt ]

I think the error may have appeared when the /etc/cron.daily/ scripts
started running.

I'm running a hand-compiled 2.6.16.11 (I had to drop a new kernel on
halfway through the installer because the Debian one has software raid
built as modules)

Is the message above common?  As I said, the Indy has been sitting
around doing nothing for quite a while, so the hardware may be a little
flaky.  I haven't had a chance to test the SIMMs in there, or find
others to swap in to test.

Thanks,

Sam

--=-k+ZiYNlVLP2beo5KhtkD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEVTB0zjWM3BBT1QARAop4AJ4xYabiTny4pgcwM6bkmLiMW6UquQCfedPk
0+8YwQfGRD27vkWmNkhXUho=
=1+iT
-----END PGP SIGNATURE-----

--=-k+ZiYNlVLP2beo5KhtkD--
