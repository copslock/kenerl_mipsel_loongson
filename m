Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 00:44:37 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:49767 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011950AbaJTWodv7QnD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 00:44:33 +0200
Received: by mail-ie0-f182.google.com with SMTP id rp18so20380iec.13
        for <multiple recipients>; Mon, 20 Oct 2014 15:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4MeODorgx2x8o6xldndXVOZe/819UG1U9SkwLdOHVlw=;
        b=oYwBZVcQeJdVVMF8Zgk9YzZ56wrKc2tl8OUxfEljy+VmULuvts4vu1lsh/J7VIAoOR
         rZtPPdDGJjknHJttnVcO+JgK5M9GGrFc8Nhnd6rpcSfB+5DpLQ1W418i71AS5IdG5Iw8
         +ePa2eyMgfBTYORY264IjqWdUIRkFvTAV9Q0B5yIoWfvhpggmN3QGNXeDilbgECd474P
         u2nZSdnYktwkyz+FYzEryzwRuLydbP6dq4DqJkUa0JdW8wv07I2GOp7wKsBx6igG0zrp
         Xp/ocmvMVA613QneF4D+Ouwbd7m/1/noAekYKopTMOLm25u1uj9lBOwBypgNawL4RLbn
         ptXw==
X-Received: by 10.42.190.6 with SMTP id dg6mr29352105icb.13.1413845067676;
        Mon, 20 Oct 2014 15:44:27 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id o3sm4491821igv.19.2014.10.20.15.44.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 15:44:27 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id s9KMiPna030316;
        Mon, 20 Oct 2014 15:44:25 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id s9KMiPLV030315;
        Mon, 20 Oct 2014 15:44:25 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: OCTEON: Remove special case for simulator command line.
Date:   Mon, 20 Oct 2014 15:44:24 -0700
Message-Id: <1413845064-30271-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43392
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

There is no reason to have the kernel to append commands when running
under the simulator, the simulator is perfectly capable of supplying
the necessary command line arguments.  Furthermore, if the simulator
needs something different than what is hard coded in the kernel, it
cannot get it if the kernel overrides it.

Fix/Simplify the whole thing by removing this bit.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/setup.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 38f4c32..5ebdb32 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -806,15 +806,6 @@ void __init prom_init(void)
 #endif
 	}
 
-	if (octeon_is_simulation()) {
-		/*
-		 * The simulator uses a mtdram device pre filled with
-		 * the filesystem. Also specify the calibration delay
-		 * to avoid calculating it every time.
-		 */
-		strcat(arcs_cmdline, " rw root=1f00 slram=root,0x40000000,+1073741824");
-	}
-
 	mips_hpt_frequency = octeon_get_clock_rate();
 
 	octeon_init_cvmcount();
-- 
1.7.11.7
