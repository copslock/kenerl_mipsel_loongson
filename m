Received:  by oss.sgi.com id <S554054AbRA1QFk>;
	Sun, 28 Jan 2001 08:05:40 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:3079 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554049AbRA1QF3>;
	Sun, 28 Jan 2001 08:05:29 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B29857F9; Sun, 28 Jan 2001 17:05:27 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 21F89EE9C; Sun, 28 Jan 2001 17:05:56 +0100 (CET)
Date:   Sun, 28 Jan 2001 17:05:56 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: [PATCH] save a cyle in LOAD_PTE asm macro
Message-ID: <20010128170556.A19010@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
shouldnt the srl at least stall for a cycle on interlocked CPUs ?

Index: arch/mips/kernel/r4k_misc.S
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/r4k_misc.S,v
retrieving revision 1.10
diff -u -r1.10 r4k_misc.S
--- arch/mips/kernel/r4k_misc.S	2000/12/14 21:39:51	1.10
+++ arch/mips/kernel/r4k_misc.S	2001/01/28 16:03:44
@@ -37,8 +37,8 @@
 	 */
 #define LOAD_PTE(pte, ptr) \
 	mfc0	pte, CP0_BADVADDR; \
-	srl	pte, pte, 22; \
 	lw	ptr, current_pgd; \
+	srl	pte, pte, 22; \
 	sll	pte, pte, 2; \
 	addu	ptr, ptr, pte; \
 	mfc0	pte, CP0_BADVADDR; \

-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
