Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 23:12:47 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:39840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992973AbeBIWLaZJ6LC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Feb 2018 23:11:30 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400BE217B6;
        Fri,  9 Feb 2018 22:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400BE217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>
Subject: [PATCH v3 3/3] MIPS: generic: Enable crc32-mips on r6 configs
Date:   Fri,  9 Feb 2018 22:11:07 +0000
Message-Id: <e4b81bc879867830a74d579e060a9f6d5167de95.1518214143.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
References: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
In-Reply-To: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
References: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

Enable the crc32-mips module on MIPS generic r6 configs, where the
required MIPS r6 CRC instructions may be available.

As well as allowing the CRC instructions to be utilised, this should
also ensure the module gets some build coverage.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc: linux-mips@linux-mips.org
---
Changes in v3:
 - New patch
---
 arch/mips/configs/generic/32r6.config | 2 ++
 arch/mips/configs/generic/64r6.config | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/mips/configs/generic/32r6.config b/arch/mips/configs/generic/32r6.config
index ca606e71f4d0..1a5d5ea4ab2b 100644
--- a/arch/mips/configs/generic/32r6.config
+++ b/arch/mips/configs/generic/32r6.config
@@ -1,2 +1,4 @@
 CONFIG_CPU_MIPS32_R6=y
 CONFIG_HIGHMEM=y
+
+CONFIG_CRYPTO_CRC32_MIPS=y
diff --git a/arch/mips/configs/generic/64r6.config b/arch/mips/configs/generic/64r6.config
index 7cac0339c4d5..5dd8e8503e34 100644
--- a/arch/mips/configs/generic/64r6.config
+++ b/arch/mips/configs/generic/64r6.config
@@ -2,3 +2,5 @@ CONFIG_CPU_MIPS64_R6=y
 CONFIG_64BIT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
+
+CONFIG_CRYPTO_CRC32_MIPS=y
-- 
git-series 0.9.1
