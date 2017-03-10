Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 10:27:07 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40740 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993942AbdCJJ06yjpNY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2017 10:26:58 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0A42B0B;
        Fri, 10 Mar 2017 09:26:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harvey Hunt <harvey.hunt@imgtec.com>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 4.10 001/167] MIPS: pic32mzda: Fix linker error for pic32_get_pbclk()
Date:   Fri, 10 Mar 2017 10:07:24 +0100
Message-Id: <20170310083956.875407591@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170310083956.767605269@linuxfoundation.org>
References: <20170310083956.767605269@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57120
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Purna Chandra Mandal <purna.mandal@microchip.com>

commit a726f1d2dd4fee179aa4513176d688ad309de6cc upstream.

Early clock API pic32_get_pbclk() is defined in early_clk.c and used by
time.c and early_console.c. When CONFIG_EARLY_PRINTK isn't set,
early_clk.c isn't compiled and time.c fails to link.

Fix it by compiling early_clk.c always. Also sort files in alphabetical
order.

Fixes: 6e4ad1b41360 ("MIPS: pic32mzda: fix getting timer clock rate.")
Reported-by: Harvey Hunt <harvey.hunt@imgtec.com>
Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Reviewed-by: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Joshua Henderson <digitalpeer@digitalpeer.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13383/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/pic32/pic32mzda/Makefile |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/mips/pic32/pic32mzda/Makefile
+++ b/arch/mips/pic32/pic32mzda/Makefile
@@ -2,8 +2,7 @@
 # Joshua Henderson, <joshua.henderson@microchip.com>
 # Copyright (C) 2015 Microchip Technology, Inc.  All rights reserved.
 #
-obj-y			:= init.o time.o config.o
+obj-y			:= config.o early_clk.o init.o time.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= early_console.o      \
-				   early_pin.o		\
-				   early_clk.o
+				   early_pin.o
