Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 19:57:16 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2686 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827468Ab3FRR4bGLEyt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 19:56:31 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 18 Jun 2013 10:52:32 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 18 Jun 2013 10:56:13 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 18 Jun 2013 10:56:13 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsc-244.bri.broadcom.com [10.178.5.244]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 65A61F2D74; Tue, 18
 Jun 2013 10:56:12 -0700 (PDT)
From:   "Florian Fainelli" <florian@openwrt.org>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 5/7] MIPS: BCM63XX: provide a MAC address for BCM3368
 chips
Date:   Tue, 18 Jun 2013 18:55:42 +0100
Message-ID: <1371578144-12794-6-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371578144-12794-1-git-send-email-florian@openwrt.org>
References: <1371578144-12794-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
X-WSS-ID: 7DDE41EA31W38705279-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36982
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

The BCM3368 SoC uses a NVRAM format which is not compatible with the one
used by CFE, provide a default MAC address which is suitable for use and
which is the default one also being used by the bootloader on these
chips.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/nvram.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/bcm63xx/nvram.c b/arch/mips/bcm63xx/nvram.c
index a4b8864..e652e57 100644
--- a/arch/mips/bcm63xx/nvram.c
+++ b/arch/mips/bcm63xx/nvram.c
@@ -42,6 +42,7 @@ void __init bcm63xx_nvram_init(void *addr)
 {
 	unsigned int check_len;
 	u32 crc, expected_crc;
+	u8 hcs_mac_addr[ETH_ALEN] = { 0x00, 0x10, 0x18, 0xff, 0xff, 0xff };
 
 	/* extract nvram data */
 	memcpy(&nvram, addr, sizeof(nvram));
@@ -62,6 +63,15 @@ void __init bcm63xx_nvram_init(void *addr)
 	if (crc != expected_crc)
 		pr_warn("nvram checksum failed, contents may be invalid (expected %08x, got %08x)\n",
 			expected_crc, crc);
+
+	/* Cable modems have a different NVRAM which is embedded in the eCos
+	 * firmware and not easily extractible, give at least a MAC address
+	 * pool.
+	 */
+	if (BCMCPU_IS_3368()) {
+		memcpy(nvram.mac_addr_base, hcs_mac_addr, ETH_ALEN);
+		nvram.mac_addr_count = 2;
+	}
 }
 
 u8 *bcm63xx_nvram_get_name(void)
-- 
1.8.1.2
