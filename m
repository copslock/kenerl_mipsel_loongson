Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 22:47:23 +0100 (CET)
Received: from mail-bk0-f50.google.com ([209.85.214.50]:62929 "EHLO
        mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816553Ab3ANVrWmGnQn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jan 2013 22:47:22 +0100
Received: by mail-bk0-f50.google.com with SMTP id jf3so2248632bkc.9
        for <multiple recipients>; Mon, 14 Jan 2013 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=EJMR/91ORBZazX8OjfrrvuqX3NT52WjsgmoDCdzCH4c=;
        b=Nt2Z8vNj8j6mPU4cvK12w+/l1pNH5h00aKqVqWDxTcjoFZSIwTREYjgKahS2zOKD1Y
         RIZAfy6c/e/vJR6VimqujbMdgqbvrmE2uiGaSOliPeUWN0CndQtk1529YdBeyjf4nwd1
         G+AHVow7mxsqQHE3oYbs+yVNyJ9uDUWjyBSHp8R++1MZnS8sfd+XmgGC9wZJ5kbtSj18
         G6TmwaDqRkDBGCsu+m6fnCCMJhW+eXKqLmJgYBdKnIr/wDbrystQtB03eLs+X76yqKJA
         K8t1nkKCBpbNWskY90x5CQU4ABmF3FgigI3G8nnqvTQ/TgzjGM0jGtKkSsvE3l9lXJnz
         UaTQ==
X-Received: by 10.205.125.137 with SMTP id gs9mr39392534bkc.22.1358200037211;
        Mon, 14 Jan 2013 13:47:17 -0800 (PST)
Received: from localhost.localdomain (p5B2F5DF4.dip.t-dialin.net. [91.47.93.244])
        by mx.google.com with ESMTPS id c10sm11225050bkw.1.2013.01.14.13.47.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 13:47:16 -0800 (PST)
From:   Cong Ding <dinggnu@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Jim Quinlan <jim2101024@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Cong Ding <dinggnu@gmail.com>
Subject: [PATCH] mpis: cavium-octeon/executive/cvmx-l2c.c: fix uninitialized variable
Date:   Mon, 14 Jan 2013 22:47:03 +0100
Message-Id: <1358200025-15994-1-git-send-email-dinggnu@gmail.com>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dinggnu@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

the variable dummy is used without initialization.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 arch/mips/cavium-octeon/executive/cvmx-l2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-l2c.c b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
index 9f883bf..d7e07af 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-l2c.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
@@ -286,7 +286,7 @@ uint64_t cvmx_l2c_read_perf(uint32_t counter)
 static void fault_in(uint64_t addr, int len)
 {
 	volatile char *ptr;
-	volatile char dummy;
+	volatile char dummy = 0;
 	/*
 	 * Adjust addr and length so we get all cache lines even for
 	 * small ranges spanning two cache lines.
-- 
1.7.9.5
