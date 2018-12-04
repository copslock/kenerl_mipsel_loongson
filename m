Return-Path: <SRS0=TQVq=ON=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7251BC65BB8
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399912082B
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399912082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeLDUU0 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:20:26 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:41670 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeLDUU0 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 4 Dec 2018 15:20:26 -0500
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id B747FB0038;
        Tue,  4 Dec 2018 22:12:48 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/6] MIPS: OCTEON: octeon-usb: use common gpio_bit definition
Date:   Tue,  4 Dec 2018 22:12:16 +0200
Message-Id: <20181204201220.12667-3-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181204201220.12667-1-aaro.koskinen@iki.fi>
References: <20181204201220.12667-1-aaro.koskinen@iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

cvmx_gpio_bit_cfgx bitfields are indentical on cn70xx and cn73xx,
and also match the default definition. So use that instead.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/octeon-usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index bfdfaf32d2c4..1f730ded5224 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -253,17 +253,17 @@ static int dwc3_octeon_config_power(struct device *dev, u64 base)
 		    && gpio <= 31) {
 			gpio_bit.u64 = cvmx_read_csr(CVMX_GPIO_BIT_CFGX(gpio));
 			gpio_bit.s.tx_oe = 1;
-			gpio_bit.cn73xx.output_sel = (index == 0 ? 0x14 : 0x15);
+			gpio_bit.s.output_sel = (index == 0 ? 0x14 : 0x15);
 			cvmx_write_csr(CVMX_GPIO_BIT_CFGX(gpio), gpio_bit.u64);
 		} else if (gpio <= 15) {
 			gpio_bit.u64 = cvmx_read_csr(CVMX_GPIO_BIT_CFGX(gpio));
 			gpio_bit.s.tx_oe = 1;
-			gpio_bit.cn70xx.output_sel = (index == 0 ? 0x14 : 0x19);
+			gpio_bit.s.output_sel = (index == 0 ? 0x14 : 0x19);
 			cvmx_write_csr(CVMX_GPIO_BIT_CFGX(gpio), gpio_bit.u64);
 		} else {
 			gpio_bit.u64 = cvmx_read_csr(CVMX_GPIO_XBIT_CFGX(gpio));
 			gpio_bit.s.tx_oe = 1;
-			gpio_bit.cn70xx.output_sel = (index == 0 ? 0x14 : 0x19);
+			gpio_bit.s.output_sel = (index == 0 ? 0x14 : 0x19);
 			cvmx_write_csr(CVMX_GPIO_XBIT_CFGX(gpio), gpio_bit.u64);
 		}
 
-- 
2.17.0

