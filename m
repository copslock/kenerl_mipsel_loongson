Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 17:09:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:47100 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822085AbaDHPJJ7cHob (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 17:09:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1ECE95E8EA1AA
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 16:09:01 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 16:09:03 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 16:09:02 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/2] MIPS: sead3: Enable DEVTMPFS
Date:   Tue, 8 Apr 2014 16:09:03 +0100
Message-ID: <1396969743-454-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396969743-454-1-git-send-email-markos.chandras@imgtec.com>
References: <1396969743-454-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

This is similar to 68f30ba7f8b9d666d1218eec97822ade0f23d9c3
"MIPS: Malta: Enable DEVTMPFS"

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/configs/sead3_defconfig      | 1 +
 arch/mips/configs/sead3micro_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/configs/sead3_defconfig b/arch/mips/configs/sead3_defconfig
index 3646498..dae9354 100644
--- a/arch/mips/configs/sead3_defconfig
+++ b/arch/mips/configs/sead3_defconfig
@@ -31,6 +31,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
diff --git a/arch/mips/configs/sead3micro_defconfig b/arch/mips/configs/sead3micro_defconfig
index 60bc094..cd91a77 100644
--- a/arch/mips/configs/sead3micro_defconfig
+++ b/arch/mips/configs/sead3micro_defconfig
@@ -32,6 +32,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
-- 
1.9.1
