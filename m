Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PGH6R19872
	for linux-mips-outgoing; Mon, 25 Feb 2002 08:17:06 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PGH2919869
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 08:17:02 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA20689
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 07:16:55 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA04455
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 07:16:54 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g1PFGLA23624
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 16:16:21 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id QAA22570
	for linux-mips@oss.sgi.com; Mon, 25 Feb 2002 16:16:20 +0100 (MET)
Message-Id: <200202251516.QAA22570@copsun18.mips.com>
Subject: Setting up of GP in static, non-PIC version of glibc?
To: linux-mips@oss.sgi.com
Date: Mon, 25 Feb 2002 16:16:20 +0100 (MET)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I compiled a static, non-PIC version of glibc (from H.J's miniport SRPM)
to allow testing of MIPS16[e] apps.

One of the things that did not work, is that nobody sets up GP correctly
in this case.

Modifying "/usr/src/redhat/BUILD/glibc-2.2.4/sysdeps/mips/elf/start.S" to
setup GP:

        .text
        .globl ENTRY_POINT
        .type ENTRY_POINT,@function
ENTRY_POINT:
#ifdef __PIC__
        SET_GP
#else
        la  $28, _gp
#endif

Makes things work (this code ends in crt1.o). Is this the right place to 
fix it?

/Hartvig
