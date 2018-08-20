Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 12:06:44 +0200 (CEST)
Received: from h1.direct-netware.de ([5.45.107.14]:43846 "EHLO
        h1.direct-netware.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993941AbeHTKGl7LiSt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 12:06:41 +0200
Received: from odin.localnet (p54B04450.dip0.t-ipconnect.de [84.176.68.80])
        by h1.direct-netware.de (Postfix) with ESMTPA id A6005100B3B
        for <linux-mips@linux-mips.org>; Mon, 20 Aug 2018 12:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vplace.de; s=mail;
        t=1534759601; bh=55a+NsatVDclP9ZHCX1v8Dezd/svxy+xKdhcYmIAXZo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Knh1dmggo4Uti1OiiLo3uHobeosldclqgwFz6tFZijgJlqfgHuuxDeQyuLabpTrbK
         uizSg7YmXck9VeBYiq8vsdTD2fdnxqC2BfYNVU6s7/ovMy6kFTicc3Y1wDkKFiNpu6
         Kk8VSn2zuc/0li6UyCPYo0TiwVBbhoBNo2epazCI=
Received: from loki.localnet (unknown [172.16.255.10])
        by odin.localnet (Postfix) with ESMTP id 3B8E4D7F865
        for <linux-mips@linux-mips.org>; Mon, 20 Aug 2018 12:06:41 +0200 (CEST)
From:   Tobias Wolf <t.wolf@vplace.de>
To:     linux-mips@linux-mips.org
Subject: [PATCH v2] MIPS: Fix memory reservation in bootmem_init for certain non-usermem setups
Date:   Mon, 20 Aug 2018 12:06:40 +0200
Message-ID: <1609732.rDWVQJrTVM@loki>
In-Reply-To: <1983860.23LM468bU3@loki>
References: <1983860.23LM468bU3@loki>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <t.wolf@vplace.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: t.wolf@vplace.de
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

Commit 67a3ba25aa95 ("MIPS: Fix incorrect mem=X@Y handling") introduced a new
issue for rt288x where "PHYS_OFFSET" is 0x0 but the calculated "ramstart" is
not. As the prerequisite of custom memory map has been removed, this results
in the full memory range of 0x0 - 0x8000000 to be marked as reserved for this
platform.

This patch adds the originally intended prerequisite again.

v2: Correctly compare that usermem is not null.

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
---
 arch/mips/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 563188ac6fa2..c3ca55128926 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -371,6 +371,8 @@ static unsigned long __init bootmap_bytes(unsigned long 
pages)
 	return ALIGN(bytes, sizeof(long));
 }
 
+static int usermem __initdata;
+
 static void __init bootmem_init(void)
 {
 	unsigned long reserved_end;
@@ -444,7 +446,7 @@ static void __init bootmem_init(void)
 	/*
 	 * Reserve any memory between the start of RAM and PHYS_OFFSET
 	 */
-	if (ramstart > PHYS_OFFSET)
+	if (usermem && ramstart > PHYS_OFFSET)
 		add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
 				  BOOT_MEM_RESERVED);
 
@@ -654,8 +656,6 @@ static void __init bootmem_init(void)
  * initialization hook for anything else was introduced.
  */
 
-static int usermem __initdata;
-
 static int __init early_parse_mem(char *p)
 {
 	phys_addr_t start, size;
