Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f43AeAk10003
	for linux-mips-outgoing; Thu, 3 May 2001 03:40:10 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f43Ae9F10000
	for <linux-mips@oss.sgi.com>; Thu, 3 May 2001 03:40:09 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA28791
	for <linux-mips@oss.sgi.com>; Thu, 3 May 2001 03:40:14 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA01295
	for <linux-mips@oss.sgi.com>; Thu, 3 May 2001 03:40:13 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id MAA27644
	for <linux-mips@oss.sgi.com>; Thu, 3 May 2001 12:39:20 +0200 (MEST)
Message-ID: <3AF13558.F26941EE@mips.com>
Date: Thu, 03 May 2001 12:39:20 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Insertion of die_if_kernel in unaligned.c
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

In the latest version of arch/mips/kernel/unaligned.c, there has been
inserted some calls to the die_if_kernel, which check if we are running
in kernel mode and if so dies.
I'm not so sure this is the right thing to do, the floating point
emulator will in some cases generate an address error (e.g. if emulating
a swc1 to an unaligned address). The result is that an user application
can crash the kernel.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
