Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2018 11:06:52 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39736 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990422AbeHDJGsNeT1y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Aug 2018 11:06:48 +0200
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CE0C589C;
        Sat,  4 Aug 2018 09:06:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Rui Wang <rui.wang@windriver.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 4.4 001/124] MIPS: Fix off-by-one in pci_resource_to_user()
Date:   Sat,  4 Aug 2018 10:59:50 +0200
Message-Id: <20180804082702.486233362@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65391
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org # v3.12+
Patchwork: https://patchwork.linux-mips.org/patch/19829/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/pci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -89,7 +89,7 @@ static inline void pci_resource_to_user(
 	phys_addr_t size = resource_size(rsrc);
 
 	*start = fixup_bigphys_addr(rsrc->start, size);
-	*end = rsrc->start + size;
+	*end = rsrc->start + size - 1;
 }
 
 /*
