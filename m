Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 11:43:54 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56528 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823690Ab3DMJngBRavW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 11:43:36 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/2] tty: serial: ralink: select SERIAL_8250_RT288X when ralink kernel is built
Date:   Sat, 13 Apr 2013 11:39:33 +0200
Message-Id: <1365845973-16164-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365845973-16164-1-git-send-email-blogic@openwrt.org>
References: <1365845973-16164-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36147
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

We need to select SERIAL_8250_RT288X to make the uart work on ralink SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b237c50..da9fd66 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -444,6 +444,7 @@ config RALINK
 	select HAVE_MACH_CLKDEV
 	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
+	select SERIAL_8250_RT288X
 
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
-- 
1.7.10.4
