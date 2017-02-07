Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:08:19 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:35045
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993010AbdBGXFJYZZzI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:05:09 +0100
Received: by mail-wr0-x244.google.com with SMTP id o16so6866493wra.2;
        Tue, 07 Feb 2017 15:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+CTvRhxBSoI4xah/vkTMYwVn480mWd6oO+XwMvzOpw=;
        b=fTeOsHGHYnOtPLSHdVASwM9FEJdQeP6ODpCjJ5THbjCCHuve+k9rcb92HfX4HTC2U9
         ewzzwCyWuvLs5zsGTyDMjiHMTQwXeqEIL4GDfawq4mBIxM3rybZFWJ3Qmt/nitNrnngU
         xY7pbx0VLO6iELyGysNMBgowGTrkK4WARdCzJ6JfCd8FR7eySYa3MuvB3dDLhwvAbRdE
         jbFnzwvF32CqB2Ojl43EHls0GbvOaLpB8VEqkmdXrL0g31PrPqyYWKKLy25BaPi9AfVs
         xqzM4oBtqYZYvwkj/z6F2VpsNtHTlnVDrqPIKV+/bmXLwEcVwC6VWJ03AhHOxkjkdNeZ
         7yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S+CTvRhxBSoI4xah/vkTMYwVn480mWd6oO+XwMvzOpw=;
        b=CtbMaJWE3Kv5Zc+zBOnfQcQjjfBWmRwJJ0OL2WzbbAwEXt8ZZe1s78EKA6cPFW87mu
         sGL3CqQRm6HXnhz7Y7EXyySUAskoA3BuKr8eQIzIagLh77yQiBveEMH+B0nBgOrEOp4p
         FRv5R0CS07nujO6KSdiVyh9NRMvjgZgSwuYK1hAbtmtOSbWmocfvjXYsrvZL+09LzIkx
         9WH2/uf1F6NEhpm//JgxvvlUW6GP6X938Or63sVdv8K1unBYFfQNxBNgaaQR5IZXHWFs
         38PzmO5ye3ejEm45SU8Z22ISQmWPwCBduXKXuK4TQy60SEU3ZuwPlDs2flq8+DK7lsd2
         ImUw==
X-Gm-Message-State: AIkVDXKi1b6mj2fMzufTSgHw0QaWg4oSvRkSQC/s7G7XWschqHD3Kh8IIfJAOakg9c2bhQ==
X-Received: by 10.223.172.17 with SMTP id v17mr16144225wrc.115.1486508704009;
        Tue, 07 Feb 2017 15:05:04 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:05:03 -0800 (PST)
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
Subject: [PATCH net-next v2 10/12] net: liquidio: fix build errors when linux/phy*.h is removed from net/dsa.h
Date:   Tue,  7 Feb 2017 15:03:03 -0800
Message-Id: <20170207230305.18222-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56715
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
Acked-by: Felix Manlunas <felix.manlunas@cavium.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c       | 1 +
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c    | 1 +
 drivers/net/ethernet/cavium/liquidio/octeon_console.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index c12cfa4113cc..591ea6d904d0 100644
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
index 631f1c0f9e4d..0b34d544056a 100644
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
index 42b673dce533..53f38d05f7c2 100644
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
2.9.3
