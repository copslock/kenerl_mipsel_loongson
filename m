Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PDIsnC021146
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 06:18:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PDIsLS021145
	for linux-mips-outgoing; Tue, 25 Jun 2002 06:18:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PDIlnC021139;
	Tue, 25 Jun 2002 06:18:47 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id GAA16919;
	Tue, 25 Jun 2002 06:22:04 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA16830;
	Tue, 25 Jun 2002 06:22:00 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5PDLxb08286;
	Tue, 25 Jun 2002 15:21:59 +0200 (MEST)
Message-ID: <3D186E76.63B33B0E@mips.com>
Date: Tue, 25 Jun 2002 15:21:58 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: LTP testing
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The next LTP failure line is:
pipe05      1  BROK  :  Unexpected signal 11 received.

For this one I haven't got a fix, because the failure is due to the way
the pipe syscall is implemented for MIPS (so we need a fix in both the
kernel and glibc).

The glibc code look like this
SYSCALL__ (pipe, 1)
        /* Plop in the two descriptors.  */
        sw v0, 0(a0)
        sw v1, 4(a0)

        /* Go out with a clean status.  */
        move v0, zero
        j ra
        .end __pipe

The problem is that the code is called with $a0 = 0. So the 'sw v0,
0(a0)' after the syscall generates a segmentation fault.
Why are the pipe syscall implemented this way, where we return the two
descriptors in v0 and v1 ?
Why doesn't the kernel do these stores (this way we can do an access
check, like i386 does) ?

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
