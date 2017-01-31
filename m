Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 20:22:58 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:40458
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993911AbdAaTToZed0a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 20:19:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Date:Sender:Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:In-Reply-To; bh=8QN+3RoibFm26SjJiqw0Be4mX8YLJ8qFgJypgutzums=;
        b=S3mfgcD2mKBExW1pDyl9QRqd8dShpO38wdN7g7nRhOjV2uU2sokc4LSbsh7uGOGPwvDoyMbRaGdDMa/3hias1lycWeDgmtu8YiLEEeWHm5WItv/hDIxcvbjI6sXHeTFyDxhWfIaP/tWm+rr2W+1KcCL5VJp45vGVPLuY+j9TsQI=;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:48804 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdxj-0000k4-F9; Tue, 31 Jan 2017 19:19:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdxX-0000X5-Hz; Tue, 31 Jan 2017 19:19:19 +0000
In-Reply-To: <20170131191704.GA8281@n2100.armlinux.org.uk>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>
Subject: [PATCH 4.10-rc3 11/13] net: liquidio: fix build errors when
 linux/phy*.h is removed from net/dsa.h
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1cYdxX-0000X5-Hz@rmk-PC.armlinux.org.uk>
Date:   Tue, 31 Jan 2017 19:19:19 +0000
Return-Path: <rmk+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+kernel@armlinux.org.uk
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

drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: error: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: error: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: error: type defaults to 'int' in declaration of 'MODULE_LICENSE'
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: error: type defaults to 'int' in declaration of 'MODULE_VERSION'
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:36: error: expected ')' before 'int'
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:37: error: expected ')' before string constant
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:325: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:325: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:325: warning: parameter names (without types) in function declaration
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3250: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3250: error: type defaults to 'int' in declaration of 'module_init'
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3250: warning: parameter names (without types) in function declaration
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3251: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3251: error: type defaults to 'int' in declaration of 'module_exit'
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3251: warning: parameter names (without types) in function declaration
drivers/net/ethernet/cavium/liquidio/lio_main.c:36: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:36: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:36: error: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
drivers/net/ethernet/cavium/liquidio/lio_main.c:36: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_main.c:37: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:37: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:37: error: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
drivers/net/ethernet/cavium/liquidio/lio_main.c:37: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_main.c:38: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:38: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:38: error: type defaults to 'int' in declaration of 'MODULE_LICENSE'
drivers/net/ethernet/cavium/liquidio/lio_main.c:38: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_main.c:39: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:39: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:39: error: type defaults to 'int' in declaration of 'MODULE_VERSION'
drivers/net/ethernet/cavium/liquidio/lio_main.c:39: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_main.c:40: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:40: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:40: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
drivers/net/ethernet/cavium/liquidio/lio_main.c:40: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_main.c:41: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:41: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:41: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
drivers/net/ethernet/cavium/liquidio/lio_main.c:41: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_main.c:42: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:42: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:42: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
drivers/net/ethernet/cavium/liquidio/lio_main.c:42: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_main.c:43: error: expected declaration specifiers or '...' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:43: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:43: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
drivers/net/ethernet/cavium/liquidio/lio_main.c:43: error: function declaration isn't a prototype
drivers/net/ethernet/cavium/liquidio/lio_main.c:46: error: expected ')' before 'int'
drivers/net/ethernet/cavium/liquidio/lio_main.c:48: error: expected ')' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:53: error: expected ')' before 'int'
drivers/net/ethernet/cavium/liquidio/lio_main.c:54: error: expected ')' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:57: error: expected ')' before 'sizeof'
drivers/net/ethernet/cavium/liquidio/lio_main.c:58: error: expected ')' before string constant
drivers/net/ethernet/cavium/liquidio/lio_main.c:498: warning: data definitionhas no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:498: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
drivers/net/ethernet/cavium/liquidio/lio_main.c:498: warning: parameter names (without types) in function declaration
drivers/net/ethernet/cavium/liquidio/lio_main.c: In function 'octeon_recv_vf_drv_notice':
drivers/net/ethernet/cavium/liquidio/lio_main.c:4393: error: implicit declaration of function 'try_module_get'
drivers/net/ethernet/cavium/liquidio/lio_main.c:4400: error: implicit declaration of function 'module_put'
drivers/net/ethernet/cavium/liquidio/lio_main.c: At top level:
drivers/net/ethernet/cavium/liquidio/lio_main.c:4670: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:4670: error: type defaults to 'int' in declaration of 'module_init'
drivers/net/ethernet/cavium/liquidio/lio_main.c:4670: warning: parameter names (without types) in function declaration
drivers/net/ethernet/cavium/liquidio/lio_main.c:4671: warning: data definition has no type or storage class
drivers/net/ethernet/cavium/liquidio/lio_main.c:4671: error: type defaults to 'int' in declaration of 'module_exit'
drivers/net/ethernet/cavium/liquidio/lio_main.c:4671: warning: parameter names (without types) in function declaration

Add linux/module.h to both these files.

drivers/net/ethernet/cavium/liquidio/octeon_console.c:40:31: error: expected ')' before 'int'
drivers/net/ethernet/cavium/liquidio/octeon_console.c:42:4: error: expected ')' before string constant

Add linux/moduleparam.h to this file.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c       | 1 +
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c    | 1 +
 drivers/net/ethernet/cavium/liquidio/octeon_console.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 39a9665c9d00..e4dd39440687 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -15,6 +15,7 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
  * NONINFRINGEMENT.  See the GNU General Public License for more details.
  ***********************************************************************/
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/firmware.h>
 #include <net/vxlan.h>
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 70d96c10c673..b98d29827a0d 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -15,6 +15,7 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
  * NONINFRINGEMENT.  See the GNU General Public License for more details.
  ***********************************************************************/
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <net/vxlan.h>
 #include "liquidio_common.h"
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_console.c b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
index 3265e0b7923e..964058c55d47 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_console.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
@@ -18,6 +18,7 @@
 /**
  * @file octeon_console.c
  */
+#include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/crc32.h>
-- 
2.7.4
