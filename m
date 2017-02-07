Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:08:41 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:35051
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992209AbdBGXFPj5O1I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:05:15 +0100
Received: by mail-wr0-x244.google.com with SMTP id o16so6866708wra.2;
        Tue, 07 Feb 2017 15:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ejdNYuW5XU/gpF6n/x7JeRHJ7pm+/YFSwYWMnOLMCL8=;
        b=uYHvWvNk7aLKWr7pCT4kGmlgSPdqF8rZQi+EdwBWEk3C3OIh6eHn7jUpLEW0ldTHqm
         YqMhVo9YyEafY7qtjk5tTQwM0tH+8uEihTL3lIz2uaGdQKLSilcdnLaoWhfEW7xBA7go
         hO0aihqg5BGrBY9YGUiUnnfdQkneB3vcv/+EpqMuz6r9cL1vg4sBr7za7puEVwWShwMl
         lw99CCfYXbO6kA/7A/aeP4JEJrWUqgbKrhYUp6WaueRTZU7OyXod4/rWWhuRWaeMvef9
         Y4Knm3J+3atfhHaiH+2SSdsoYxl4W77IfFy2efSp5EK/70mIy4Tol2gDrrNpB5w0N1/F
         jIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ejdNYuW5XU/gpF6n/x7JeRHJ7pm+/YFSwYWMnOLMCL8=;
        b=MIUi+nnvcWEX3sEF6QH4GoBMGFwQWenJZnDDcyboC+Q+P+UIWsBGGAJwlftd7/oc4x
         uQrn1lFtX8FzbHQBRi6XHgg56ce8S4N0euJC4/JH4O5c8pVDeyx77Kj2TNjN2w34faR2
         gFznBeeQHzPPLTDDxcawc4Rx8zktHqlNzv6D8kJ2quzUWWiheNNC5SA7wGqV7ErODZNS
         EN+0brkzOexmE8elH4Bx2LVSEF7AZeTeykNSdMaA/JGW7OmdZiy09/GHbSTvK/SlWx2K
         u5VQZuvMLclVKKtmLic75XJoqkdeRPraEySXo6bihcEewR9/f4L8lP60ZsjSMapdTSkJ
         v4lA==
X-Gm-Message-State: AIkVDXLmHHvrF6a2xZ5TMZzdF0ZFjPLip3Cs1Mtstknkk63fzba32GnFuLm9GxfgKmJKEA==
X-Received: by 10.223.164.207 with SMTP id h15mr15778302wrb.142.1486508710260;
        Tue, 07 Feb 2017 15:05:10 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:05:09 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jiri Slaby <jirislaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Timur Tabi <timur@codeaurora.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next v2 11/12] net: ath5k: fix build errors when linux/phy*.h is removed from net/dsa.h
Date:   Tue,  7 Feb 2017 15:03:04 -0800
Message-Id: <20170207230305.18222-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Russell King <rmk+kernel@armlinux.org.uk>

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
Acked-by: Kalle Valo <kvalo@codeaurora.org>
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
2.9.3
