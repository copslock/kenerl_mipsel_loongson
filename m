Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9TB5PY30192
	for linux-mips-outgoing; Mon, 29 Oct 2001 03:05:25 -0800
Received: from dea.linux-mips.net (a1as18-p202.stg.tli.de [195.252.193.202])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9TB5H030181
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 03:05:17 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9TB5D203027
	for linux-mips@oss.sgi.com; Mon, 29 Oct 2001 12:05:13 +0100
Received: from 21cn.com ([61.140.60.248])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9T9uc028676
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 01:56:38 -0800
Message-Id: <200110290956.f9T9uc028676@oss.sgi.com>
Received: from cc([210.5.16.17]) by 21cn.com(AIMC 2.9.5.2)
	with SMTP id jm223bdd6680; Mon, 29 Oct 2001 18:02:22 +0800
Date: Mon, 29 Oct 2001 17:54:15 +0800
From: 8route <ajob4me@21cn.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>,
   "carstenl@mips.com" <carstenl@mips.com>
Subject: other info about Toshiba TX3927 board boot problem.
X-mailer: FoxMail 3.0 beta 1 [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="US_ASCII"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dear Atsushi:
  Hi!
  I found the reset switch on the TX3927 board can work if you switch it
against the PCI interface when
==================================
  VFS: Mounted root (NFS filesystem).
  Freeing unused kernel memory: 44k freed 
========================================
,usually I switch it towards the PCI interface.

  And I have fixed the source code of process.c as you said.
>For TX3927, you must skip those two lines in exit_thread() and
>flush_thread().
>
>		set_cp0_status(ST0_CU1, ST0_CU1);
>		__asm__ __volatile__("cfc1\t$0,$31");
>
>
But the problem still exists.The serial console output will stop at
==================================
  VFS: Mounted root (NFS filesystem).
  Freeing unused kernel memory: 44k freed 
========================================

  I think that maybe the Linux system has booted up OK,but there is
something wrong with the serial console because serial ports are integrated
with TX3927.Do you agree?Please consider it in your latest patch.
>By the way, now I'm planning to send patches for TX CPU boards
>(including JMR3927) to oss.sgi.com.  If you can wait a while, you can
>try it.
Thank you very much.

8route
ajob4me@21cn.com
10/29/2001
