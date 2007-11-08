Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2007 13:28:42 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:13625 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023617AbXKHN2d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Nov 2007 13:28:33 +0000
Received: by nf-out-0910.google.com with SMTP id c10so113713nfd
        for <linux-mips@linux-mips.org>; Thu, 08 Nov 2007 05:28:23 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=QQuB8Z4vHcjj5K/uxSIZRhSFCjxnSwgZIGSGD1Dmphk=;
        b=lXNRy5ShR7HmFQ34nPq/fmPpL07sC+529EgpVxsmRC1AwVwzmRJtnTiBOZRdeS6OxTgovYDZoiATRF86XDBEWn6QWi1JSX5xb2gRk1ElHgrZrQKaX6x0yV7aIMcm8MrmWgBx0yVo8Vo3o/5iWjMbb3n3c+8vay0HMjSbsi1u34k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=XuBsgIkV7kEsFo5cmeKkL7MhFCbPALYMG6DsRZR3WoPHVBjuJdkcATzvtOVoXcEVduy6lwb601yH+PRyovsOP6GtMMWYCmRjUIrOGlaFrcGY7xaEc7CeHaIFw2ugqLkPP9FAlk0RSFELPQ/n/uq7VTbtI+WvTtkqtVrE/rLuaA4=
Received: by 10.78.147.6 with SMTP id u6mr592768hud.1194528503366;
        Thu, 08 Nov 2007 05:28:23 -0800 (PST)
Received: from ?10.0.5.72? ( [80.95.121.137])
        by mx.google.com with ESMTPS id 39sm377699hui.2007.11.08.05.28.20
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Nov 2007 05:28:21 -0800 (PST)
Message-ID: <47330EF3.70002@gmail.com>
Date:	Thu, 08 Nov 2007 14:28:19 +0100
From:	Jiri Olsa <olsajiri@gmail.com>
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
MIME-Version: 1.0
To:	kernel-janitors@vger.kernel.org
CC:	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] MIPS - remove dead config symbols from MIPS code
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <olsajiri@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: olsajiri@gmail.com
Precedence: bulk
X-list: linux-mips

remove dead config symbols from MIPS code
Signed-off-by: Jiri Olsa <olsajiri@gmail.com>

---
 include/asm-mips/pmc-sierra/msp71xx/msp_regs.h |    4 ----
 include/asm-mips/sibyte/board.h                |    1 -
 include/asm-mips/sibyte/swarm.h                |   12 ------------
 include/asm-mips/sn/addrs.h                    |    2 --
 include/asm-mips/sn/agent.h                    |    4 +---
 include/asm-mips/sn/klconfig.h                 |   18 +-----------------
 6 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h b/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h
index 0b56f55..603eb73 100644
--- a/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h
+++ b/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h
@@ -585,11 +585,7 @@
  * UART defines                                                            *
  ***************************************************************************
  */
-#ifndef CONFIG_MSP_FPGA
 #define MSP_BASE_BAUD		25000000
