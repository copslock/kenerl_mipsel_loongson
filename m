Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBRC6Lv10785
	for linux-mips-outgoing; Thu, 27 Dec 2001 04:06:21 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBRC6GX10782
	for <linux-mips@oss.sgi.com>; Thu, 27 Dec 2001 04:06:16 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA16118
	for <linux-mips@oss.sgi.com>; Thu, 27 Dec 2001 03:06:08 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA16511
	for <linux-mips@oss.sgi.com>; Thu, 27 Dec 2001 03:06:07 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fBRB5tA23330
	for <linux-mips@oss.sgi.com>; Thu, 27 Dec 2001 12:05:55 +0100 (MET)
Message-ID: <3C2B0093.3AFC80A9@mips.com>
Date: Thu, 27 Dec 2001 12:05:55 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Signals
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Why is the signals definition (in include/asm-mips/signal.h) for MIPS
different from everybody else ?
For example:

#define SIGBUS      10    (MIPS)
#define SIGBUS        7    (I386)

#define SIGSTKFLT       16   (I386, doesn't exist on MIPS)

Is there any reason for this ?

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
