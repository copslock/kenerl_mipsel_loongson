Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 20:00:50 +0100 (BST)
Received: from sirius.livecd.pl ([IPv6:::ffff:83.243.111.250]:8969 "EHLO
	sirius.livecd.pl") by linux-mips.org with ESMTP id <S8225009AbUGSTAp> convert rfc822-to-8bit;
	Mon, 19 Jul 2004 20:00:45 +0100
Received: from localhost ([127.0.0.1] ident=havner)
	by sirius.livecd.pl with esmtp (Exim 4.32)
	id 1BmdOx-0004S5-Gq
	for linux-mips@linux-mips.org; Mon, 19 Jul 2004 21:02:15 +0200
From: havner <havner@pld-linux.org>
To: linux-mips@linux-mips.org
Subject: DECstation 5000/20
Date: Mon, 19 Jul 2004 21:02:14 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407192102.15261.havner@pld-linux.org>
Return-Path: <havner@pld-linux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: havner@pld-linux.org
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

What's the recommended kernel for this machine?
I've only managed to boot 2.4.17 from debian and 2.4.18
http://www.xs4all.nl/~vhouten/mipsel/vmlinux-2.4.18-decR3k.ecoff.tgz
Unfortunately both of them freezes system (RH7.1/RH7.3) f.e. when trying to 
cat /proc/cpuinfo. No oops, no message on serial, just hard freeze.
using rpm also likes to freeze this machine. I've tried co cross compile 
kernel from cvs at linux-mips.org, but it stop at boot time just after 
setting high precission timer. vanila kernel (2.6.7) ends with kernel panic.
cross tools used:

1. the newest versions from:
ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/i386-linux/mipsel-linux

2. self compiled:
$ mipsel-pld-linux-gcc -v
Reading specs from /usr/lib/gcc-lib/mipsel-pld-linux/3.3.4/specs
Configured with: ../configure --prefix=/usr --infodir=/usr/share/info 
- --mandir=/usr/share/man --bindir=/usr/bin --libdir=/usr/lib 
- --libexecdir=/usr/lib --includedir=/usr/mipsel-pld-linux/include 
- --disable-shared --disable-threads --enable-languages=c --with-gnu-as 
- --with-gnu-ld --with-system-zlib --with-multilib --without-x 
- --build=athlon-pld-linux --host=athlon-pld-linux --target=mipsel-pld-linux
Thread model: single
gcc version 3.3.4
$ mipsel-pld-linux-ld -v 
GNU ld version 2.15.91.0.1 20040527

The same effect on both.
I cannot find any patches for decstation on the net
Are there any more mips kernel repositories over the net?

I've got this machine two days ago and I'm trying to make small PLD port 
there.
I would be gratefull for any help.

- -- 
Regards       Havner                          http://livecd.pld-linux.org
GG: 2846839                             jid,mail: havner(at)pld-linux.org
          "We live as we dream, alone"   - Joseph Conrad
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA/Bq2gvS01FGjsR8RAvf+AKDKvYER+aHg9MllDJ0do8xwpBswpgCfY829
cj2WQZc1m+lpU8+aQxo8T7Q=
=RDi8
-----END PGP SIGNATURE-----
