Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 02:41:32 +0200 (CEST)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:44922 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835040Ab3FTAkiDMtcQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 02:40:38 +0200
Received: by mail-pd0-f178.google.com with SMTP id w11so5551974pde.23
        for <linux-mips@linux-mips.org>; Wed, 19 Jun 2013 17:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mkCdeayxsJmffUXWwAQuA7YPcrACWWkht2Cy6WH6lSE=;
        b=cZqHmMJGPWlC0m2XgivzQFTeWmFZRwiVp1T8akQFtPqVjDjbXTQmDSsPFexmRjOMGP
         JPy16yHfyAX2JODgbykXn9aNtn9udG/f6DG3x5nSNSCdfVH551/PnQ5t8SaFbr4sBMvQ
         uTWApzptIpYQBprmOhDIrmq0gNyH7uuUFAxOXgN2jJWoJlFFP9KRs/EAzAAf+UTVTSA/
         juDEZd3CV2Ce2TzAwSrcwrWFtQ05mONtQLfj7EhDb3HUQZUvjcOIok8ov345VJPqPbkY
         oc/FW2FdeWBBypszfzza2N6wvysoUVgkFaiY6HeJrL3m/zItKrHI3ObtP66MteGqciaf
         zcog==
X-Received: by 10.66.0.233 with SMTP id 9mr9283801pah.33.1371688831756;
        Wed, 19 Jun 2013 17:40:31 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ix3sm25160387pbc.37.2013.06.19.17.40.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 17:40:31 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5K0eSx4004628;
        Wed, 19 Jun 2013 17:40:28 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5K0eSdr004627;
        Wed, 19 Jun 2013 17:40:28 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] netdev: octeon_mgmt: Fix structure layout for little-endian.
Date:   Wed, 19 Jun 2013 17:40:20 -0700
Message-Id: <1371688820-4585-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The C ABI reverses the bitfield fill order when compiled as
little-endian.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/octeon/octeon_mgmt.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index 1ef4148..622aa75 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -46,17 +46,25 @@
 union mgmt_port_ring_entry {
 	u64 d64;
 	struct {
-		u64    reserved_62_63:2;
+#define RING_ENTRY_CODE_DONE 0xf
+#define RING_ENTRY_CODE_MORE 0x10
+#ifdef __BIG_ENDIAN_BITFIELD
+		u64 reserved_62_63:2;
 		/* Length of the buffer/packet in bytes */
-		u64    len:14;
+		u64 len:14;
 		/* For TX, signals that the packet should be timestamped */
-		u64    tstamp:1;
+		u64 tstamp:1;
 		/* The RX error code */
-		u64    code:7;
-#define RING_ENTRY_CODE_DONE 0xf
-#define RING_ENTRY_CODE_MORE 0x10
+		u64 code:7;
 		/* Physical address of the buffer */
-		u64    addr:40;
+		u64 addr:40;
+#else
+		u64 addr:40;
+		u64 code:7;
+		u64 tstamp:1;
+		u64 len:14;
+		u64 reserved_62_63:2;
+#endif
 	} s;
 };
 
-- 
1.7.11.7
