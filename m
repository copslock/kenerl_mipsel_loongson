Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 13:10:44 +0200 (CEST)
Received: from h1.mediaprovider.org ([IPv6:2a03:4000:6:1021::4]:53136 "EHLO
        h1.direct-netware.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994540AbeHTLKllsYR2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 13:10:41 +0200
Received: from odin.localnet (p54B04450.dip0.t-ipconnect.de [84.176.68.80])
        by h1.direct-netware.de (Postfix) with ESMTPA id 47431100B3B;
        Mon, 20 Aug 2018 13:10:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vplace.de; s=mail;
        t=1534763441; bh=ZOrMDgYwU4fzj80KD/faCZ78Yh6KksrqDVzxhzM4W9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A678d4TWMQ1REpdZuU0GY49+osL0u+iKnvgO2piq4i4mWAOvSJw1izjJkz+VsfZJ4
         VN8AmxJ/LOlnnsfqn/vAq5LDi8jMJauO0YJkJLCDc3T+a3QJfDIw+7tAQfr/uqSs3s
         l5Miq3FnLtc5NJwYWFilVCiDStpgz09WPEPl+eRA=
Received: from loki.localnet (unknown [172.16.255.10])
        by odin.localnet (Postfix) with ESMTP id 7F046D7FE96;
        Mon, 20 Aug 2018 13:10:40 +0200 (CEST)
From:   Tobias Wolf <dev-NTEO@vplace.de>
To:     linux-mips@linux-mips.org
Cc:     stable@vger.kernel.org
Subject: [PATCH v3] MIPS: Fix memory reservation in bootmem_init for certain non-usermem setups
Date:   Mon, 20 Aug 2018 13:10:38 +0200
Message-ID: <7994529.fS1YjVU6T6@loki>
In-Reply-To: <1983860.23LM468bU3@loki>
References: <1983860.23LM468bU3@loki>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <dev-NTEO@vplace.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev-NTEO@vplace.de
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

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
---
 arch/mips/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 563188ac6fa2..c3ca55128926 100644

v2: Correctly compare that usermem is not null.
v3: Added/changed position of changelog and fixed sender address.
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
