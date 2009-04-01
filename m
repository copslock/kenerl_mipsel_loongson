Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2009 15:15:28 +0100 (BST)
Received: from investici.nine.ch ([217.150.252.179]:26793 "EHLO
	confino.investici.org") by ftp.linux-mips.org with ESMTP
	id S20025317AbZDAOPM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Apr 2009 15:15:12 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: arc@autistici.org) with ESMTP id 7B663C86FB
Message-ID: <49D376E4.4090503@gnu.org>
Date:	Wed, 01 Apr 2009 16:15:00 +0200
From:	Graziano Sorbaioli <graziano@gnu.org>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	graziano@gnu.org
Subject: getcontext needs to be implemented on mips
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <graziano@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: graziano@gnu.org
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

in a previous email I notified the list about a bug related to my wvdial
on gnewsense mips-l.

This bug is not related to my Lemote Yeeloong or gNewSense mips-l.

The problem is that getcontext needs to be implemented on mips.

Someone wrote a patch but it is for glibc 2.9 and needs to be modified
to function with glibc 2.7 (the version gnewsense mips-l is using right
now).

Unfortunately I don't have the knowledge to do that so I am asking for
your help.

My friend and gnewsense mips-l developer, nyu, told me:

<nyu> yes.  unfortunately it gives build errors with glibc 2.7

<nyu> maybe they're easy to fix, specially if you know mips asm


And this is the summary of the bug:

http://bugs.gnewsense.org/Bugs/00261


Can you help me?

- --
Graziano Sorbaioli ~ sorbaioli.org

Libre Planet Italia
http://libreplanet.org/index.php/LibrePlanetItalia
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJ03bkTtn97LA90HMRAsfVAKDtyNlOeI787N2PQI08JFsD+2dUvwCeKUne
MMYi9GGjwRjg4IcmnkvswOE=
=L2H7
-----END PGP SIGNATURE-----
