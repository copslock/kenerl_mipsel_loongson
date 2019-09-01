Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FC3C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DA42339D
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfIAPyn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:54:43 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:57196 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfIAPyn (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 11:54:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 1B7EA3F73E
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:54:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wrS0PBGj-tZX for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 17:54:41 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 5C96B3F708
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:54:41 +0200 (CEST)
Date:   Sun, 1 Sep 2019 17:54:41 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 047/120] MIPS: PS2: Let the system type be Sony PlayStation 2
Message-ID: <cf9924007a0e9515d3bd18bcca44c8908028b90a.1567326213.git.noring@nocrew.org>
References: <cover.1567326213.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567326213.git.noring@nocrew.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The system type is shown in the /proc/cpuinfo file:

	# grep system' 'type /proc/cpuinfo
	system type		: Sony PlayStation 2

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 arch/mips/ps2/identify.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/ps2/identify.c b/arch/mips/ps2/identify.c
index 264fdc13dc43..579148fb79c4 100644
--- a/arch/mips/ps2/identify.c
+++ b/arch/mips/ps2/identify.c
@@ -9,11 +9,17 @@
 #include <linux/init.h>
 #include <linux/printk.h>
 
+#include <asm/bootinfo.h>
 #include <asm/prom.h>
 
 #include <asm/mach-ps2/rom.h>
 #include <asm/mach-ps2/scmd.h>
 
+const char *get_system_type(void)
+{
+	return "Sony PlayStation 2";
+}
+
 static int __init set_machine_name_by_scmd(void)
 {
 	const struct scmd_machine_name machine = scmd_read_machine_name();
-- 
2.21.0

