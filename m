Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jul 2014 07:10:18 +0200 (CEST)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:43756 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815804AbaGSFKPhFOqg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jul 2014 07:10:15 +0200
Received: by mail-ig0-f179.google.com with SMTP id h18so1317269igc.12
        for <multiple recipients>; Fri, 18 Jul 2014 22:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/nE79YSliIq+97YSPwUWyIq+6nEDmfUW9ay2BOIqYAU=;
        b=L3OKQ7fVlseLpH8VnijMsBsjkbtfuBHDAN6k1CuFTCRFw/m83IO6g2+XTISuhDmQNh
         5h06dTDl+cXzEeOIGr7rOsOloaf4JYTppx0BVxVgZFSYcSx4M0OrJLXqquTHJgfto/r1
         K/8a3xqM+fe9NXdHRgphUu4qjl+c/mq0QGhxLwmcN6fBh0rI2ZC8xDDIWv/ZOtVyabVL
         nBA9TqULXZtDcM2dvQc4nd5nrbBAQescmhwp4JtNnKbYGi8y1YjGWqrIZsZL4E69O8N/
         ca0Sk1EVdzdSXp6OlaMoHU7AYt8QH46zU0Jxqxs5CkdwXL0y/xWq99jIZ9rGyOc4Vwsh
         Nc7w==
X-Received: by 10.42.212.207 with SMTP id gt15mr13285040icb.47.1405746609199;
        Fri, 18 Jul 2014 22:10:09 -0700 (PDT)
Received: from nick-System-Product-Name.phub.net.cable.rogers.com (CPE0026f3330aca-CM0026f3330ac6.cpe.net.cable.rogers.com. [99.232.64.167])
        by mx.google.com with ESMTPSA id i10sm13188442igm.13.2014.07.18.22.10.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Jul 2014 22:10:08 -0700 (PDT)
From:   Nicholas Krause <xerofoify@gmail.com>
To:     ralf@linux-mips.org
Cc:     paul.burton@imgtec.com, Leonid.Yegoshin@imgtec.com,
        markos.chandras@imgtec.com, Steven.Hill@imgtec.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: Remove uneeded line in cmp_smp_finish
Date:   Sat, 19 Jul 2014 01:10:04 -0400
Message-Id: <1405746604-7737-1-git-send-email-xerofoify@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

This patch removes a unneeded line from this file as stated by the
fix me in this file.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/mips/kernel/smp-cmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index fc8a515..61bfa20 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -60,8 +60,6 @@ static void cmp_smp_finish(void)
 {
 	pr_debug("SMPCMP: CPU%d: %s\n", smp_processor_id(), __func__);
 
-	/* CDFIXME: remove this? */
-	write_c0_compare(read_c0_count() + (8 * mips_hpt_frequency / HZ));
 
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
-- 
1.9.1
