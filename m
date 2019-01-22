Return-Path: <SRS0=jHXZ=P6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421D9C282C3
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F68B21019
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="OFRgpWlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfAVNMc (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:12:32 -0500
Received: from forward102o.mail.yandex.net ([37.140.190.182]:44488 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728305AbfAVNMc (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 08:12:32 -0500
Received: from mxback15o.mail.yandex.net (mxback15o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::66])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 5998B6681A91;
        Tue, 22 Jan 2019 16:06:55 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback15o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id VMsj4N6Pih-6txKBoC2;
        Tue, 22 Jan 2019 16:06:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548162415;
        bh=oYvH4eSIBX+qrlmucTvRQzppVm0dlIcMtOM4kKD3tVQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=OFRgpWlCuSUlBQnSz0axjT5o5yEs6GmarvsFRhjkp/V4dphTHU8zD9LlSrfZAXOmZ
         10iSs4PgvXfmRRu5IN4rNjrB0it+Ed5I3UznFvdu7FnbMJ3A2j1eV+PQWQhj0lT2Ny
         C82fOL8LqJ6bL9FXfU4rbnlW1QD7mOICECHx76e8=
Authentication-Results: mxback15o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nEDDgaQwiv-6geeoi1o;
        Tue, 22 Jan 2019 16:06:49 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     keguang.zhang@gmail.com, paul.burton@mips.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 6/6] cpu-probe: Rename Loongson 1B to Loongson GS232
Date:   Tue, 22 Jan 2019 21:04:15 +0800
Message-Id: <20190122130415.3440-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
References: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The Loongson-1A/1B/1C are shareing the same PRID.
Rename previous Loongson 1B to the core used in these
processors.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/cpu.h         | 2 +-
 arch/mips/kernel/cpu-probe.c        | 4 ++--
 arch/mips/loongson32/common/setup.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 532b49b1dbb3..b37c1be08dbd 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -241,7 +241,7 @@
 #define PRID_REV_VR4181A		0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130			0x0080
 #define PRID_REV_34K_V1_0_2		0x0022
-#define PRID_REV_LOONGSON1B		0x0020
+#define PRID_REV_LOONGSON_GS232		0x0020
 #define PRID_REV_LOONGSON1C		0x0020	/* Same as Loongson-1B */
 #define PRID_REV_LOONGSON2E		0x0002
 #define PRID_REV_LOONGSON2F		0x0003
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 95b18a194f53..64bf2a971012 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1546,8 +1546,8 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_LOONGSON1;
 
 		switch (c->processor_id & PRID_REV_MASK) {
-		case PRID_REV_LOONGSON1B:
-			__cpu_name[cpu] = "Loongson 1B";
+		case PRID_REV_LOONGSON_GS232:
+			__cpu_name[cpu] = "Loongson GS232";
 			break;
 		}
 
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 1640744288ee..a1cb26dfc366 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -21,7 +21,7 @@ const char *get_system_type(void)
 	unsigned int processor_id = (&current_cpu_data)->processor_id;
 
 	switch (processor_id & PRID_REV_MASK) {
-	case PRID_REV_LOONGSON1B:
+	case PRID_REV_LOONGSON_GS232:
 #if defined(CONFIG_LOONGSON1_LS1B)
 		return "LOONGSON LS1B";
 #elif defined(CONFIG_LOONGSON1_LS1C)
-- 
2.20.1