-#else
-#define MSP_BASE_BAUD		6000000
-#endif
 #define MSP_UART_REG_LEN	0x20
 
 /*
diff --git a/include/asm-mips/sibyte/board.h b/include/asm-mips/sibyte/board.h
index da198a1..33028b9 100644
--- a/include/asm-mips/sibyte/board.h
+++ b/include/asm-mips/sibyte/board.h
@@ -20,7 +20,6 @@
 #define _SIBYTE_BOARD_H
 
 #if defined(CONFIG_SIBYTE_SWARM) || defined(CONFIG_SIBYTE_PTSWARM) || \
-    defined(CONFIG_SIBYTE_PT1120) || defined(CONFIG_SIBYTE_PT1125) || \
     defined(CONFIG_SIBYTE_CRHONE) || defined(CONFIG_SIBYTE_CRHINE) || \
     defined(CONFIG_SIBYTE_LITTLESUR)
 #include <asm/sibyte/swarm.h>
diff --git a/include/asm-mips/sibyte/swarm.h b/include/asm-mips/sibyte/swarm.h
index 540865f..86db37e 100644
--- a/include/asm-mips/sibyte/swarm.h
+++ b/include/asm-mips/sibyte/swarm.h
@@ -32,18 +32,6 @@
 #define SIBYTE_HAVE_IDE    1
 #define SIBYTE_DEFAULT_CONSOLE "ttyS0,115200"
 #endif
-#ifdef CONFIG_SIBYTE_PT1120
-#define SIBYTE_BOARD_NAME "PT1120"
-#define SIBYTE_HAVE_PCMCIA 1
-#define SIBYTE_HAVE_IDE    1
-#define SIBYTE_DEFAULT_CONSOLE "ttyS0,115200"
-#endif
-#ifdef CONFIG_SIBYTE_PT1125
-#define SIBYTE_BOARD_NAME "PT1125"
-#define SIBYTE_HAVE_PCMCIA 1
-#define SIBYTE_HAVE_IDE    1
-#define SIBYTE_DEFAULT_CONSOLE "ttyS0,115200"
-#endif
 #ifdef CONFIG_SIBYTE_LITTLESUR
 #define SIBYTE_BOARD_NAME "BCM91250C2 (LittleSur)"
 #define SIBYTE_HAVE_PCMCIA 0
diff --git a/include/asm-mips/sn/addrs.h b/include/asm-mips/sn/addrs.h
index fec9bdd..bef3049 100644
--- a/include/asm-mips/sn/addrs.h
+++ b/include/asm-mips/sn/addrs.h
@@ -19,8 +19,6 @@
 
 #if defined(CONFIG_SGI_IP27)
 #include <asm/sn/sn0/addrs.h>
-#elif defined(CONFIG_SGI_IP35)
-#include <asm/sn/sn1/addrs.h>
 #endif
 
 
diff --git a/include/asm-mips/sn/agent.h b/include/asm-mips/sn/agent.h
index ac4ea85..62ee456 100644
--- a/include/asm-mips/sn/agent.h
+++ b/include/asm-mips/sn/agent.h
@@ -17,9 +17,7 @@
 
 #if defined(CONFIG_SGI_IP27)
 #include <asm/sn/sn0/hub.h>
-#elif defined(CONFIG_SGI_IP35)
-#include <asm/sn/sn1/hub.h>
-#endif	/* !CONFIG_SGI_IP27 && !CONFIG_SGI_IP35 */
+#endif	/* !CONFIG_SGI_IP27 */
 
 /*
  * NIC register macros
diff --git a/include/asm-mips/sn/klconfig.h b/include/asm-mips/sn/klconfig.h
index 96cfd2a..39ddb19 100644
--- a/include/asm-mips/sn/klconfig.h
+++ b/include/asm-mips/sn/klconfig.h
@@ -40,26 +40,10 @@
 //#include <sys/graph.h>
 //#include <sys/xtalk/xbow.h>
 
-#elif defined(CONFIG_SGI_IP35)
-
-#include <asm/sn/sn1/addrs.h>
-#include <sys/sn/router.h>
-#include <sys/graph.h>
-#include <asm/xtalk/xbow.h>
-
-#endif /* !CONFIG_SGI_IP27 && !CONFIG_SGI_IP35 */
-
-#if defined(CONFIG_SGI_IP27) || defined(CONFIG_SGI_IP35)
 #include <asm/sn/agent.h>
 #include <asm/fw/arc/types.h>
 #include <asm/fw/arc/hinv.h>
-#if defined(CONFIG_SGI_IP35)
-// The hack file has to be before vector and after sn0_fru....
-#include <asm/hack.h>
-#include <asm/sn/vector.h>
-#include <asm/xtalk/xtalk.h>
-#endif /* CONFIG_SGI_IP35 */
-#endif /* CONFIG_SGI_IP27 || CONFIG_SGI_IP35 */
+#endif /* CONFIG_SGI_IP27 */
 
 typedef u64  nic_t;
 
