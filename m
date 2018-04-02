Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Apr 2018 20:11:02 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:43114 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990757AbeDBSKxmEN5a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Apr 2018 20:10:53 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D124D6076C; Mon,  2 Apr 2018 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1522692646;
        bh=B62/sFeRiDwOYW5ZX08hlViVI1q7DO+Kcxpop8wMsLM=;
        h=From:To:Cc:Subject:Date:From;
        b=S10APZ6OE8JPyMJOmA7DWTYVvDSLe40yqb9LBZxtf6rap+JnpWkuPwGgkkAdAqkzX
         2qk0XNXdH3mPK/SW3XcKXbpmnqR1vePKCEiZYhsXDuXfBWO/32n7IbywQl8RPyVQ9c
         ifSBFQsz8mgRCuCyJdJ3Rw6KCqMkBqvO26dFKtF4=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11AED60591;
        Mon,  2 Apr 2018 18:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1522692646;
        bh=B62/sFeRiDwOYW5ZX08hlViVI1q7DO+Kcxpop8wMsLM=;
        h=From:To:Cc:Subject:Date:From;
        b=S10APZ6OE8JPyMJOmA7DWTYVvDSLe40yqb9LBZxtf6rap+JnpWkuPwGgkkAdAqkzX
         2qk0XNXdH3mPK/SW3XcKXbpmnqR1vePKCEiZYhsXDuXfBWO/32n7IbywQl8RPyVQ9c
         ifSBFQsz8mgRCuCyJdJ3Rw6KCqMkBqvO26dFKtF4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11AED60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-mips@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: io: add a barrier after readX()
Date:   Mon,  2 Apr 2018 14:10:32 -0400
Message-Id: <1522692633-24304-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63379
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
read. This could allow register accesses following readX() to observe
stale data.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 0cbf3af..7f9068d 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 		BUG();							\
 	}								\
 									\
+	war_io_reorder_wmb();						\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-- 
2.7.4
