Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA1IswL18654
	for linux-mips-outgoing; Thu, 1 Nov 2001 10:54:58 -0800
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA1Isq018647
	for <linux-mips@oss.sgi.com>; Thu, 1 Nov 2001 10:54:52 -0800
Received: from 63.70.210.4 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Thu, 01 Nov 2001 10:54:41 -0800
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from postal.sibyte.com (IDENT:postfix@[10.21.128.60]) by
 mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP id KAA13143; Thu, 1
 Nov 2001 10:54:50 -0800 (PST)
Received: from broadcom.com (dt-sj3-158 [10.21.64.158]) by
 postal.sibyte.com (Postfix) with ESMTP id 3464F1595F; Thu, 1 Nov 2001
 10:54:51 -0800 (PST)
Message-ID: <3BE19A7B.79F7982@broadcom.com>
Date: Thu, 01 Nov 2001 10:54:51 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
cc: kwalker@broadcom.com
Subject: DO_FAULT patch
X-WSS-ID: 17FF45FB439391-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I noticed that the BadVaddr in Oops info from do_fault didn't match the
faulting VA in the early part of the message:

---
                                                          vvvvvvvv
Unable to handle kernel paging request at virtual address 0000000c, epc
== 801c883c, ra == 801c8ae0
Oops in fault.c:do_page_fault, line 170:
$0 : 00000000 14001f00 8fde6a6c 8fde6a60 (zero,at,v0,v1)
$4 : 8fddb400 00000003 8fddc000 8d7a53e0 (a0-a3)
$8 : 00000003 00000000 8fe67810 8fde9a40 (t0-t3)
$12: 0000003c 8fe67820 8d7a5340 00000000 (t4-t7)
$16: 8d7a5340 8fddc000 00000001 8d7a5340 (s0-s3)
$20: 8fde2b50 8fde2ba8 8fde2940 8fde2bac (s4-s7)
$24: 8fde4000 2abb5340 8d7a5340 8fde2000 (t8,t9,k0,k1)
$28: 80106000 80107dd8 0000000d 801c8ae0 (gp,sp,fp,ra)
epc    : 00000000801c883c
Status : 14001f03
Cause  : 00808008
BadAddr: 000000008d7a5340 Process swapper (pid: 0, stackpage=80106000)
         ^^^^^^^^^^^^^^^^
---

Seems that the BadVaddr doesn't currently get stuffed into the pt_regs
on the stack for TLB exceptions.  The following patches might be
reasonable:

--- tlbex-r3k.S.orig    Thu Nov  1 10:50:29 2001
+++ tlbex-r3k.S Thu Nov  1 10:50:17 2001
@@ -92,6 +92,7 @@
        .set    macro; \
        SAVE_ALL; \
        mfc0    a2, CP0_BADVADDR; \
+       REG_S   a2, PT_BVADDR(sp); \
        STI; \
        .set    at; \
        move    a0, sp; \



--- tlbex-r4k.S.orig    Thu Nov  1 10:50:44 2001
+++ tlbex-r4k.S Thu Nov  1 10:50:08 2001
@@ -337,6 +337,7 @@
        .set    noat; \
        SAVE_ALL; \
        mfc0    a2, CP0_BADVADDR; \
+       REG_S   a2, PT_BVADDR(sp); \
        STI; \
        .set    at; \
        move    a0, sp; \





--kip
