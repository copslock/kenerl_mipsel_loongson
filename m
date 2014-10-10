Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:31:15 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36774
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011134AbaJJW3SAqY1n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:18 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 07/10] MIPS: lantiq: copy the commandline from the devicetree
Date:   Sat, 11 Oct 2014 00:02:31 +0200
Message-Id: <1412978554-31344-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

This is a regression caused by:
commit afb46f7996e91aeb36e07bc92cf96e8045bec00e
Author: Rob Herring <robh@kernel.org>
Date:   Wed Apr 2 19:07:24 2014 -0500
mips: ralink: convert to use unflatten_and_copy_device_tree

Make the of init code reuse the cmdline defined inside the dts.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/prom.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 157f590..a71dc1a 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -77,6 +77,8 @@ void __init plat_mem_setup(void)
 	 * parsed resulting in our memory appearing
 	 */
 	__dt_setup_arch(__dtb_start);
+
+	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 }
 
 void __init device_tree_init(void)
-- 
1.7.10.4
