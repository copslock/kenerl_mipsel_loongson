Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Nov 2002 23:30:14 +0100 (CET)
Received: from [63.70.210.58] ([63.70.210.58]:8199 "EHLO mms1.broadcom.com")
	by linux-mips.org with ESMTP id <S1123974AbSKRWaN>;
	Mon, 18 Nov 2002 23:30:13 +0100
Received: from 63.70.210.1mms1.broadcom.com with ESMTP (Broadcom MMS1
 SMTP Relay (MMS v5.0)); Mon, 18 Nov 2002 14:29:27 -0800
X-Server-Uuid: C4EEB3B0-84E7-41AF-B685-DDB6986D9F7C
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id OAA26720; Mon, 18 Nov 2002 14:29:49 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 gAIMTmER017892; Mon, 18 Nov 2002 14:29:48 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id OAA23468; Mon,
 18 Nov 2002 14:29:48 -0800
Message-ID: <3DD969DC.DC6D31BA@broadcom.com>
Date: Mon, 18 Nov 2002 14:29:48 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
cc: "Ralf Baechle" <ralf@linux-mips.org>
Subject: strncpy etc.
X-WSS-ID: 11C7B64D857954-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips


Looks like a typo in include/asm-mips/string.h has strncpy returning the
wrong thing -- a pointer to the END of the destination string, rather
than the beginning of the destination string.

Patch for 2.4 is below:

Index: include/asm-mips/string.h
===================================================================
RCS file:
/projects/bbp/cvsroot/systemsw/linux/src/kernel/include/asm-mips/string.h,v
retrieving revision 1.6
diff -u -r1.6 string.h
--- string.h    2002/09/05 22:15:51     1.6
+++ string.h    2002/11/18 22:27:15
@@ -67,7 +67,7 @@
         : "0" (__dest), "1" (__src), "2" (__n)
         : "memory");
 
-  return __dest;
+  return __xdest;
 }
 
 #define __HAVE_ARCH_STRCMP
