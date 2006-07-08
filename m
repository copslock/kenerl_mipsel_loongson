Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2006 23:21:36 +0100 (BST)
Received: from frigate.technologeek.org ([62.4.21.148]:35306 "EHLO
	frigate.technologeek.org") by ftp.linux-mips.org with ESMTP
	id S8133575AbWGHWVW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Jul 2006 23:21:22 +0100
Received: by frigate.technologeek.org (Postfix, from userid 1000)
	id 506A2147834A; Sun,  9 Jul 2006 00:21:24 +0200 (CEST)
From:	Julien BLACHE <jblache@debian.org>
To:	debian-mips@lists.debian.org
Cc:	linux-mips@linux-mips.org
Subject: Re: IP22 RTC bug on 64bit 2.6 kernels ?
References: <87fyhbhi1n.fsf@frigate.technologeek.org>
Date:	Sun, 09 Jul 2006 00:21:24 +0200
In-Reply-To: <87fyhbhi1n.fsf@frigate.technologeek.org> (Julien BLACHE's
	message of "Sun, 09 Jul 2006 00:02:12 +0200")
Message-ID: <87ac7jhh5n.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <jblache@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jblache@debian.org
Precedence: bulk
X-list: linux-mips

--=-=-=

Julien BLACHE <jblache@debian.org> wrote:

Hi,

> So, it looks like there is a bug in this area with (at least) 64bit
> 2.6 kernels. Is there any known bug ? Anything I can do to help track
> the problem down ?

Ok, it's brown paper bag time for someone :-)


This patch fixes a typo in arch/mips/sgi-ip22/ip22-time.c, leading to
the incorrect year being set into the RTC chip.

Signed-off-by: Julien BLACHE <jb@jblache.org>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=ip22-rtc-year-typo-fix.patch
Content-Description: Typo fix in arch/mips/sgi-ip22/ip22-time.c

--- arch/mips/sgi-ip22/ip22-time.c.orig	2006-07-08 22:17:02.000000000 +0000
+++ arch/mips/sgi-ip22/ip22-time.c	2006-07-08 22:17:29.000000000 +0000
@@ -76,7 +76,7 @@
 	save_control = hpc3c0->rtcregs[RTC_CMD] & 0xff;
 	hpc3c0->rtcregs[RTC_CMD] = save_control | RTC_TE;
 
-	hpc3c0->rtcregs[RTC_YEAR] = BIN2BCD(tm.tm_sec);
+	hpc3c0->rtcregs[RTC_YEAR] = BIN2BCD(tm.tm_year);
 	hpc3c0->rtcregs[RTC_MONTH] = BIN2BCD(tm.tm_mon);
 	hpc3c0->rtcregs[RTC_DATE] = BIN2BCD(tm.tm_mday);
 	hpc3c0->rtcregs[RTC_HOURS] = BIN2BCD(tm.tm_hour);

--=-=-=



Thanks,

JB.

-- 
 Julien BLACHE - Debian & GNU/Linux Developer - <jblache@debian.org> 
 
 Public key available on <http://www.jblache.org> - KeyID: F5D6 5169 
 GPG Fingerprint : 935A 79F1 C8B3 3521 FD62 7CC7 CD61 4FD7 F5D6 5169 

--=-=-=--
