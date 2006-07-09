Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2006 14:51:35 +0100 (BST)
Received: from frigate.technologeek.org ([62.4.21.148]:15500 "EHLO
	frigate.technologeek.org") by ftp.linux-mips.org with ESMTP
	id S8133513AbWGINvZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Jul 2006 14:51:25 +0100
Received: by frigate.technologeek.org (Postfix, from userid 1000)
	id ECF271465D70; Sun,  9 Jul 2006 15:51:26 +0200 (CEST)
From:	Julien BLACHE <jblache@debian.org>
To:	linux-mips@linux-mips.org
Cc:	debian-mips@lists.debian.org
Subject: [PATCH] IP22: fix serial console hangs
Date:	Sun, 09 Jul 2006 15:51:26 +0200
Message-ID: <87irm6naxt.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <jblache@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jblache@debian.org
Precedence: bulk
X-list: linux-mips

--=-=-=

Hi,

The patch below fixes serial console hangs as seen on IP22
machines. Typically, while booting, the machine hangs for ~1 minute
displaying "INIT: ", then the same thing happens again when init
enters in the designated runlevel and finally the getty process on
ttyS0 hangs indefinitely (though strace'ing it helps).

strace (-e raw=ioctl, otherwise the ioctl() translation is utterly
bogus) reveals that getty hangs on ioctl() 0x540f which happens to be
TCSETSW (I saw it hang on another console ioctl() but couldn't
reproduce that one).

A diff between ip22zilog and sunzilog revealed the following
differences:
 1. the channel A flag being set on up.port.flags instead of up.flags
 2. the channel A flag being set on what is marked as being channel B
 3. sunzilog has a call to uart_update_timeout(port, termios->c_cflag, baud);
    at the end of sunzilog_set_termios(), which ip22zilog lacks (on
    purpose ?)

The patch below addresses point 1 and fixes the serial console hangs
just fine. However point 2 should be investigated by someone familiar
with the IP22 Zilog; it's probably OK as is but even if it is, a
comment in ip22zilog.c is badly needed.

Point 3 is left as an exercise for whoever feels like digging into
ip22zilog :)

These are the main obvious differences between ip22zilog and
sunzilog. Newer versions of sunzilog (Linus's git tree as of today)
are more close to ip22zilog as the sbus_{write,read}b have been
changed into simple {write,read}b, which shrinks the diff by a fair
amount. Resyncing both drivers should be doable in a few hours time
now for someone familiar with the IP22 Zilog hardware.


Additional point: the IP22 thinks it's using the console on the
framebuffer when booting, when it's really using the serial console
(console=ttyS passed at boot, console=d, consoleOut=serial(0))


Please apply, along with the RTC typo fix from yesterday.

Thanks,

JB.

---
IP22: fix serial console hang due to a typo in ip22zilog.c

Signed-off-by: Julien BLACHE <jb@jblache.org>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=ip22zilog-channel-A-flag.patch
Content-Description: fix serial console hangs on IP22

--- source-mips-none/drivers/serial/ip22zilog.c	2006-06-18 03:49:35.000000000 +0200
+++ source/drivers/serial/ip22zilog.c	2006-07-09 14:25:11.847260358 +0200
@@ -1145,9 +1145,8 @@
 		up[(chip * 2) + 1].port.fifosize = 1;
 		up[(chip * 2) + 1].port.ops = &ip22zilog_pops;
 		up[(chip * 2) + 1].port.type = PORT_IP22ZILOG;
-		up[(chip * 2) + 1].port.flags |= IP22ZILOG_FLAG_IS_CHANNEL_A;
 		up[(chip * 2) + 1].port.line = (chip * 2) + 1;
-		up[(chip * 2) + 1].flags = 0;
+		up[(chip * 2) + 1].flags |= IP22ZILOG_FLAG_IS_CHANNEL_A;
 	}
 }
 

--=-=-=



-- 
 Julien BLACHE <jblache@debian.org>  |  Debian, because code matters more 
 Debian & GNU/Linux Developer        |       <http://www.debian.org>
 Public key available on <http://www.jblache.org> - KeyID: F5D6 5169 
 GPG Fingerprint : 935A 79F1 C8B3 3521 FD62 7CC7 CD61 4FD7 F5D6 5169 

--=-=-=--
