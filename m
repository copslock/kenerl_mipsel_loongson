Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 07:36:26 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:48589 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822276AbaEUFgRCq0R0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 07:36:17 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s4L5a5WM019145
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 20 May 2014 22:36:06 -0700 (PDT)
Received: from pek-yzhang-d1.corp.ad.wrs.com (128.224.162.188) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.169.1; Tue, 20 May 2014 22:36:04 -0700
From:   Yong Zhang <yong.zhang@windriver.com>
To:     <ralf@linux-mips.org>, <huawei.libin@huawei.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] MIPS: change type of asid_cache to unsigned long
Date:   Wed, 21 May 2014 13:36:03 +0800
Message-ID: <1400650563-1033-1-git-send-email-yong.zhang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <yong.zhang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang@windriver.com
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

asid_cache must be unsigned long otherwise on 64bit system
it will become 0 if the value in get_new_mmu_context()
reaches 0xffffffff and in the end the assumption of
ASID_FIRST_VERSION is not true anymore thus leads to
more dangerous things.

Reported-by: libin <huawei.libin@huawei.com>
Signed-off-by: Yong Zhang <yong.zhang@windriver.com>
---

V2<-V1: Add the reporter.

 arch/mips/include/asm/cpu-info.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index f6299be..ebcc2ed 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -40,7 +40,7 @@ struct cache_desc {
 
 struct cpuinfo_mips {
 	unsigned int		udelay_val;
-	unsigned int		asid_cache;
+	unsigned long		asid_cache;
 
 	/*
 	 * Capability and feature descriptor structure for MIPS CPU
-- 
1.7.9.5
