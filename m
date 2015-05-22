Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:52:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50068 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006683AbbEVPwVOxAm3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:52:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EFCFFBF0E433A;
        Fri, 22 May 2015 16:52:13 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:52:16 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:52:16 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/15] MIPS: define GCR_GIC_STATUS register fields
Date:   Fri, 22 May 2015 16:51:00 +0100
Message-ID: <1432309875-9712-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Add definitions for the GICEX field in the GCR_GIC_STATUS register to
mips-cm.h for use in a later patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/include/asm/mips-cm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 59c0901..1cb11fb 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -216,6 +216,10 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 #define CM_GCR_CPC_BASE_CPCEN_SHF		0
 #define CM_GCR_CPC_BASE_CPCEN_MSK		(_ULCAST_(0x1) << 0)
 
+/* GCR_GIC_STATUS register fields */
+#define CM_GCR_GIC_STATUS_GICEX_SHF		0
+#define CM_GCR_GIC_STATUS_GICEX_MSK		(_ULCAST_(0x1) << 0)
+
 /* GCR_REGn_BASE register fields */
 #define CM_GCR_REGn_BASE_BASEADDR_SHF		16
 #define CM_GCR_REGn_BASE_BASEADDR_MSK		(_ULCAST_(0xffff) << 16)
-- 
2.4.1
