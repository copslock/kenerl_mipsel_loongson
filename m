Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 19:57:54 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2656 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827443Ab3FRR4ce1Sph (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 19:56:32 +0200
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 18 Jun 2013 10:52:29 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 18 Jun 2013 10:56:10 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 18 Jun 2013 10:56:09 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsc-244.bri.broadcom.com [10.178.5.244]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id EF462F2D72; Tue, 18
 Jun 2013 10:56:07 -0700 (PDT)
From:   "Florian Fainelli" <florian@openwrt.org>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 2/7] MIPS: BCM63XX: select BOOT_RAW
Date:   Tue, 18 Jun 2013 18:55:39 +0100
Message-ID: <1371578144-12794-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371578144-12794-1-git-send-email-florian@openwrt.org>
References: <1371578144-12794-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
X-WSS-ID: 7DDE41D731W38705238-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Enabling BOOT_RAW is mandatory to get a binary image (objcopy from ELF
to binary) to work. This does not affect the ELF kernels which are used
by CFE on BCM63XX DSL platforms, but is going to be necessary to support
BCM63XX on Cable Modem chips such as BCM3368.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 30d200d..27d79ff 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -121,6 +121,7 @@ config BCM47XX
 
 config BCM63XX
 	bool "Broadcom BCM63XX based boards"
+	select BOOT_RAW
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
-- 
1.8.1.2
