Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 13:12:45 +0000 (GMT)
Received: from mgw1.diku.dk ([130.225.96.91]:26839 "EHLO mgw1.diku.dk")
	by ftp.linux-mips.org with ESMTP id S23905403AbYKYNMg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 13:12:36 +0000
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id D5F3652C313;
	Tue, 25 Nov 2008 14:12:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9hHambDzlz6m; Tue, 25 Nov 2008 14:12:32 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 3879452C31F;
	Tue, 25 Nov 2008 14:12:32 +0100 (CET)
Received: from pc-004.diku.dk (pc-004.diku.dk [130.225.97.4])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7D0DE6DFAB2; Tue, 25 Nov 2008 14:10:25 +0100 (CET)
Received: by pc-004.diku.dk (Postfix, from userid 3767)
	id 0FB0B9C4D4; Tue, 25 Nov 2008 14:12:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by pc-004.diku.dk (Postfix) with ESMTP id 0D49B9C14A;
	Tue, 25 Nov 2008 14:12:32 +0100 (CET)
Date:	Tue, 25 Nov 2008 14:12:32 +0100 (CET)
From:	Julia Lawall <julia@diku.dk>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/5] arch/mips/alchemy: change strict_strtol to strict_strtoul
Message-ID: <Pine.LNX.4.64.0811251412010.11897@pc-004.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

Since memsize is unsigned, it would seem better to use strict_strtoul that
strict_strtol.

A simplified version of the semantic patch that makes this change is as
follows: (http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@s2@
long e;
position p;
@@

strict_strtol@p(...,&e)

@@
position p != s2.p;
type T;
T e;
@@

- strict_strtol@p
+ strict_strtoul
  (...,&e)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

 arch/mips/alchemy/db1x00/init.c  |    2 +-
 arch/mips/alchemy/mtx-1/init.c   |    2 +-
 arch/mips/alchemy/pb1000/init.c  |    2 +-
 arch/mips/alchemy/pb1100/init.c  |    2 +-
 arch/mips/alchemy/pb1200/init.c  |    2 +-
 arch/mips/alchemy/pb1500/init.c  |    2 +-
 arch/mips/alchemy/pb1550/init.c  |    2 +-
 arch/mips/alchemy/xxs1500/init.c |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff -u -p a/arch/mips/alchemy/db1x00/init.c b/arch/mips/alchemy/db1x00/init.c
--- a/arch/mips/alchemy/db1x00/init.c
+++ b/arch/mips/alchemy/db1x00/init.c
@@ -57,6 +57,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		strict_strtol(memsize_str, 0, &memsize);
+		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff -u -p a/arch/mips/alchemy/mtx-1/init.c b/arch/mips/alchemy/mtx-1/init.c
--- a/arch/mips/alchemy/mtx-1/init.c
+++ b/arch/mips/alchemy/mtx-1/init.c
@@ -55,6 +55,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		strict_strtol(memsize_str, 0, &memsize);
+		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff -u -p a/arch/mips/alchemy/pb1000/init.c b/arch/mips/alchemy/pb1000/init.c
--- a/arch/mips/alchemy/pb1000/init.c
+++ b/arch/mips/alchemy/pb1000/init.c
@@ -52,6 +52,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		strict_strtol(memsize_str, 0, &memsize);
+		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff -u -p a/arch/mips/alchemy/pb1100/init.c b/arch/mips/alchemy/pb1100/init.c
--- a/arch/mips/alchemy/pb1100/init.c
+++ b/arch/mips/alchemy/pb1100/init.c
@@ -54,7 +54,7 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		strict_strtol(memsize_str, 0, &memsize);
+		strict_strtoul(memsize_str, 0, &memsize);
 
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff -u -p a/arch/mips/alchemy/pb1200/init.c b/arch/mips/alchemy/pb1200/init.c
--- a/arch/mips/alchemy/pb1200/init.c
+++ b/arch/mips/alchemy/pb1200/init.c
@@ -53,6 +53,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x08000000;
 	else
-		strict_strtol(memsize_str, 0, &memsize);
+		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff -u -p a/arch/mips/alchemy/pb1500/init.c b/arch/mips/alchemy/pb1500/init.c
--- a/arch/mips/alchemy/pb1500/init.c
+++ b/arch/mips/alchemy/pb1500/init.c
@@ -53,6 +53,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		strict_strtol(memsize_str, 0, &memsize);
+		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff -u -p a/arch/mips/alchemy/pb1550/init.c b/arch/mips/alchemy/pb1550/init.c
--- a/arch/mips/alchemy/pb1550/init.c
+++ b/arch/mips/alchemy/pb1550/init.c
@@ -53,6 +53,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x08000000;
 	else
-		strict_strtol(memsize_str, 0, &memsize);
+		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff -u -p a/arch/mips/alchemy/xxs1500/init.c b/arch/mips/alchemy/xxs1500/init.c
--- a/arch/mips/alchemy/xxs1500/init.c
+++ b/arch/mips/alchemy/xxs1500/init.c
@@ -53,6 +53,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		strict_strtol(memsize_str, 0, &memsize);
+		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
