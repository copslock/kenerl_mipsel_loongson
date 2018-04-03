Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 14:55:44 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:55624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993497AbeDCMzYw-zow (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Apr 2018 14:55:24 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE18960F6C; Tue,  3 Apr 2018 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1522760118;
        bh=Q3pEhIuXc8dkyfiB5T3rn1HjTptAtr058BR0NWCQUcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bx6OYZBSHTd2mQteViZmfmlcQrRjPJazCpm5KEDLjO1jli8uwYfVqcwMnjCJ7fv1/
         R5w9TnVqDNK54edm1zXeT1k9bO/o6QMItQI5BT7o6D5OP5Akd4HS805qfaUqRSiMWP
         Nkj8hKf7xytzwCNoc+wq4gepvGabxcZuN6TFfbDE=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C12F160C65;
        Tue,  3 Apr 2018 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1522760117;
        bh=Q3pEhIuXc8dkyfiB5T3rn1HjTptAtr058BR0NWCQUcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVAD8F7QMN1UqGoHse1rj3HPW/CXyniIKHn0i1X13bdrTzZFcs2UMPPJBrpUA0TKO
         ssvM/q3Qv8KcZZCEtYCClHZnUcm0+UXek5upSF70rvRNEmQyxWjhXWDXwfuz7tijsl
         lmC+t3i3xfaGXaAxmZhx9UDwTsoo9BRBFf84EOhM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C12F160C65
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
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in readX()
Date:   Tue,  3 Apr 2018 08:55:04 -0400
Message-Id: <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63401
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
 arch/mips/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index fd00ddaf..6ac502f 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 		BUG();							\
 	}								\
 									\
+	rmb();								\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-- 
2.7.4
