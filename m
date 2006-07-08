Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2006 23:02:19 +0100 (BST)
Received: from frigate.technologeek.org ([62.4.21.148]:14041 "EHLO
	frigate.technologeek.org") by ftp.linux-mips.org with ESMTP
	id S8133575AbWGHWCK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Jul 2006 23:02:10 +0100
Received: by frigate.technologeek.org (Postfix, from userid 1000)
	id 5B874147834A; Sun,  9 Jul 2006 00:02:12 +0200 (CEST)
From:	Julien BLACHE <jblache@debian.org>
To:	debian-mips@lists.debian.org
Cc:	linux-mips@linux-mips.org
Subject: IP22 RTC bug on 64bit 2.6 kernels ?
Date:	Sun, 09 Jul 2006 00:02:12 +0200
Message-ID: <87fyhbhi1n.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jblache@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jblache@debian.org
Precedence: bulk
X-list: linux-mips

Hi,

For some time now, my IP22 was booting in a "back to the future" mode,
somewhere between 1983 and 1987 (usually, 1985). Interestingly enough,
only the year comes out wrong, everything else is perfectly OK.

This is not the RTC chip at fault, as everything else stored in the
NVRAM is OK too. I was prepared to order a new RTC chip, until...

Until I remembered that it all started with the new 64bit 2.6 kernels
built by Martin Michlmayr in Debian. Indeed, rebooting into a 32bit
2.4.27 the problem goes away.

Using the 2.6 kernel (2.6.17), hwclock -w/hwclock -r will not give the
same year twice in a row, which is quite fun and unexpected. I
couldn't find a logic of some kind in the values read from the RTC;
the year went as far as 1972 and as close as 2007 :)

So, it looks like there is a bug in this area with (at least) 64bit
2.6 kernels. Is there any known bug ? Anything I can do to help track
the problem down ?

Thanks,

JB.

-- 
 Julien BLACHE - Debian & GNU/Linux Developer - <jblache@debian.org> 
 
 Public key available on <http://www.jblache.org> - KeyID: F5D6 5169 
 GPG Fingerprint : 935A 79F1 C8B3 3521 FD62 7CC7 CD61 4FD7 F5D6 5169 
