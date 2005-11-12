Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2005 23:38:32 +0000 (GMT)
Received: from smtp2-g19.free.fr ([212.27.42.28]:15233 "EHLO smtp2-g19.free.fr")
	by ftp.linux-mips.org with ESMTP id S8136299AbVKLXgi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2005 23:36:38 +0000
Received: from groumpf (str90-1-82-238-123-182.fbx.proxad.net [82.238.123.182])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 955EF522EC;
	Sun, 13 Nov 2005 00:38:19 +0100 (CET)
Received: from jekyll.groumpf.homeip.net ([192.168.1.1] helo=jekyll)
	by groumpf with esmtp (Exim 4.50)
	id 1Eb4ws-0003IU-G4; Sun, 13 Nov 2005 00:38:18 +0100
Received: from arnaud by jekyll with local (Exim 4.50)
	id 1Eb4ws-00007B-6U; Sun, 13 Nov 2005 00:38:18 +0100
To:	ralf@linux-mips.org
Subject: [PATCH] Fix IP32 sparse warnings
Cc:	linux-mips@linux-mips.org
Message-Id: <E1Eb4ws-00007B-6U@jekyll>
From:	Arnaud Giersch <arnaud.giersch@free.fr>
Date:	Sun, 13 Nov 2005 00:38:18 +0100
Return-Path: <arnaud.giersch@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.giersch@free.fr
Precedence: bulk
X-list: linux-mips

Add __iomem qualifier to crime and mace pointers.

Signed-off-by: Arnaud Giersch <arnaud.giersch@free.fr>
---

 I passed my code through sparse and got some warnings.

 arch/mips/sgi-ip32/crime.c    |    4 ++--
 include/asm-mips/ip32/crime.h |    2 +-
 include/asm-mips/ip32/mace.h  |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/sgi-ip32/crime.c b/arch/mips/sgi-ip32/crime.c
--- a/arch/mips/sgi-ip32/crime.c
+++ b/arch/mips/sgi-ip32/crime.c
@@ -19,8 +19,8 @@
 #include <asm/ip32/crime.h>
 #include <asm/ip32/mace.h>
 
-struct sgi_crime *crime;
-struct sgi_mace *mace;
+struct sgi_crime __iomem *crime;
+struct sgi_mace __iomem *mace;
 
 EXPORT_SYMBOL_GPL(mace);
 
diff --git a/include/asm-mips/ip32/crime.h b/include/asm-mips/ip32/crime.h
--- a/include/asm-mips/ip32/crime.h
+++ b/include/asm-mips/ip32/crime.h
@@ -154,7 +154,7 @@ struct sgi_crime {
 #define CRIME_MEM_ERROR_ECC_REPL_MASK	0xffffffff
 };
 
-extern struct sgi_crime *crime;
+extern struct sgi_crime __iomem *crime;
 
 #define CRIME_HI_MEM_BASE	0x40000000	/* this is where whole 1G of RAM is mapped */
 
diff --git a/include/asm-mips/ip32/mace.h b/include/asm-mips/ip32/mace.h
--- a/include/asm-mips/ip32/mace.h
+++ b/include/asm-mips/ip32/mace.h
@@ -363,6 +363,6 @@ struct sgi_mace {
 	char _pad6[0x80000 - sizeof(struct mace_isa)];
 };
 
-extern struct sgi_mace *mace;
+extern struct sgi_mace __iomem *mace;
 
 #endif /* __ASM_MACE_H__ */
