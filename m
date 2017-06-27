Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 21:22:36 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:34136
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991087AbdF0TW3s3vQb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 21:22:29 +0200
Received: by mail-wr0-x244.google.com with SMTP id k67so32581937wrc.1;
        Tue, 27 Jun 2017 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zs/ATCTxbVlDzVulIz2C60TJ9Ws/43H4YuQo/To5we0=;
        b=c30PmWjZhHTc0m5i1tum68gL7wQvfuNLezhgvy2gAa9dudOWHbp+65HIWFh8+n+Vsr
         n/VmIw8ULKq47hxDJWIywhA49Zz4uYdLUeTRY++YUBZ++8LWisgjMGo76jr/DDz8DALm
         cE7M4RfWeF4a/dBa1/7SFgs7P1uJoIH1eIw4myuz/CGroHk+js+PRWNoZV9vOZEhk7TL
         4QIYxRwaNQA+stVarAFW0hs14DlUyGsC4tu6LJKD9N2euF2R+xjVpcmxLhejDxIPWqog
         hjVsPdCVXDrYapXxxgA0NWk3oQ+GKUNk1xbKbLj3oz86kfVQBxxe7MLBzT3dawmNgG1z
         od3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zs/ATCTxbVlDzVulIz2C60TJ9Ws/43H4YuQo/To5we0=;
        b=uUMXxk8zDn3eCxiTS0XvZDQ7wZ9+MVM6uOhjd8bTCkJGL6QcRYzEpwSouoMLZdj/rN
         HlJKYM3FpZyIakaV1bHuZU0IztyEyKBXYpMxjRA2IleMwzO26qrhqI/Lhl84qvFSAZhm
         ygbiAtmsGT8fS+/pbwewh+4iC6ZBgEiGGmn2eGoOVNNdCd3fgJjPMBUzAcNk/5MscRFm
         IsaZhXEy7ZeR/io4coEMFGUkz/2MmDsrwij4BbGv6CJqD0m9xWHv5LZ5eZwfz1h+NK7X
         ZfAGKkLhqMg08ys/o1JkCm+8O7jXiQZgD61hFFfGoJ/t4S2o5ONs2DsH6b0ntXJfe4Pt
         4WqQ==
X-Gm-Message-State: AKS2vOwd/8Rh2SX5Ks1dYe+EQm0tHZJzhotXRJ5qmiOU/qoZivVum0om
        b7QKrarBLlVd9xHn
X-Received: by 10.223.171.69 with SMTP id r5mr18933021wrc.57.1498591344145;
        Tue, 27 Jun 2017 12:22:24 -0700 (PDT)
Received: from localhost.localdomain (ppp-seco21parth2-46-193-165-19.wb.wifirst.net. [46.193.165.19])
        by smtp.gmail.com with ESMTPSA id j13sm40182wra.56.2017.06.27.12.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 12:22:22 -0700 (PDT)
From:   Karl Beldan <karl.beldan@gmail.com>
X-Google-Original-From: Karl Beldan <karl.beldan+oss@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Karl Beldan <karl.beldan+oss@gmail.com>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>
Subject: [RESEND PATCH] MIPS: head: Reorder instructions missing a delay slot
Date:   Tue, 27 Jun 2017 19:22:16 +0000
Message-Id: <20170627192216.29364-1-karl.beldan+oss@gmail.com>
X-Mailer: git-send-email 2.10.1
Return-Path: <karl.beldan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58833
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
