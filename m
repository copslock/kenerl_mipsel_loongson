Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 19:38:56 +0000 (GMT)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:36102 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225247AbTCGTiz>; Fri, 7 Mar 2003 19:38:55 +0000
Received: from 10.10.64.123 by mms3.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Fri, 07 Mar 2003 11:27:51 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA01613; Fri, 7 Mar 2003 11:27:33 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h27JRiER009234; Fri, 7 Mar 2003 11:27:44 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id LAA16600; Fri, 7
 Mar 2003 11:27:45 -0800
Message-ID: <3E68F2B1.3413093D@broadcom.com>
Date: Fri, 07 Mar 2003 11:27:45 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: mips64 scall_o32.S fixes?
X-WSS-ID: 12762D3D154913-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips


I assume sys32_syscall should only allow o32 syscalls?  So the #defines
being used were wrong.  And MAX_SYSCALL_NO, although unused, seems to
have the wrong thing in it.

Any disagreement?

Kip

Index: arch/mips64/kernel/scall_o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/scall_o32.S,v
retrieving revision 1.48.2.26
diff -u -r1.48.2.26 scall_o32.S
--- arch/mips64/kernel/scall_o32.S      7 Mar 2003 01:22:48 -0000      
1.48.2.26
+++ arch/mips64/kernel/scall_o32.S      7 Mar 2003 19:26:36 -0000
@@ -23,7 +23,7 @@
 #include <asm/sysmips.h>
 
 /* Highest syscall used of any syscall flavour */
-#define MAX_SYSCALL_NO __NR_Linux32 + __NR_Linux32_syscalls
+#define MAX_SYSCALL_NO __NR_N32_Linux + __NR_N32_Linux_syscalls
 
        .align  5
 NESTED(handle_sys, PT_SIZE, sp)
@@ -263,7 +263,7 @@
 LEAF(sys32_syscall)
        ld      t0, PT_R29(sp)          # user sp
 
-       sltu    v0, a0, __NR_Linux + __NR_Linux_syscalls + 1
+       sltu    v0, a0, __NR_O32_Linux + __NR_O32_Linux_syscalls + 1
        beqz    v0, enosys
 
        dsll    v0, a0, 3
