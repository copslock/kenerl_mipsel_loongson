Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 15:58:31 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011443AbbLGO6JwxCUc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 15:58:09 +0100
Received: from localhost (unknown [66.228.68.140])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B7B87A71;
        Mon,  7 Dec 2015 14:58:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.2 042/124] MIPS: CDMM: Add builtin_mips_cdmm_driver() macro
Date:   Mon,  7 Dec 2015 09:55:32 -0500
Message-Id: <20151207144921.778267289@linuxfoundation.org>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <20151207144919.656035367@linuxfoundation.org>
References: <20151207144919.656035367@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50363
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

4.2-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 1b4a5ddb127caf125e14551ebd334be1acf21805 upstream.

Add helper macro builtin_mips_cdmm_driver() for builtin CDMM drivers
that don't do anything special in init and have no exit. The
module_mips_cdmm_driver() helper isn't really appropriate for drivers
that can't be built as a module.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-mips@linux-mips.org
Patchwork: http://patchwork.linux-mips.org/patch/11264/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/cdmm.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/mips/include/asm/cdmm.h
+++ b/arch/mips/include/asm/cdmm.h
@@ -84,6 +84,17 @@ void mips_cdmm_driver_unregister(struct
 	module_driver(__mips_cdmm_driver, mips_cdmm_driver_register, \
 			mips_cdmm_driver_unregister)
 
+/*
+ * builtin_mips_cdmm_driver() - Helper macro for drivers that don't do anything
+ * special in init and have no exit. This eliminates some boilerplate. Each
+ * driver may only use this macro once, and calling it replaces device_initcall
+ * (or in some cases, the legacy __initcall). This is meant to be a direct
+ * parallel of module_mips_cdmm_driver() above but without the __exit stuff that
+ * is not used for builtin cases.
+ */
+#define builtin_mips_cdmm_driver(__mips_cdmm_driver) \
+	builtin_driver(__mips_cdmm_driver, mips_cdmm_driver_register)
+
 /* drivers/tty/mips_ejtag_fdc.c */
 
 #ifdef CONFIG_MIPS_EJTAG_FDC_EARLYCON
