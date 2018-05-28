Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 13:05:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993256AbeE1LEaKLZU0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 13:04:30 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7F7F2075C;
        Mon, 28 May 2018 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527505464;
        bh=wJbmY9rUByJM0hQt6D5L6aRhiBByFAxbAhV4w2ZNDQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFWNWOhDDdgnzbWVQ9EG9NB5ax4fkxs0UejhoPGAskypj15cEZcjLJNdrkEVtOryu
         NWlsXIlkHu51K+033AzU2HboSEyncBzl0DteHRHceEHz1KDaQGtN5AzGMFEAAMGbAt
         Ga0Lh6jl29XGUxtCB52+5M83Wv4FWDVnUMkP6oSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.16 004/272] MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770
Date:   Mon, 28 May 2018 12:00:37 +0200
Message-Id: <20180528100240.574018305@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64112
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

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Cercueil <paul@crapouillou.net>

commit c60128ce97674fd05adb8b5ae79eb6745a03192e upstream.

The debug definitions were missing for MACH_JZ4770, resulting in a build
failure when DEBUG_ZBOOT was set.

Since the UART addresses are the same across all Ingenic SoCs, we just
use a #ifdef CONFIG_MACH_INGENIC instead of checking for individual
Ingenic SoCs.

Additionally, I added a #define for the UART0 address in-code and
dropped the <asm/mach-jz4740/base.h> include, for the reason that this
include file is slowly being phased out as the whole platform is being
moved to devicetree.

Fixes: 9be5f3e92ed5 ("MIPS: ingenic: Initial JZ4770 support")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.16
Patchwork: https://patchwork.linux-mips.org/patch/18957/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/compressed/uart-16550.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -18,9 +18,9 @@
 #define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
 #endif
 
-#if defined(CONFIG_MACH_JZ4740) || defined(CONFIG_MACH_JZ4780)
-#include <asm/mach-jz4740/base.h>
-#define PORT(offset) (CKSEG1ADDR(JZ4740_UART0_BASE_ADDR) + (4 * offset))
+#ifdef CONFIG_MACH_INGENIC
+#define INGENIC_UART0_BASE_ADDR	0x10030000
+#define PORT(offset) (CKSEG1ADDR(INGENIC_UART0_BASE_ADDR) + (4 * offset))
 #endif
 
 #ifdef CONFIG_CPU_XLR
