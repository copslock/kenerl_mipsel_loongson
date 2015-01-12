Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 08:08:04 +0100 (CET)
Received: from jaguar.aricent.com ([180.151.2.24]:41086 "EHLO
        jaguar.aricent.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006211AbbALHID3lp2B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 08:08:03 +0100
Received: from jaguar.aricent.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D76EC218BB3;
        Mon, 12 Jan 2015 12:37:54 +0530 (IST)
Received: from GUREXHT01.ASIAN.AD.ARICENT.COM (unknown [10.203.171.136])
        by jaguar.aricent.com (Postfix) with ESMTPS id CAABF218BAF;
        Mon, 12 Jan 2015 12:37:54 +0530 (IST)
Received: from imsseuq.aricent.com (10.203.171.248) by
 GUREXHT01.ASIAN.AD.ARICENT.COM (10.203.171.136) with Microsoft SMTP Server id
 8.3.342.0; Mon, 12 Jan 2015 12:37:54 +0530
Received: from h2512.localdomain ([172.16.116.228])     by imsseuq.aricent.com
 (8.13.1/8.13.1) with ESMTP id t0C6VBrB019509;  Mon, 12 Jan 2015 12:01:15 +0530
From:   Abhishek Paliwal <abhishek.paliwal@aricent.com>
To:     <kexin.hao@windriver.com>, <bo.liu@windriver.com>
CC:     Chandrakala.Chavva@caviumnetworks.com, rakesh.garg@aricent.com,
        Abhishek Paliwal <abhishek.paliwal@aricent.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        linux-mips@linux-mips.org, David Daney <ddaney.cavm@gmail.com>,
        James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/9] MIPS OCTEON Add OCTEON3 to get cpu type
Date:   Mon, 12 Jan 2015 12:36:17 +0530
Message-ID: <1421046385-2535-2-git-send-email-abhishek.paliwal@aricent.com>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
References: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
Return-Path: <abhishek.paliwal@aricent.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhishek.paliwal@aricent.com
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

commit cd3f5389489146297eb2c11e4f9d1c4e8aaeb59f upstream

Otherwise __builtin_unreachable might be called.
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Cc: David Daney <ddaney.cavm@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: kvm@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/7014/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Abhishek Paliwal <abhishek.paliwal@aricent.com>
---
 arch/mips/include/asm/cpu-type.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 02f591b..19557ca 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -160,6 +160,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
        case CPU_CAVIUM_OCTEON:
        case CPU_CAVIUM_OCTEON_PLUS:
        case CPU_CAVIUM_OCTEON2:
+       case CPU_CAVIUM_OCTEON3:
 #endif

 #if defined(CONFIG_SYS_HAS_CPU_BMIPS32_3300) || \
--
1.8.1.4



"DISCLAIMER: This message is proprietary to Aricent and is intended solely for the use of the individual to whom it is addressed. It may contain privileged or confidential information and should not be circulated or used for any purpose other than for what it is intended. If you have received this message in error, please notify the originator immediately. If you are not the intended recipient, you are notified that you are strictly prohibited from using, copying, altering, or disclosing the contents of this message. Aricent accepts no responsibility for loss or damage arising from the use of the information transmitted by this email including damage from virus."
