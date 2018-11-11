Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2018 20:59:17 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45610 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993098AbeKKT7IOTQee (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2018 20:59:08 +0100
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsq-0000oN-Jo; Sun, 11 Nov 2018 19:59:00 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001js-ST; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Burton" <paul.burton@mips.com>,
        "Rui Wang" <rui.wang@windriver.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <jhogan@kernel.org>,
        "Wolfgang Grandegger" <wg@grandegger.com>,
        linux-mips@linux-mips.org
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.572177981@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 261/366] MIPS: Fix off-by-one in pci_resource_to_user()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 38c0a74fe06da3be133cae3fb7bde6a9438e698b upstream.

The MIPS implementation of pci_resource_to_user() introduced in v3.12 by
commit 4c2924b725fb ("MIPS: PCI: Use pci_resource_to_user to map pci
memory space properly") incorrectly sets *end to the address of the
byte after the resource, rather than the last byte of the resource.

This results in userland seeing resources as a byte larger than they
actually are, for example a 32 byte BAR will be reported by a tool such
as lspci as being 33 bytes in size:

    Region 2: I/O ports at 1000 [disabled] [size=33]

Correct this by subtracting one from the calculated end address,
reporting the correct address to userland.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Rui Wang <rui.wang@windriver.com>
Fixes: 4c2924b725fb ("MIPS: PCI: Use pci_resource_to_user to map pci memory space properly")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/19829/
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -87,7 +87,7 @@ static inline void pci_resource_to_user(
 	phys_t size = resource_size(rsrc);
 
 	*start = fixup_bigphys_addr(rsrc->start, size);
-	*end = rsrc->start + size;
+	*end = rsrc->start + size - 1;
 }
 
 /*
