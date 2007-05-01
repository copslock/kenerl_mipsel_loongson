Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2007 23:51:33 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:5046 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022872AbXEAWvb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2007 23:51:31 +0100
Received: from lagash (88-106-169-123.dynamic.dsl.as9105.com [88.106.169.123])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id E33AFB82C9
	for <linux-mips@linux-mips.org>; Wed,  2 May 2007 00:51:25 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1Hj1Cg-00039J-Iv
	for linux-mips@linux-mips.org; Tue, 01 May 2007 23:52:14 +0100
Date:	Tue, 1 May 2007 23:52:14 +0100
To:	linux-mips@linux-mips.org
Subject: Some potential FPU emulator problem
Message-ID: <20070501225214.GE30083@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

I used the appended patch which enables the assert() in the
FPU emulator. The result (running in qemu) is:

[snip]
Will now check root file system:fsck 1.40-WIP (14-Nov-2006)
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a -C0 /dev/hda1
/dev/hda1: clean, 21846/131072 files, 371295/524272 blocks
.
EXT3 FS on hda1, internal journal
Setting the system clock..
System Clock set. Local time: Tue May  1 22:43:28 UTC 2007.
Cleaning up ifupdown....
Loading device-mapper support.
Will now check all file systems.
fsck 1.40-WIP (14-Nov-2006)
Checking all file systems.
Done checking file systems.
A log is being saved in /var/log/fsck/checkfs if that location is writable.
Setting kernel variables...done.
Will now mount local filesystems:.
Will now activate swapfile swap:done.
BUG: soft lockup detected on CPU#0!
Call Trace:
[<80016d98>] dump_stack+0x8/0x34
[<800594ac>] softlockup_tick+0x114/0x178
[<800405bc>] update_process_times+0x38/0x90
[<80016510>] timer_interrupt+0x120/0x150
[<80059b60>] handle_IRQ_event+0x6c/0xdc
[<8005b650>] handle_level_irq+0xd4/0x17c
[<80010b70>] plat_irq_dispatch+0xb0/0x150
[<80011200>] ret_from_irq+0x0/0x4
[<80249a28>] _spin_unlock_irqrestore+0x28/0x48
[<80042ed0>] force_sig_info+0xa4/0xf8
[<80017f1c>] do_tr+0xb4/0x134
[<800111e0>] ret_from_exception+0x0/0x20
[<80021dac>] ieee754sp_format+0x28/0x50c
[<80027e14>] ieee754sp_fdp+0x94/0x3d0
[<80020194>] fpu_emulator_cop1Handler+0x1334/0x1b40
[<80017934>] do_cpu+0x344/0x380
[<800111e0>] ret_from_exception+0x0/0x20

Without this patch the same configuration boot fine. I don't know i
f this just means one of the asserts is broken or if there is
something wrong with the FPU emulation.


Thiemo


diff --git a/arch/mips/math-emu/ieee754dp.h b/arch/mips/math-emu/ieee754dp.h
index a37370d..f777806 100644
--- a/arch/mips/math-emu/ieee754dp.h
+++ b/arch/mips/math-emu/ieee754dp.h
@@ -28,7 +28,7 @@
 
 #include "ieee754int.h"
 
-#define assert(expr) ((void)0)
+#define assert(expr) BUG_ON(expr)
 
 /* 3bit extended double precision sticky right shift */
 #define XDPSRS(v,rs)	\
diff --git a/arch/mips/math-emu/ieee754sp.h b/arch/mips/math-emu/ieee754sp.h
index ae82f51..68bd4c0 100644
--- a/arch/mips/math-emu/ieee754sp.h
+++ b/arch/mips/math-emu/ieee754sp.h
@@ -28,7 +28,7 @@
 
 #include "ieee754int.h"
 
-#define assert(expr) ((void)0)
+#define assert(expr) BUG_ON(expr)
 
 /* 3bit extended single precision sticky right shift */
 #define SPXSRSXn(rs) \
