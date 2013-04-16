Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 08:22:58 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:35952 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816831Ab3DPGW531jBK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 08:22:57 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V2] tty: serial: ralink: fix SERIAL_8250_RT288X dependency
Date:   Tue, 16 Apr 2013 08:18:45 +0200
Message-Id: <1366093125-19352-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36207
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

With every Ralink SoC that we add, we would need to extend the dependency. In
order to make life easier we make the symbol depend on MIPS & RALINK and then
select it from within arch/mips/ralink/.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
Hi Greg,

this patch should go upstream via the mips tree to avoid merge conflicts.
The tty part however requires your Ack.

	John

 arch/mips/Kconfig               |    1 +
 drivers/tty/serial/8250/Kconfig |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c1997db..2e8939f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -441,6 +441,7 @@ config RALINK
 	select SYS_HAS_EARLY_PRINTK
 	select HAVE_MACH_CLKDEV
 	select CLKDEV_LOOKUP
+	select SERIAL_8250_RT288X
 
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 80fe91e..24ea3c8 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -295,8 +295,8 @@ config SERIAL_8250_EM
 	  If unsure, say N.
 
 config SERIAL_8250_RT288X
-	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
-	depends on SERIAL_8250 && (SOC_RT288X || SOC_RT305X || SOC_RT3883)
+	bool
+	depends on SERIAL_8250 && MIPS && RALINK
 	help
 	  If you have a Ralink RT288x/RT305x SoC based board and want to use the
 	  serial port, say Y to this option. The driver can handle up to 2 serial
-- 
1.7.10.4
