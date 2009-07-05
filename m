Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jul 2009 13:07:38 +0200 (CEST)
Received: from woodchuck.wormnet.eu ([77.75.105.223]:55592 "EHLO
	woodchuck.wormnet.eu" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491772AbZGELHb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 5 Jul 2009 13:07:31 +0200
Received: by woodchuck.wormnet.eu (Postfix, from userid 1000)
	id CAE4B35D459; Sun,  5 Jul 2009 12:00:55 +0100 (BST)
Date:	Sun, 5 Jul 2009 12:00:55 +0100
From:	Alexander Clouter <alex@digriz.org.uk>
To:	linux-mips@vger.kernel.org, linux-mips@linux-mips.org
Cc:	tanderson@mvista.com
Subject: [PATCH] kernel: fix MIPS compile for !CONFIG_SMP
Message-ID: <20090705110055.GO2014@woodchuck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: diGriz
X-URL:	http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <alex@digriz.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Commit fc03bc1715ca0ad4ccfe97aab16bcc9e7129c1a4 breaks compiling MIPS
with SMP disabled.  This patch fixes that.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/mips/include/asm/gic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 10292e3..a8f5734 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -20,7 +20,7 @@
 #define GIC_TRIG_EDGE			1
 #define GIC_TRIG_LEVEL			0
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 #define GIC_NUM_INTRS			(24 + NR_CPUS * 2)
 #else
 #define GIC_NUM_INTRS			32
-- 
1.6.3.3
