Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:02:53 +0200 (CEST)
Received: from mail-lb0-f194.google.com ([209.85.217.194]:33392 "EHLO
        mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027023AbcEUMAuROKuI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:00:50 +0200
Received: by mail-lb0-f194.google.com with SMTP id u2so693085lbo.0;
        Sat, 21 May 2016 05:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=evTkSZYtM5lvuXESgU6NX6axmO5FvjbBoeALZjWjUpc=;
        b=N3QWt10bZPc78IMEDuA+mrf7CnW2l0Iphr7Y/BOBzdAkhfdiOvwt4iAkV1psw8+M0X
         fwxu9dq3Gm25pWa1hRHh4euLhvKyoJ71jp4VW9/Hjhizr8Q0H2QpHWc8KgMMS3UmoYGH
         aJEuPR/RkLL6efFp1FQPTr8co3QWAKppDRptWltpIPWdkPkf4zJ6NqXMJ4ANdkQ/IwcH
         HYr/VBmX5meH5d3Juwboz4qQMaFGIPRzZIPhxflvfnBQQviuRONdtOUXA1D9734doTgG
         pckD3mU2ggRWrXlRT7I+8hTeRQg71iYxF5U3bn6zh1m+lYil2URqeaaFSafPr1GesCkd
         3BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=evTkSZYtM5lvuXESgU6NX6axmO5FvjbBoeALZjWjUpc=;
        b=BnBipliUXUTUpJz8sEuQqymtqzCmA2Lolomiun6MHil+AnJv1D4cGNUMZDH3LRBUjK
         mTrz7EfInNo6/GuqLQN8j06WxCC3Gb/renfiFDPImn1cPgZP56jboaEU0218TnCQMrVg
         762fS4S6EUULSDUqE5RcrH3hMI24Nzu/mXI2w9imhy1XdMVKNQlCsT5Ne6aq/iANcscA
         fwO74e+AmhPWWJE7Tnzmp453ziZXNiRRSyecw4Ofc7FeLiwax0MS9Qc4WA/Ea0Ht0z5e
         lf53sTpPr0bMrKfsGtQl7DLltvdwOB/JYFQ+MNXQAA+38aOOsMIcSjd+4PeSEXjnMb0R
         PIUA==
X-Gm-Message-State: AOPr4FW21XV6tIfvpoWVDO4CjkTRm8i4ujeb3Q7+Lditsvs+TgwTY0roCm6bma5e/+6S8w==
X-Received: by 10.112.163.73 with SMTP id yg9mr2537421lbb.73.1463832044945;
        Sat, 21 May 2016 05:00:44 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id c20sm4195223lfb.21.2016.05.21.05.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:00:43 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0188/1529] Fix typo
Date:   Sat, 21 May 2016 14:00:40 +0200
Message-Id: <20160521120040.9648-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53586
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
 arch/mips/include/asm/octeon/cvmx-cmd-queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-cmd-queue.h b/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
index 8d05d90..a07a36f 100644
--- a/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
+++ b/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
@@ -146,7 +146,7 @@ typedef struct {
  * This structure contains the global state of all command queues.
  * It is stored in a bootmem named block and shared by all
  * applications running on Octeon. Tickets are stored in a differnet
- * cahce line that queue information to reduce the contention on the
+ * cache line that queue information to reduce the contention on the
  * ll/sc used to get a ticket. If this is not the case, the update
  * of queue state causes the ll/sc to fail quite often.
  */
-- 
2.8.2.534.g1f66975
