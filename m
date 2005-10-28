Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2005 05:43:12 +0100 (BST)
Received: from mail18.bluewin.ch ([195.186.19.64]:219 "EHLO mail18.bluewin.ch")
	by ftp.linux-mips.org with ESMTP id S8133354AbVJ1Emz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Oct 2005 05:42:55 +0100
Received: from localhost.localdomain (83.76.99.36) by mail18.bluewin.ch (Bluewin 7.2.068.1)
        id 435E01BB000CB2DB; Fri, 28 Oct 2005 04:43:00 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 7958EFE9F; Fri, 28 Oct 2005 00:42:56 -0400 (EDT)
Date:	Fri, 28 Oct 2005 00:42:56 -0400
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] mips: prom_free_prom_memory() returns `unsigned long'
Message-ID: <20051028044256.GA14758@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	a.othieno@bluewin.ch (Arthur Othieno)
Return-Path: <a.othieno@bluewin.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.othieno@bluewin.ch
Precedence: bulk
X-list: linux-mips

Hi,

Some boards have, eg.:

  arch/mips/momentum/ocelot_3/prom.c:242:void __init prom_free_prom_memory(void)

yet free_initmem() expects a return:

  arch/mips/mm/init.c:285:extern unsigned long prom_free_prom_memory(void);
  arch/mips/mm/init.c:291:	freed = prom_free_prom_memory();

Fix those up and return 0 instead, just like everyone else does.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>

---

 arch/mips/momentum/jaguar_atx/prom.c |    3 ++-
 arch/mips/momentum/ocelot_3/prom.c   |    3 ++-
 arch/mips/pmc-sierra/yosemite/prom.c |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

718345abbb965ef544659d6cb0e90dee1535107b
diff --git a/arch/mips/momentum/jaguar_atx/prom.c b/arch/mips/momentum/jaguar_atx/prom.c
--- a/arch/mips/momentum/jaguar_atx/prom.c
+++ b/arch/mips/momentum/jaguar_atx/prom.c
@@ -236,8 +236,9 @@ void __init prom_init(void)
 #endif
 }
 
-void __init prom_free_prom_memory(void)
+unsigned long __init prom_free_prom_memory(void)
 {
+	return 0;
 }
 
 void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
diff --git a/arch/mips/momentum/ocelot_3/prom.c b/arch/mips/momentum/ocelot_3/prom.c
--- a/arch/mips/momentum/ocelot_3/prom.c
+++ b/arch/mips/momentum/ocelot_3/prom.c
@@ -239,8 +239,9 @@ void __init prom_init(void)
 #endif
 }
 
-void __init prom_free_prom_memory(void)
+unsigned long __init prom_free_prom_memory(void)
 {
+	return 0;
 }
 
 void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
diff --git a/arch/mips/pmc-sierra/yosemite/prom.c b/arch/mips/pmc-sierra/yosemite/prom.c
--- a/arch/mips/pmc-sierra/yosemite/prom.c
+++ b/arch/mips/pmc-sierra/yosemite/prom.c
@@ -132,8 +132,9 @@ void __init prom_init(void)
 	prom_grab_secondary();
 }
 
-void __init prom_free_prom_memory(void)
+unsigned long __init prom_free_prom_memory(void)
 {
+	return 0;
 }
 
 void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
