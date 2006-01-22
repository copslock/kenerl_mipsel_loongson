Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 12:24:04 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:14101 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133465AbWAWMXp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 12:23:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0NCRK0f005416;
	Mon, 23 Jan 2006 12:28:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0M33fnI011628;
	Sun, 22 Jan 2006 03:03:41 GMT
Date:	Sun, 22 Jan 2006 03:03:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kurt Schwemmer <kurts@vitesse.com>
Cc:	linux-mips@linux-mips.org, sde@mips.com
Subject: Re: Build errors
Message-ID: <20060122030341.GB11131@linux-mips.org>
References: <1137793865.15788.26.camel@lx-kurts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137793865.15788.26.camel@lx-kurts>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 20, 2006 at 02:51:05PM -0700, Kurt Schwemmer wrote:

> I sync'd with git clone rsync://ftp.linux-mips.org/git/linux.git
> linux.git 2 days ago. I downloaded and installed sde:
> ftp://ftp.mips.com/pub/tools/software/sde-for-linux/6.02.03-1/mipsel-sdelinux-v6.02.03-1.i386.rpm

> ...but the one that kills me is:
> mm/msync.o: In function `msync_interval':
> msync.c:(.text+0x10c): unmatched HI16 relocation
> mipsel-linux-ld: final link failed: Bad value
> make[1]: *** [mm/built-in.o] Error 1
> make: *** [mm] Error 2

This kind of problem is usually being caused by either broken inline
assembler code or a bug in the compiler.  Since we haven't done any
serious changes to the inline code recently I would put my bets on a gcc
bug, so I'm putting the SDE people at MIPS on Cc.  It could be useful if
you could post your .config kernel configuration file.  Also, which
kernel version exactly are you building?  The command "git-describe HEAD"
will tell you something like "linux-2.6.15-g68cabd8e", can you post that
number?

> Would someone tell me what I'm doing wrong? I'm pretty sure people
> wouldn't be checking in code that doesn't even build!

We try hard - but the number of tools and configuration variants makes it
hard to ensure that kind of thing never happens.

  Ralf
