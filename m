Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2015 15:37:46 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:60837 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009381AbbC2NhorUzU0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Mar 2015 15:37:44 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (Postfix) with ESMTPS id 31C1D8E3F4;
        Sun, 29 Mar 2015 13:37:43 +0000 (UTC)
Received: from redhat.com (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id t2TDbZjI025378;
        Sun, 29 Mar 2015 09:37:38 -0400
Date:   Sun, 29 Mar 2015 15:37:34 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 03/86] mips/netlogic: use uapi/linux/pci_ids.h directly
Message-ID: <1427635734-24786-4-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/mips/netlogic/xlp/ahci-init-xlp2.c | 2 +-
 arch/mips/netlogic/xlp/usb-init-xlp2.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/xlp/ahci-init-xlp2.c b/arch/mips/netlogic/xlp/ahci-init-xlp2.c
index c83dbf3..c11b65d 100644
--- a/arch/mips/netlogic/xlp/ahci-init-xlp2.c
+++ b/arch/mips/netlogic/xlp/ahci-init-xlp2.c
@@ -39,7 +39,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/bitops.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/nodemask.h>
 
 #include <asm/cpu.h>
diff --git a/arch/mips/netlogic/xlp/usb-init-xlp2.c b/arch/mips/netlogic/xlp/usb-init-xlp2.c
index 17ade1c..5781d9e 100644
--- a/arch/mips/netlogic/xlp/usb-init-xlp2.c
+++ b/arch/mips/netlogic/xlp/usb-init-xlp2.c
@@ -37,7 +37,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 
-- 
MST
