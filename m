Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 23:29:16 +0200 (CEST)
Received: from mms2.broadcom.com ([63.70.210.59]:4357 "HELO mms2.broadcom.com")
	by linux-mips.org with SMTP id <S1122963AbSIRV3P>;
	Wed, 18 Sep 2002 23:29:15 +0200
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS-2 SMTP Relay (MMS v4.7);); Wed, 18 Sep 2002 14:26:53 -0700
X-Server-Uuid: 2a12fa22-b688-11d4-a6a1-00508bfc9626
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id OAA09736 for <linux-mips@linux-mips.org>; Wed, 18 Sep 2002 14:29:06
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g8ILT6ER017149 for <linux-mips@linux-mips.org>; Wed, 18 Sep 2002 14:29:
 06 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id OAA30892 for
 <linux-mips@linux-mips.org>; Wed, 18 Sep 2002 14:29:06 -0700
Message-ID: <3D88F022.E414C40F@broadcom.com>
Date: Wed, 18 Sep 2002 14:29:06 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: ELF32 problem in mips64 kernel
X-WSS-ID: 11963017334557-01-01
Content-Type: multipart/mixed; 
 boundary=------------896D68375FC4991AF9B1471E
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------896D68375FC4991AF9B1471E
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit

There is a faulty check in include/asm-mips64/elf.h:

in elf_check_arch, the following access to the "e_flags" field is
non-sensical if the binary is ELFCLASS32, because "__h" is typed as an
elf64_hdr (through the elfhdr #define), whose e_flags is in a different
location from an elf32_hdr.

        if ((__h->e_ident[EI_CLASS] == ELFCLASS32) &&     \
            ((__h->e_flags & EF_MIPS_ABI2) == 0))         \
                __res = 0;                                \

Should the n32 check (is this what the EF_MIPS_ABI2 check is about?) be
punted to another binary format handler?  The attached patch removed the
ABI2 check.

Kip
--------------896D68375FC4991AF9B1471E
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
@@ -53,7 +52,8 @@
 /*
  * These are used to set parameters in the core dumps.
  */
-#define ELF_CLASS	ELFCLASS64
+//#define ELF_CLASS	ELFCLASS64
+#define ELF_CLASS	ELFCLASS32
 #ifdef __MIPSEB__
 #define ELF_DATA	ELFDATA2MSB
 #elif __MIPSEL__

--------------896D68375FC4991AF9B1471E--
