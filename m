Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 04:31:21 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:43148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991359AbeDMCbBsxh4j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 04:31:01 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A30FF60F91; Fri, 13 Apr 2018 02:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523586655;
        bh=t7N6LdVpv1RaLrRpUUOgrcCQX5nXKSJeeziLYcKPskA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaIIPYXaUmQbCROBXj6GV9OJUC17KIZCZeYUoGYv5eflHmjB3gSW8vZIf4/y+GPLp
         Ubs9ZsgkMFcoEpLnwmeRq0ewVBkI2E2h4GElp5kWu0u0FWz4/gYgECdlZiFwNSDcOm
         ZQWKuFWdTzy6tB9aFF8ChFk+rhfxfm8N99I5mBU8=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BDDE160F8D;
        Fri, 13 Apr 2018 02:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523586654;
        bh=t7N6LdVpv1RaLrRpUUOgrcCQX5nXKSJeeziLYcKPskA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0ivTOXr1gP3C1UIzzFAKFW1aHUnN3XdlwMVXUoGDbfe4yi9vWtPXTcBhalVD3COc
         gRkFlwH8VES5F7fpJRORFUFQjBxIinx85Myq8U06uphOwIAL/0LvK4z64OMAmwk7lw
         ceG0jnXUa67617jV2eG75elshrQSlINdytHyxcLc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDDE160F8D
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
Subject: [PATCH v4 2/2] MIPS: io: add a barrier after register read in readX()
Date:   Thu, 12 Apr 2018 22:30:44 -0400
Message-Id: <1523586646-19630-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
References: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63517
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

While a barrier is present in writeX() function before the register write,
a similar barrier is missing in the readX() function after the register
read. This could allow memory accesses following readX() to observe
stale data.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index fd00ddaf..d96af41 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -377,6 +377,8 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 		BUG();							\
 	}								\
 									\
+	/* prevent prefetching of coherent DMA dma prematurely */	\
+	rmb();								\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-- 
2.7.4
