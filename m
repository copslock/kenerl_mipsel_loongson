Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 18:54:20 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995089AbdHIQyH7ewjH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2017 18:54:07 +0200
Received: from localhost (unknown [104.132.0.100])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B67AEA95;
        Wed,  9 Aug 2017 16:54:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harvey Hunt <harvey.hunt@imgtec.com>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.12 040/106] MIPS: ralink: Fix build error due to missing header
Date:   Wed,  9 Aug 2017 09:52:24 -0700
Message-Id: <20170809164521.807615682@linuxfoundation.org>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170809164515.714288642@linuxfoundation.org>
References: <20170809164515.714288642@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

4.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harvey Hunt <harvey.hunt@imgtec.com>

commit e3ccf1d1dee5129beb839fe05c61eb134131bdd6 upstream.

Previously, <linux/module.h> was included before ralink_regs.h in all
ralink files - leading to <linux/io.h> being implicitly included.

After commit 26dd3e4ff9ac ("MIPS: Audit and remove any unnecessary
uses of module.h") removed the inclusion of module.h from multiple
places, some ralink platforms failed to build with the following error:

In file included from arch/mips/ralink/mt7620.c:17:0:
./arch/mips/include/asm/mach-ralink/ralink_regs.h: In function ‘rt_sysc_w32’:
./arch/mips/include/asm/mach-ralink/ralink_regs.h:38:2: error: implicit declaration of function ‘__raw_writel’ [-Werror=implicit-function-declaration]
  __raw_writel(val, rt_sysc_membase + reg);
  ^
./arch/mips/include/asm/mach-ralink/ralink_regs.h: In function ‘rt_sysc_r32’:
./arch/mips/include/asm/mach-ralink/ralink_regs.h:43:2: error: implicit declaration of function ‘__raw_readl’ [-Werror=implicit-function-declaration]
  return __raw_readl(rt_sysc_membase + reg);

Fix this by including <linux/io.h>.

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Fixes: 26dd3e4ff9ac ("MIPS: Audit and remove any unnecessary uses of module.h")
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16780/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/mach-ralink/ralink_regs.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/include/asm/mach-ralink/ralink_regs.h
+++ b/arch/mips/include/asm/mach-ralink/ralink_regs.h
@@ -13,6 +13,8 @@
 #ifndef _RALINK_REGS_H_
 #define _RALINK_REGS_H_
 
+#include <linux/io.h>
+
 enum ralink_soc_type {
 	RALINK_UNKNOWN = 0,
 	RT2880_SOC,
