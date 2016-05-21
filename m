Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:04:24 +0200 (CEST)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36678 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032403AbcEUMBaM2-eI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:01:30 +0200
Received: by mail-lf0-f65.google.com with SMTP id d132so1678793lfb.3;
        Sat, 21 May 2016 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=FRoNxPleKp70mdtuA1G5HZadiHKh3u3cBHkMehdkZAY=;
        b=rbJ60lq7NxJ1SfQ84xQUJzyEhJKCveHf0eHJGn2u3ldUldZb26hnpRAZZ+8RdQe2oE
         PT9S1E4/Juq1EOI6aewPZlR6Vnc86l7w7yoJMZrxhui1aVMFxfmq+fS0fjfUqQONpggO
         Z3ljijjp2+nmAtG3WHrIBcgUFy1UnRATJNO23koM72lhUDzXLmE207XvuuZuvIIkmq0T
         ZbihaFjRFyk5V44SYtDV2gXwn7NyoDg+H3hdQ6w9H1YuX7Mm5vJCuksGOQ5vFXZ328vA
         Ggk6EZ9udrMX+742ctF0C/a1RgykcZd6hL3qgfaMnJcCF2CaT7kicjV4XfW5AgM1esPA
         kJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=FRoNxPleKp70mdtuA1G5HZadiHKh3u3cBHkMehdkZAY=;
        b=O2UEINlT6c4XkvyLi3I+iasub1aVu1E+jOy9liQEE1uoJmSXZG5gWlcU/oQYbZm5ZC
         TLfKjV5N4kfRlFQ0LFcm7fiiAOexp1JFi5L5SvI5MFrKLyarXbtd4RIYetTqoqXw/nic
         zx55kETkgBSU/DLTWI57ZC2Z1EtPm+DwlEabbvZpZX2E/o4bA9sBuLSk9bLIiiDRBJnI
         I209cbXYsr0z25dvT2t5LFWi6IV+te5CvjFgDskjP5LvhdnccZ9onqe2CwIJC8AWU17M
         BghSb76qACVBpkMAZWudZpOHoFg8f8/q4xu/8xPY1MGSeXNaeHqBky0a3VjRmLXDa20a
         J3UA==
X-Gm-Message-State: AOPr4FVFRRj2TQjSKPCuYKIez/7im1rb+USvT1Jeof2B6VOp2u/R/lqnxaiY+P/BR42RlQ==
X-Received: by 10.25.218.14 with SMTP id r14mr2725349lfg.120.1463832084877;
        Sat, 21 May 2016 05:01:24 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id e143sm2482926lfg.43.2016.05.21.05.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:01:23 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, macro@imgtec.com,
        paul.burton@imgtec.com, Leonid.Yegoshin@imgtec.com,
        linux-mips@linux-mips.org
Subject: [PATCH 0193/1529] Fix typo
Date:   Sat, 21 May 2016 14:01:20 +0200
Message-Id: <20160521120120.9981-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index 625ee77..edfa845 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -2202,7 +2202,7 @@ fpu_emul:
 	}
 
 	/*
-	 * Lets not return to userland just yet. It's constly and
+	 * Lets not return to userland just yet. It's costly  and
 	 * it's likely we have more R2 instructions to emulate
 	 */
 	if (!err && (pass++ < MIPS_R2_EMUL_TOTAL_PASS)) {
-- 
2.8.2.534.g1f66975
