Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 21:11:38 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:35067
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991087AbdF0TLbPcRbb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 21:11:31 +0200
Received: by mail-wm0-x241.google.com with SMTP id 131so7517800wmq.2
        for <linux-mips@linux-mips.org>; Tue, 27 Jun 2017 12:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zs/ATCTxbVlDzVulIz2C60TJ9Ws/43H4YuQo/To5we0=;
        b=MIIEhCx5DwKp3ywYmEJk0QAzdBydLjXDbBgqHWCSkKqEUM5841i7RHW6l9umYrS0RB
         5G+SjrktT8TDBWIUNUCDJuBY496qNxM0ypfvkIM4iS/6/tr9HRJXO43pQX7PpB6hgQTX
         Y4E49Anf7XHAm+eqDS0q8ARyvUgPx4d6zXxyUmKllXbs751W6zHFyJtchOc9gvk5J4Th
         y4Fp2IcK+8XozAQegsUl94VhkWjC3rk5J/HtYZOW/QeqIhCT8dkTiyC9M6CMJBWHlceM
         eKUCZp1VxGc9n7dZ8e5JuGi/NreTKlkaCAEOjn5btcaEMbwKy424XAdcBc5Kz/Dn0h/g
         C4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zs/ATCTxbVlDzVulIz2C60TJ9Ws/43H4YuQo/To5we0=;
        b=G93W9qVn9IIa+2qKBMT58/9WeWtZaleUdxoKCmdZhRF82Yo2q9lyQbJt7Nu9TCgyJ1
         kVIkrkkQkUFDFTPX9TQnH9fzjsUNUwc0n9dKPL8k1/NExsGDD6P1T0NzQiNCB4499k6K
         aqi6AGKKqUoq0s3KTPl7Tq1MBs787KM6ZnqH4uZ3vGJFYE2ftCXF1/ry2/QHSGWyQG4z
         BKIAJygheukik/r7MWZl6bUikJL6UHvtJrd7eEpsBB8Xl2RYFU89uTaGUDcBttZQmOCW
         lv3HMO6XczbnHCDNp7E4PieB71X4XkDv7Hj8SVwKhvLyjsTrFqFzomMgKgVFhN0449hS
         JsAQ==
X-Gm-Message-State: AKS2vOx/Ms0PNywFoYZ6GuvxFq+C+5QonasLJ3+SnkZFDtfeGSJnTeoD
        KFRw9WKf/sgCXz8N
X-Received: by 10.28.103.132 with SMTP id b126mr4826038wmc.10.1498590683913;
        Tue, 27 Jun 2017 12:11:23 -0700 (PDT)
Received: from localhost.localdomain (ppp-seco21parth2-46-193-165-19.wb.wifirst.net. [46.193.165.19])
        by smtp.gmail.com with ESMTPSA id t8sm32968wrc.28.2017.06.27.12.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 12:11:23 -0700 (PDT)
From:   Karl Beldan <karl.beldan@gmail.com>
X-Google-Original-From: Karl Beldan <karl.beldan+oss@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: head: Reorder instructions missing a delay slot
Date:   Tue, 27 Jun 2017 19:11:09 +0000
Message-Id: <20170627191109.28917-1-karl.beldan+oss@gmail.com>
X-Mailer: git-send-email 2.10.1
Return-Path: <karl.beldan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karl.beldan@gmail.com
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

In this sequence the 'move' is assumed in the delay slot of the 'beq',
but head.S is in reorder mode and the former gets pushed one 'nop'
farther by the assembler.

The corrected behavior made booting with an UHI supplied dtb erratic.

Fixes: 15f37e158892 ("MIPS: store the appended dtb address in a variable")
Cc: <stable@vger.kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jonas Gorski <jogo@openwrt.org>
Signed-off-by: Karl Beldan <karl.beldan+oss@gmail.com>
---
 arch/mips/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index cf05220..d1bb506 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -106,8 +106,8 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	beq		t0, t1, dtb_found
 #endif
 	li		t1, -2
-	beq		a0, t1, dtb_found
 	move		t2, a1
+	beq		a0, t1, dtb_found
 
 	li		t2, 0
 dtb_found:
-- 
2.10.1
