Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 13:26:31 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55323 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865314Ab3HHLZAPb0J8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 13:25:00 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 5/5] MIPS: ralink: mt7620: this SoC has ehci and ohci hosts
Date:   Thu,  8 Aug 2013 13:17:52 +0200
Message-Id: <1375960672-32619-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1375960672-32619-1-git-send-email-blogic@openwrt.org>
References: <1375960672-32619-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37467
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

Select the the EHCI and OHCI symbols.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index c528d0c..5f5dad2 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -29,6 +29,8 @@ choice
 
 	config SOC_MT7620
 		bool "MT7620"
+		select USB_ARCH_HAS_OHCI
+		select USB_ARCH_HAS_EHCI
 
 endchoice
 
-- 
1.7.10.4
