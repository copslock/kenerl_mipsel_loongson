Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6FFvURw003860
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 08:57:30 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6FFvUJx003859
	for linux-mips-outgoing; Mon, 15 Jul 2002 08:57:30 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hermod.qsicorp.com (mail.qsicorp.com [216.190.147.34])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6FFvQRw003849
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 08:57:26 -0700
Received: from qsicorp.com (computer195.qsicorp.com [216.190.147.195])
	by hermod.qsicorp.com (Postfix) with ESMTP id C4E5617043
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 10:02:17 -0600 (MDT)
Message-ID: <3D3300A3.FD50EDEA@qsicorp.com>
Date: Mon, 15 Jul 2002 10:04:35 -0700
From: Ryan Martindale <ryan@qsicorp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: fpu woes (TX3912)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm using the tx3912 processor for an embedded device and since it
doesn't have an fpu, I don't have coprocessor #1.  Recently, I remember
seeing a fix in process.c for exit_thread and flush_thread, and did
apply it - but there still is a problem (at least for me). In traps.c,
the save_fp_context and restore_fp_context are set to _save_fp_context
(in r2300_fpu.S) which don't check to see if I have a coprocessor
available. As I am rather new to the linux/linux-mips development world,
I thought I'd give a heads up (it is causing my embedded system to
crash). Any direction on fixing it would be welcome, but I'm not sure
I'll get to the point where I will submit any patches any time soon.

Ryan Martindale
QSI Corporation
