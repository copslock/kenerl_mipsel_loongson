Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Oct 2015 05:02:20 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39677 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006195AbbJRDB7ZqQhd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Oct 2015 05:01:59 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E7A7307;
        Sun, 18 Oct 2015 03:01:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Tony Wu <tung7970@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>, Joe Perches <joe@perches.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.2 204/258] MIPS: bootmem: Fix mapstart calculation for contiguous maps
Date:   Sat, 17 Oct 2015 18:58:37 -0700
Message-Id: <20151018014739.664824664@linuxfoundation.org>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <20151018014729.976101177@linuxfoundation.org>
References: <20151018014729.976101177@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.2-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

commit 88d3426942d748b90b051b7ef2d5d765f5f3054c upstream.

Commit a6335fa1 fixed the case with gap between initrd and next usable PFN zone,
but broken the case when initrd is combined with usable memory into one region
(in add_memory_region()). Restore the fixup initially brought in by f9a7febd.

---- error message ----
Unpacking initramfs...
Initramfs unpacking failed: junk in compressed archive
BUG: Bad page state in process swapper  pfn:00261
page:81004c20 count:0 mapcount:-127 mapping:  (null) index:0x2
flags: 0x0()
page dumped because: nonzero mapcount
CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0+ #1782
-----------------------

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reported-by: Tony Wu <tung7970@gmail.com>
Tested-by: Tony Wu <tung7970@gmail.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Joe Perches <joe@perches.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11086/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/setup.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -338,7 +338,7 @@ static void __init bootmem_init(void)
 		if (end <= reserved_end)
 			continue;
 #ifdef CONFIG_BLK_DEV_INITRD
-		/* mapstart should be after initrd_end */
+		/* Skip zones before initrd and initrd itself */
 		if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
 			continue;
 #endif
@@ -371,6 +371,14 @@ static void __init bootmem_init(void)
 		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}
 
+#ifdef CONFIG_BLK_DEV_INITRD
+	/*
+	 * mapstart should be after initrd_end
+	 */
+	if (initrd_end)
+		mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
+#endif
+
 	/*
 	 * Initialize the boot-time allocator with low memory only.
 	 */
