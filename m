Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 19:42:16 +0000 (GMT)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:10504 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225247AbTCGTmP>; Fri, 7 Mar 2003 19:42:15 +0000
Received: from 10.10.64.123 by mms1.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Fri, 07 Mar 2003 11:29:19 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA01988; Fri, 7 Mar 2003 11:29:23 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h27JTYER009278; Fri, 7 Mar 2003 11:29:34 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id LAA16607; Fri, 7
 Mar 2003 11:29:34 -0800
Message-ID: <3E68F31E.76604C00@broadcom.com>
Date: Fri, 07 Mar 2003 11:29:34 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ralf Baechle" <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: scall_n32.S register saves
X-WSS-ID: 12762C851233393-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips


If O32 is enabled, handle_sysn32 shouldn't have to SAVE_SOME and STI...

Kip

Index: arch/mips64/kernel/scall_n32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/scall_n32.S,v
retrieving revision 1.2.2.8
diff -u -r1.2.2.8 scall_n32.S
--- arch/mips64/kernel/scall_n32.S      7 Mar 2003 01:22:48 -0000      
1.2.2.8
+++ arch/mips64/kernel/scall_n32.S      7 Mar 2003 19:27:50 -0000
@@ -29,6 +29,12 @@
 
        .align  5
 NESTED(handle_sysn32, PT_SIZE, sp)
+#ifndef CONFIG_MIPS32_O32
+       .set    noat
+       SAVE_SOME
+       STI
+       .set    at
+#endif
        ld      t1, PT_EPC(sp)          # skip syscall on return
 
        subu    t0, v0, __NR_N32_Linux  # check syscall number
