Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 11:43:36 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56524 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818006Ab3DMJnfpUeQN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 11:43:35 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/2] tty: serial: ralink: fix SERIAL_8250_RT288X dependency
Date:   Sat, 13 Apr 2013 11:39:32 +0200
Message-Id: <1365845973-16164-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36146
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

These 2 patches in this series should be merged via the mips tree. Patch 1/2
requires an Ack from the tty maintainer.

 drivers/tty/serial/8250/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
