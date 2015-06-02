Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 22:55:37 +0200 (CEST)
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:53557 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008077AbbFBUzgBZzl6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 22:55:36 +0200
Received: from resomta-ch2-04v.sys.comcast.net ([69.252.207.100])
        by resqmta-ch2-11v.sys.comcast.net with comcast
        id bYvP1q0032AWL2D01YvVZ5; Tue, 02 Jun 2015 20:55:29 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-04v.sys.comcast.net with comcast
        id bYvU1q00l42s2jH01YvVSH; Tue, 02 Jun 2015 20:55:29 +0000
Message-ID: <556E183A.70707@gentoo.org>
Date:   Tue, 02 Jun 2015 16:55:22 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: c-r4k: Fix typo in probe_scache()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433278529;
        bh=3NoA8bJ0g6xyJJAw4cv926SWlKGDjrexkMoFcnZHMRQ=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=r+hP62/50kywzhgTPXa3lUuUs6oTFzgshfwAWaa/bZ/Rxc3Fa+nvqwTZsFHTp8Sij
         ya3iODTfwqm2ycx5R2eTAIpSU3+Cl/Br26eBFpZ5smbBFwgfSU/IlUzrQplDlACBN3
         +O3zYq3099xaFrAPrs1wblbvUtucw8Qj3JSVqBUR+YtUpY1qQM1h3ttcrMsSNFjVQd
         ILTfrZH36ffjfBRvHmb4H+G+8B17bMLEX4oP3GB88AnAlfHPUpt4WaJJu1jcsLDDYg
         9fSnEDzdxkeRL78Dq9O9UYEQiBamxJ219e0HnCbJxpxJ3qqBBHKVR1UbogL0f3FKwA
         X6cIo9T82+isA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Fixes a typo in arch/mips/mm/c-r4k.c's probe_scache().

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/mm/c-r4k.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-mips-fix-probe_scache-typo.patch
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 0dbb65a..2e03ab1 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1372,7 +1372,7 @@ static int probe_scache(void)
 	scache_size = addr;
 	c->scache.linesz = 16 << ((config & R4K_CONF_SB) >> 22);
 	c->scache.ways = 1;
-	c->dcache.waybit = 0;		/* does not matter */
+	c->scache.waybit = 0;		/* does not matter */
 
 	return 1;
 }
