Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 19:39:43 +0000 (GMT)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:51466 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225247AbTCGTjm>; Fri, 7 Mar 2003 19:39:42 +0000
Received: from 10.10.64.123 by mms3.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Fri, 07 Mar 2003 11:33:28 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA02597; Fri, 7 Mar 2003 11:33:10 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h27JXLER009344; Fri, 7 Mar 2003 11:33:22 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id LAA16615; Fri, 7
 Mar 2003 11:33:22 -0800
Message-ID: <3E68F402.E1DE44C6@broadcom.com>
Date: Fri, 07 Mar 2003 11:33:22 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ralf Baechle" <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: scall_64.S #ifdef fix
X-WSS-ID: 12762B82155170-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips


I think CONFIG_BINFMT_ELF32 would be a better choice since it implies
that O32 or N32 is included, whereas CONFIG_MIPS32_COMPAT doesn't
necessarily imply it.

Kip

Index: arch/mips64/kernel/scall_64.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/scall_64.S,v
retrieving revision 1.20.2.14
diff -u -r1.20.2.14 scall_64.S
--- arch/mips64/kernel/scall_64.S       7 Mar 2003 01:22:48 -0000      
1.20.2.14
+++ arch/mips64/kernel/scall_64.S       7 Mar 2003 19:28:45 -0000
@@ -24,8 +24,8 @@
 
        .align  5
 NESTED(handle_sys64, PT_SIZE, sp)
-/* When 32-bit compatibility is configured scall_o32.S already did
this.  */
-#ifndef CONFIG_MIPS32_COMPAT
+/* When 32-bit binaries are handled scall_[on]32.S already did this. 
*/
+#ifndef CONFIG_BINFMT_ELF32
        .set    noat
        SAVE_SOME
        STI
