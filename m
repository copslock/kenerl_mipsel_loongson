Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 20:23:25 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:40514
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993899AbdAaTWAZ50wa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 20:22:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Date:Sender:Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:In-Reply-To; bh=c03JJ10pC+SPDAGPe8bJ9MXAQQH0PVmPGLGrp6QMUQg=;
        b=PgGN7mxNCnh0PFUs5yK8ds/k9np7GRB+yCdihekWgMxprPTCdDXW/yMjvPOhfETXLnDuuz/DkIi+iFhCmF8MB3/TzNAxRvUrQA7+9d1VHZ5mJCjPYxjUCeZQxFJsimdXsrKBHonS0jUtWHDh/tJKBEH2eDozNY+Bl867AJLPMsE=;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48520 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdxm-0000kA-Qi; Tue, 31 Jan 2017 19:19:35 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdxc-0000XC-N6; Tue, 31 Jan 2017 19:19:24 +0000
In-Reply-To: <20170131191704.GA8281@n2100.armlinux.org.uk>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.10-rc3 12/13] net: ath5k: fix build errors when linux/phy*.h
 is removed from net/dsa.h
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1cYdxc-0000XC-N6@rmk-PC.armlinux.org.uk>
Date:   Tue, 31 Jan 2017 19:19:24 +0000
Return-Path: <rmk+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56563
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

Fix these errors reported by the 0-day builder by replacing the
linux/export.h include with linux/module.h.

In file included from include/linux/platform_device.h:14:0,
                 from drivers/net/wireless/ath/ath5k/ahb.c:20:
include/linux/device.h:1463:1: warning: data definition has no type or storage class
 module_init(__driver##_init); \
 ^
include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(ath_ahb_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
include/linux/device.h:1463:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
 module_init(__driver##_init); \
 ^
include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(ath_ahb_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath5k/ahb.c:233:1: warning: parameter names (without types) in function declaration
In file included from include/linux/platform_device.h:14:0,
                 from drivers/net/wireless/ath/ath5k/ahb.c:20:
include/linux/device.h:1468:1: warning: data definition has no type or storage class
 module_exit(__driver##_exit);
 ^
include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(ath_ahb_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
include/linux/device.h:1468:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
 module_exit(__driver##_exit);
 ^
include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(ath_ahb_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath5k/ahb.c:233:1: warning: parameter names (without types) in function declaration
In file included from include/linux/platform_device.h:14:0,
                 from drivers/net/wireless/ath/ath5k/ahb.c:20:
drivers/net/wireless/ath/ath5k/ahb.c:233:24: warning: 'ath_ahb_driver_exit' defined but not used [-Wunused-function]
 module_platform_driver(ath_ahb_driver);
                        ^
include/linux/device.h:1464:20: note: in definition of macro 'module_driver'
 static void __exit __driver##_exit(void) \
                    ^~~~~~~~
drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(ath_ahb_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath5k/ahb.c:233:24: warning: 'ath_ahb_driver_init' defined but not used [-Wunused-function]
 module_platform_driver(ath_ahb_driver);
                        ^
include/linux/device.h:1459:19: note: in definition of macro 'module_driver'
 static int __init __driver##_init(void) \
                   ^~~~~~~~
drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(ath_ahb_driver);
 ^~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/wireless/ath/ath5k/ahb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/ahb.c b/drivers/net/wireless/ath/ath5k/ahb.c
index 2ca88b593e4c..c0794f5988b3 100644
--- a/drivers/net/wireless/ath/ath5k/ahb.c
+++ b/drivers/net/wireless/ath/ath5k/ahb.c
@@ -16,10 +16,10 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
+#include <linux/module.h>
 #include <linux/nl80211.h>
 #include <linux/platform_device.h>
 #include <linux/etherdevice.h>
-#include <linux/export.h>
 #include <ath25_platform.h>
 #include "ath5k.h"
 #include "debug.h"
-- 
2.7.4
