Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Apr 2013 16:26:15 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:42027 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835161Ab3DPJQuIjrkq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 11:16:50 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 1/6] DT: add vendor prefixes for Ralink
Date:   Tue, 16 Apr 2013 11:12:37 +0200
Message-Id: <1366103562-21463-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36293
X-Approved-By: ralf@linux-mips.org
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 19e1ef7..6527412 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -41,6 +41,7 @@ onnn	ON Semiconductor Corp.
 picochip	Picochip Ltd
 powervr	PowerVR (deprecated, use img)
 qcom	Qualcomm, Inc.
+ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 realtek Realtek Semiconductor Corp.
 renesas	Renesas Electronics Corporation
-- 
1.7.10.4
