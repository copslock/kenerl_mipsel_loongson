Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:11 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58416 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbeKUWiBV5Vv- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:01 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 0A7CB20070;
        Thu, 22 Nov 2018 00:38:01 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 02/24] MIPS: OCTEON: setup: make internal functions and data static
Date:   Thu, 22 Nov 2018 00:37:23 +0200
Message-Id: <20181121223745.22792-3-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Make some internal data and functions static to avoid sparse warnings.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index dfb95cffef3e..b6d32570d984 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -72,7 +72,7 @@ static unsigned long long reserve_low_mem;
 DEFINE_SEMAPHORE(octeon_bootbus_sem);
 EXPORT_SYMBOL(octeon_bootbus_sem);
 
-struct octeon_boot_descriptor *octeon_boot_desc_ptr;
+static struct octeon_boot_descriptor *octeon_boot_desc_ptr;
 
 struct cvmx_bootinfo *octeon_bootinfo;
 EXPORT_SYMBOL(octeon_bootinfo);
@@ -351,7 +351,7 @@ EXPORT_SYMBOL(octeon_get_io_clock_rate);
  *
  * @s:	    String to write
  */
-void octeon_write_lcd(const char *s)
+static void octeon_write_lcd(const char *s)
 {
 	if (octeon_bootinfo->led_display_base_addr) {
 		void __iomem *lcd_address =
@@ -373,7 +373,7 @@ void octeon_write_lcd(const char *s)
  *
  * Returns uart	  (0 or 1)
  */
-int octeon_get_boot_uart(void)
+static int octeon_get_boot_uart(void)
 {
 	return (octeon_boot_desc_ptr->flags & OCTEON_BL_FLAG_CONSOLE_UART1) ?
 		1 : 0;
-- 
2.17.0
