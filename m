Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VEKI817021
	for linux-mips-outgoing; Thu, 31 Jan 2002 06:20:18 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VEKFd17016
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 06:20:15 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA24106
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 05:20:06 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA20581
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 05:20:06 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g0VDJeA20895
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 14:19:41 +0100 (MET)
Message-ID: <3C594485.640694F9@mips.com>
Date: Thu, 31 Jan 2002 14:20:05 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Yet another problem/bug on 20Kc Rev4.0 :-(
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

It looks like 20Kc Rev4.0 has a problem then checking the file system
with 'fsck'.
The system ends up in a dead look situation, where we don't get any
timer interrupts.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
