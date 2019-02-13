Return-Path: <SRS0=gFuS=QU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD96C282CE
	for <linux-mips@archiver.kernel.org>; Wed, 13 Feb 2019 02:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DA921934
	for <linux-mips@archiver.kernel.org>; Wed, 13 Feb 2019 02:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025950;
	bh=vU9FBR8zMZmPYzMM+UQCbhw06l0bFoddS/mbVyVQNtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k3bqSNFFlfQ0kK75uJaEox7xE2C+HBSEZ0AyvFjRRcF9RNmBlGeS3ZXlRUXTJmHra
	 egygEJBLHDP3alPR5xHjL+QDwKCDB9JawlwvPMD6xEX7++RaFbRvClpKWz0Fr2PHe2
	 NtWamXGPUb9Ux8pCf3iiJrJnil1OiUv1TbMTNGJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbfBMCk5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389113AbfBMCk4 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5B3B222C2;
        Wed, 13 Feb 2019 02:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025655;
        bh=vU9FBR8zMZmPYzMM+UQCbhw06l0bFoddS/mbVyVQNtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1B0sEluD5BmDgpvoCyNKl2sttJFXzwg1PpDPE9If90qw5Ae8QbFn/7ZXat6/LcjK
         phPco5oEr3AU4tM3/ZDsyEKtGDy4oM3agDifb0z1+4u289bkGzEMd2FpV9JzL/97PL
         4AiXJKLCq/AJbMHek8PcmFED41R15uD0VE/mUSEs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Paul Burton <paul.burton@mips.com>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 11/21] MIPS: ath79: Enable OF serial ports in the default config
Date:   Tue, 12 Feb 2019 21:40:30 -0500
Message-Id: <20190213024040.21740-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024040.21740-1-sashal@kernel.org>
References: <20190213024040.21740-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Alban Bedel <albeu@free.fr>

[ Upstream commit 565dc8a4f55e491935bfb04866068d21784ea9a4 ]

CONFIG_SERIAL_OF_PLATFORM is needed to get a working console on the OF
boards, enable it in the default config to get a working setup out of
the box.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/configs/ath79_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index 134879c1310a..4ed369c0ec6a 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -74,6 +74,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=1
 CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_AR933X=y
 CONFIG_SERIAL_AR933X_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-- 
2.19.1

