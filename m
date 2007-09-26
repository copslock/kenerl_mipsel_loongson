Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 15:23:32 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:3760 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20029717AbXIZOXX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 15:23:23 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 3C714200A25A;
	Wed, 26 Sep 2007 16:22:50 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05155-01-50; Wed, 26 Sep 2007 16:22:45 +0200 (CEST)
Received: from [192.168.27.65] (6.240.216.81.static.lk.siwnet.net [81.216.240.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 2F1C3200A25B;
	Wed, 26 Sep 2007 16:22:41 +0200 (CEST)
Message-ID: <46FA6B27.6050204@27m.se>
Date:	Wed, 26 Sep 2007 16:22:31 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Icedove 1.5.0.12 (X11/20070730)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, nigel@mips.com,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Useless stack randomization patch
References: <46FA6846.2080704@gmail.com>
In-Reply-To: <46FA6846.2080704@gmail.com>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Franck Bui-Huu wrote:
> Ralf,
>
> We started stack inside page randomization through commit
> 941091024ef0f2f7e09eb81201d293ac18833cc8 but it currently does nothing
> usefull because ELF_PLATFORM is not defined on MIPS (see
> fs/binfm_elf.c, create_elf_tables() for details).
>
> I tried several times to get information on lkml about that dependency
> but unfortunately I got no answer.
>
> I'm not sure how ELF_PLATFORM is used by ld.so and I don't think it's
> a good idea to define it just for enabling stack randomization.
>
> What do you think ?
>
> thanks
>         Franck
>
I think you mean this in specific:

"/* This yields a string that ld.so will use to load implementation
   specific libraries for optimization.  This is more specific in
   intent than poking at uname or /proc/cpuinfo.

   For the moment, we have only optimizations for the Intel generations,
   but that could change... */

#define ELF_PLATFORM  (NULL)"

Right?

- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG+msl6I0XmJx2NrwRCBm0AJ99yMRx1Kkre9bPa3y9lkV+xHSvVwCcC6qP
5AoYOLF7HLEOPrnr8fIhBuk=
=+uD/
-----END PGP SIGNATURE-----
