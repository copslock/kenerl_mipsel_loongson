Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2003 00:46:31 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:63.70.210.59]:13828 "EHLO
	mms2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225351AbTICXq3>; Thu, 4 Sep 2003 00:46:29 +0100
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.3)); Wed, 03 Sep 2003 16:42:43 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id QAA08319 for <linux-mips@linux-mips.org>; Wed, 3 Sep 2003 16:45:52
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 h83NkIov013686 for <linux-mips@linux-mips.org>; Wed, 3 Sep 2003 16:46:
 19 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id QAA17707 for
 <linux-mips@linux-mips.org>; Wed, 3 Sep 2003 16:46:18 -0700
Message-ID: <3F567D4A.BA3FD396@broadcom.com>
Date: Wed, 03 Sep 2003 16:46:18 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [PATCH] sibyte patch for 2.6 ide.h
X-WSS-ID: 1348A3F9646265-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

Folks,

Any objection to the following patch, which lets IDE work on 2.6 for
SiByte platforms?  Before getting it checked in, I'm willing to hear
style comments.  I need extra work to happen in ide_init_default_hwifs,
but that code doesn't fit well in <asm/ide.h> because most of the useful
declarations in <linux/ide.h> haven't been made yet.  With this patch, I
hoist the code into a C file, but can call back into the existing code
(avoiding maintaining a duplicate).

Kip

Index: include/asm-mips/ide.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/ide.h,v
retrieving revision 1.22
diff -u -r1.22 ide.h
--- include/asm-mips/ide.h      21 Jun 2003 14:08:28 -0000      1.22
+++ include/asm-mips/ide.h      3 Sep 2003 23:42:16 -0000
@@ -50,7 +50,12 @@
        ide_ops->ide_init_hwif_ports(hw, data_port, ctrl_port, irq);
 }
 
+#ifdef CONFIG_SIBYTE_SB1xxx_SOC
+extern void ide_init_default_hwifs(void);
+static __inline__ void mips_ide_init_default_hwifs(void)
+#else
 static __inline__ void ide_init_default_hwifs(void)
+#endif
 {
 #ifndef CONFIG_PCI
        hw_regs_t hw;
