Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 23:32:18 +0200 (CEST)
Received: from mms3.broadcom.com ([63.70.210.38]:21000 "HELO mms3.broadcom.com")
	by linux-mips.org with SMTP id <S1122963AbSIRVcR>;
	Wed, 18 Sep 2002 23:32:17 +0200
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7);); Wed, 18 Sep 2002 14:32:09 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id OAA10415 for <linux-mips@linux-mips.org>; Wed, 18 Sep 2002 14:32:09
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g8ILW9ER017217 for <linux-mips@linux-mips.org>; Wed, 18 Sep 2002 14:32:
 09 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id OAA30901 for
 <linux-mips@linux-mips.org>; Wed, 18 Sep 2002 14:32:09 -0700
Message-ID: <3D88F0D9.7144D898@broadcom.com>
Date: Wed, 18 Sep 2002 14:32:09 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: ELF32 problem in mips64 kernel
References: <3D88F022.E414C40F@broadcom.com>
X-WSS-ID: 11962F53967367-01-01
Content-Type: multipart/mixed; 
 boundary=------------353DF670F08FCA3D5852D827
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------353DF670F08FCA3D5852D827
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit

OK, so I didn't mean to include the debugging garbage in that patch :-)

Take 2.

Kip
--------------353DF670F08FCA3D5852D827
Content-Type: text/plain; 
 charset=us-ascii; 
 name=elf.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; 
 filename=elf.patch

Index: include/asm-mips64/elf.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/elf.h,v
retrieving revision 1.10.2.2
diff -u -r1.10.2.2 elf.h
--- include/asm-mips64/elf.h	2002/08/20 18:42:37	1.10.2.2
+++ include/asm-mips64/elf.h	2002/09/18 21:19:42
@@ -43,8 +43,7 @@
 									\
 	if (__h->e_machine != EM_MIPS)					\
 		__res = 0;						\
-	if ((__h->e_ident[EI_CLASS] == ELFCLASS32) &&			\
-	    ((__h->e_flags & EF_MIPS_ABI2) == 0))			\
+	if (__h->e_ident[EI_CLASS] == ELFCLASS32) 			\
 		__res = 0;						\
 									\
 	__res;								\

--------------353DF670F08FCA3D5852D827--
