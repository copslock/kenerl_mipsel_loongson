Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4M7mlnC027679
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 22 May 2002 00:48:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4M7mlc8027678
	for linux-mips-outgoing; Wed, 22 May 2002 00:48:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4M7mhnC027675
	for <linux-mips@oss.sgi.com>; Wed, 22 May 2002 00:48:43 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id AAA14703
	for <linux-mips@oss.sgi.com>; Wed, 22 May 2002 00:49:29 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA13996
	for <linux-mips@oss.sgi.com>; Wed, 22 May 2002 00:49:30 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g4M7nVb07726
	for <linux-mips@oss.sgi.com>; Wed, 22 May 2002 09:49:32 +0200 (MEST)
Message-ID: <3CEB4D8C.8BE4CF3A@mips.com>
Date: Wed, 22 May 2002 09:49:32 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Does anyone have a 64-bit kernel running ?
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

After fixing a lot of stuff, I finally got a 64-bit kernel up and run on
the Malta board.
But there are still a lot of things that doesn't work.
E.g. the read_rtc routine fails, because a "long" is 64-bit in the
kernel and 32-bit in the user application (I run on o32 compiled
userland).
If I replace all "longs" in the read_rtc routine with "integers" it
works fine, but then I will probably break things, once we got a n64
compiled userland.
NFS fails because of a checksum errors in some UDP packages.

Does anyone have any experience in the 64-bit kernel ?

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
