Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 23:38:04 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:59476 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835024Ab3FSVhnavHJt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 23:37:43 +0200
Received: by mail-pa0-f45.google.com with SMTP id bi5so5596136pad.18
        for <multiple recipients>; Wed, 19 Jun 2013 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/CZaNWY65/oaSW2r7Ff0wWk364zvEAIZM7YJW44bGX8=;
        b=CzMUo0n3CpTmAkqPvSDDWKW252/AsD2HZmuZH2M2nDwF9hEYiUXciOxW6nVQTWTBdn
         7C0+MuqqwrdWk4UzgXsiQbhQsOr4kxwIq45HJkzanUzWahbciYbGaInSoxXMxU40y3DV
         tD213fHZpXPO21IqOEsbhpYMckD0OcS8M2m60Wc1RlsTGgJq3UBQMeY3wv7w0KKcdtlE
         B1TAzWGvI0lWlkJFZfA8tt11zTaX2GEa3niTCz8qcBsfXaFHuevtdMk99Ea3pv42fjfy
         bqNw3UyKTvB6GY0YgtfJWY/CvXtuqxQJVwShIz5QvyjgeFwtYlxm3hMG+Z6lqGHVk+Kh
         O1Zw==
X-Received: by 10.66.218.39 with SMTP id pd7mr8444035pac.148.1371677856656;
        Wed, 19 Jun 2013 14:37:36 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ve3sm10986500pbc.14.2013.06.19.14.37.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 14:37:35 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5JLbXZC023956;
        Wed, 19 Jun 2013 14:37:33 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5JLbX4a023955;
        Wed, 19 Jun 2013 14:37:33 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/4] MIPS: OCTEON: Set proper UART clock in internal device trees.
Date:   Wed, 19 Jun 2013 14:37:26 -0700
Message-Id: <1371677849-23912-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1371677849-23912-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371677849-23912-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37021
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
