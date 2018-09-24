Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 13:39:11 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992087AbeIXLjGVA6xU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 13:39:06 +0200
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 665AA106F;
        Mon, 24 Sep 2018 11:38:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 046/105] MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET
Date:   Mon, 24 Sep 2018 13:33:32 +0200
Message-Id: <20180924113118.525753361@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66519
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit 0494d7ffdcebc6935410ea0719b24ab626675351 ]

isa_virt_to_bus() & isa_bus_to_virt() claim to treat ISA bus addresses
as being identical to physical addresses, but they fail to do so in the
presence of a non-zero PHYS_OFFSET.

Correct this by having them use virt_to_phys() & phys_to_virt(), which
consolidates the calculations to one place & ensures that ISA bus
addresses do indeed match physical addresses.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20047/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/io.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -141,14 +141,14 @@ static inline void * phys_to_virt(unsign
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
-static inline unsigned long isa_virt_to_bus(volatile void * address)
+static inline unsigned long isa_virt_to_bus(volatile void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return virt_to_phys(address);
 }
 
-static inline void * isa_bus_to_virt(unsigned long address)
+static inline void *isa_bus_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return phys_to_virt(address);
 }
 
 #define isa_page_to_bus page_to_phys
