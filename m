Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 13:46:24 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:33155 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817043Ab3DMLqYMRfXi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 13:46:24 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 2/2] tty: serial: ralink: select SERIAL_8250_RT288X when ralink kernel is built
Date:   Sat, 13 Apr 2013 13:42:16 +0200
Message-Id: <1365853336-11241-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36148
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
Changes in V2
* a bogus rebase broke the patch and added the extra select to the wrong platform

 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

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
-- 
1.7.10.4
