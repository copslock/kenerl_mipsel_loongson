Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2012 18:01:51 +0200 (CEST)
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:9301 "EHLO
        g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823045Ab2JZQBr5PiHf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2012 18:01:47 +0200
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
        by g6t0184.atlanta.hp.com (Postfix) with ESMTP id 7602DC0F8;
        Fri, 26 Oct 2012 16:01:41 +0000 (UTC)
Received: from [10.152.0.198] (openvpn.lnx.usa.hp.com [16.125.113.33])
        by g5t0030.atlanta.hp.com (Postfix) with ESMTP id A24E5140E4;
        Fri, 26 Oct 2012 16:01:39 +0000 (UTC)
Message-ID: <1351267298.4013.12.camel@lorien2>
Subject: [PATCH RFT RESEND linux-next] mips: dma-mapping: support
 debug_dma_mapping_error
From:   Shuah Khan <shuah.khan@hp.com>
Reply-To: shuah.khan@hp.com
To:     ralf@linux-mips.org, kyungmin.park@samsung.com, arnd@arndb.de,
        andrzej.p@samsung.com, m.szyprowski@samsung.com
Cc:     linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        shuahkhan@gmail.com
Date:   Fri, 26 Oct 2012 10:01:38 -0600
In-Reply-To: <1351208193.6851.17.camel@lorien2>
References: <1351208193.6851.17.camel@lorien2>
Organization: ISS-Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 34775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shuah.khan@hp.com
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

Add support for debug_dma_mapping_error() call to avoid warning from
debug_dma_unmap() interface when it checks for mapping error checked
status. Without this patch, device driver failed to check map error
warning is generated.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
---
 arch/mips/include/asm/dma-mapping.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index be39a12..006b43e 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -40,6 +40,8 @@ static inline int dma_supported(struct device *dev, u64 mask)
 static inline int dma_mapping_error(struct device *dev, u64 mask)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	debug_dma_mapping_error(dev, mask);
 	return ops->mapping_error(dev, mask);
 }
 
-- 
1.7.9.5
