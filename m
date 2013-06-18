Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 21:13:38 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57470 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827443Ab3FRTNLnxo43 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 21:13:11 +0200
Received: by mail-pa0-f51.google.com with SMTP id lf11so4272361pab.24
        for <multiple recipients>; Tue, 18 Jun 2013 12:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/CZaNWY65/oaSW2r7Ff0wWk364zvEAIZM7YJW44bGX8=;
        b=QkV4SMxyykzVYxE2OTLw6DIz4urYpID9nV66o5Q/NxfhfSnLFZ37ln2RzlaXPQwC+v
         cdeaD31cwg8wMtT0NP8mGdhz04R7kwhzkxrlNmcekVTNniyQjSxn1ZCwPrjpsbA8SoQo
         YDnnp+6yP14Yv2uHcezZjb2vcmgUUp+YoZ3MZi6ozPWek+L3Mbq/FLtpMh29vtbt//6K
         wAnxhBMXfFjUFLbrlorCWKcjcTYkA6Lce8Y2U/KKic4rU/6qDejj168Zt3QK2KZFgscA
         XJovuviMRanRZ72Cwtxyew/sLFWeFebeQWB47629zlU8c0BNl+rCoUnpiO1d0K21/XXn
         92Uw==
X-Received: by 10.68.233.98 with SMTP id tv2mr18130557pbc.146.1371582785201;
        Tue, 18 Jun 2013 12:13:05 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id pe9sm19457372pbc.35.2013.06.18.12.13.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 12:13:04 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5IJD2lV012188;
        Tue, 18 Jun 2013 12:13:02 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5IJD1Es012187;
        Tue, 18 Jun 2013 12:13:01 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 2/5] MIPS: OCTEON: Set proper UART clock in internal device trees.
Date:   Tue, 18 Jun 2013 12:12:52 -0700
Message-Id: <1371582775-12141-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36990
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

Following patch to use generic 8250 drivers will need proper clock
information.  So when using the internal device tree, populate the
"clock-frequency" property with the correct value.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 389512e..7b746e7 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -490,8 +490,15 @@ int __init octeon_prune_device_tree(void)
 
 		if (alias_prop) {
 			uart = fdt_path_offset(initial_boot_params, alias_prop);
-			if (uart_mask & (1 << i))
+			if (uart_mask & (1 << i)) {
+				__be32 f;
+
+				f = cpu_to_be32(octeon_get_io_clock_rate());
+				fdt_setprop_inplace(initial_boot_params,
+						    uart, "clock-frequency",
+						    &f, sizeof(f));
 				continue;
+			}
 			pr_debug("Deleting uart%d\n", i);
 			fdt_nop_node(initial_boot_params, uart);
 			fdt_nop_property(initial_boot_params, aliases,
-- 
1.7.11.7
