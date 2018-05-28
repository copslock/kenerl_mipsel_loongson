Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 12:12:32 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993065AbeE1KMSblT-l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 12:12:18 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B70B7208A2;
        Mon, 28 May 2018 10:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527502332;
        bh=xCo2zLm8AvIohSJ39jIRmh3d7agX5+6OpKI7YNWkzDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3zvnLpoFrlTvNRZxZqihfIQcmTpHuSulm9DJxftiQ5at3BGePRqVym/rmX59E8zi
         dqmuidwjFgrMRN6Ode/huE6DmemcrzOjRJ7Txpr9IBiEQh1X6Oc287uJHsNm/NrJhj
         fF5t+izH345yL9/ez7XKptqGwAsJRtewr37CK7KQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Kresin <dev@kresin.me>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 148/185] MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset
Date:   Mon, 28 May 2018 12:03:09 +0200
Message-Id: <20180528100108.904555680@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64087
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Kresin <dev@kresin.me>

[ Upstream commit 05454c1bde91fb013c0431801001da82947e6b5a ]

According to the QCA u-boot source the "PCIE Phase Lock Loop
Configuration (PCIE_PLL_CONFIG)" register is for all SoCs except the
QCA955X and QCA956X at offset 0x10.

Since the PCIE PLL config register is only defined for the AR724x fix
only this value. The value is wrong since the day it was added and isn't
used by any driver yet.

Signed-off-by: Mathias Kresin <dev@kresin.me>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16048/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -167,7 +167,7 @@
 #define AR71XX_AHB_DIV_MASK		0x7
 
 #define AR724X_PLL_REG_CPU_CONFIG	0x00
-#define AR724X_PLL_REG_PCIE_CONFIG	0x18
+#define AR724X_PLL_REG_PCIE_CONFIG	0x10
 
 #define AR724X_PLL_DIV_SHIFT		0
 #define AR724X_PLL_DIV_MASK		0x3ff
