Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f419h4415104
	for linux-mips-outgoing; Tue, 1 May 2001 02:43:04 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f419h4M15101
	for <linux-mips@oss.sgi.com>; Tue, 1 May 2001 02:43:04 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA02275
	for <linux-mips@oss.sgi.com>; Tue, 1 May 2001 02:43:09 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA18059
	for <linux-mips@oss.sgi.com>; Tue, 1 May 2001 02:43:06 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id LAA12301
	for <linux-mips@oss.sgi.com>; Tue, 1 May 2001 11:42:16 +0200 (MEST)
Message-ID: <3AEE84F8.6BC907A7@mips.com>
Date: Tue, 01 May 2001 11:42:16 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Login problem on a serial console
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have just upgraded my kernel sources from 2.4.1 to the latest 2.4.3
sources, but after doing that I can't login on my serial console. It get
all the way up to the login prompt, but nothing happens when I try to
press a key.  So I figure that the serial line worked one way.
I have tried using a single shell (booted with "init=/bin/sh") and that
seemed to work fine, so I guess the serial driver works fine.

I'm running on both an Atlas and a Malta board, both seem to have the
same problem.
Has anyone any ideas ?

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
