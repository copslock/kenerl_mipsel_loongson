Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 14:55:30 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:55518 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993588AbeDCMzWWPbIw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Apr 2018 14:55:22 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D07760767; Tue,  3 Apr 2018 12:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1522760115;
        bh=gt/baHg+YOtYxbcPB+ga2CKKrno8z+c2HwxNKeRapjE=;
        h=From:To:Cc:Subject:Date:From;
        b=b7ZW3g/wGByB4VDiDqkVE1WPQCCCGdBrWhDVh/IS+AJN53eHPc6Z9f5djFl3lqosT
         KX1XWbhpWexb5uMwFJxywVeZlxUWn+qQYd0xs72vf8FDylEABPfhtaYqWsxNdvmQx2
         TqqwKGTXgWc+bqVCwpTGdd5beqweIYhFDJdjDhdw=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA1B1605FF;
        Tue,  3 Apr 2018 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1522760115;
        bh=gt/baHg+YOtYxbcPB+ga2CKKrno8z+c2HwxNKeRapjE=;
        h=From:To:Cc:Subject:Date:From;
        b=b7ZW3g/wGByB4VDiDqkVE1WPQCCCGdBrWhDVh/IS+AJN53eHPc6Z9f5djFl3lqosT
         KX1XWbhpWexb5uMwFJxywVeZlxUWn+qQYd0xs72vf8FDylEABPfhtaYqWsxNdvmQx2
         TqqwKGTXgWc+bqVCwpTGdd5beqweIYhFDJdjDhdw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA1B1605FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] MIPS: io: prevent compiler reordering on the default writeX() implementation
Date:   Tue,  3 Apr 2018 08:55:03 -0400
Message-Id: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okaya@codeaurora.org
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

writeX() has a strong ordering semantics with respect to memory updates.
In the abscence of a write barrier or a compiler barrier, commpiler can
reorder register and memory update instructions. This breaks the writeX()
API.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/mips/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 0cbf3af..fd00ddaf 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -307,7 +307,7 @@ static inline void iounmap(const volatile void __iomem *addr)
 #if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
 #define war_io_reorder_wmb()		wmb()
 #else
-#define war_io_reorder_wmb()		do { } while (0)
+#define war_io_reorder_wmb()		barrier()
 #endif
 
 #define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)			\
-- 
2.7.4
