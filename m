Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA690509 for <linux-archive@neteng.engr.sgi.com>; Thu, 8 Jan 1998 14:39:08 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA24243 for linux-list; Thu, 8 Jan 1998 14:35:00 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA24228 for <linux@engr.sgi.com>; Thu, 8 Jan 1998 14:34:55 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA00662
	for <linux@engr.sgi.com>; Thu, 8 Jan 1998 14:34:53 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-10.uni-koblenz.de [141.26.249.10])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA07809
	for <linux@engr.sgi.com>; Thu, 8 Jan 1998 23:34:51 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA01217;
	Thu, 8 Jan 1998 23:31:42 +0100
Message-ID: <19980108233142.45335@uni-koblenz.de>
Date: Thu, 8 Jan 1998 23:31:42 +0100
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: New binutils
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----

Hi all,

I've uploaded a new set of binutils to ftp.linux.sgi.com.  They fix
the packaging error that was causing trouble for people which were
upgrading from binutils 2.7 to the rpm of binutils-2.8.1-1.  It also
contains the workaround for the GCC long long bug I reported some
time ago and some other small things.

Have fun ...

  Ralf

73ead44770a42b12edd435dc3f13bbef  redhat/RPMS/mips-linux/binutils-2.8.1-2.mips.rpm
f7e7d12ccc2644c534bef92a505ffc90  redhat/RPMS/mipsel-linux/binutils-2.8.1-2.mips.rpm
90ce3af0b610033107624b9050457e43  redhat/SRPMS/binutils-2.8.1-2.src.rpm

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3i
Charset: latin1

iQCVAwUBNLVTP0ckbl6vezDBAQGH2AP/XUlcj0CpgT53Kp1kDGZ7Qan0qIa6KT8A
QN96DSFvcmHSV851gYPKJIIyT3cC5BKI7z7j/qH6bTSsZUFKwt4bsmZflP4IqfMe
TKqAxl1SddNlurgZqhtDcg5zgk9qAXDDY8dvQN1TlyIG/2SiR9vb7KpwRvZiSYqf
D1AQmKK72rI=
=Omgn
-----END PGP SIGNATURE-----
