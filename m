Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 13:26:23 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:19346 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013095AbbEKL0WAwCQw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 13:26:22 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4BBQAuv011180
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 11 May 2015 11:26:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4BBQ9Q4030062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 11 May 2015 11:26:09 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4BBQ9JK006488;
        Mon, 11 May 2015 11:26:09 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.243.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2015 04:26:08 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: lose_fpu(): Disable FPU when MSA enabled
Date:   Mon, 11 May 2015 07:17:12 -0400
Message-Id: <1431343152-19437-51-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431343152-19437-1-git-send-email-sasha.levin@oracle.com>
References: <1431343152-19437-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit f8483988cadd7dd22de928db29ed3bcbe02faf78 ]

The lose_fpu() function only disables the FPU in CP0_Status.CU1 if the
FPU is in use and MSA isn't enabled.

This isn't necessarily a problem because KSTK_STATUS(current), the
version of CP0_Status stored on the kernel stack on entry from user
mode, does always get updated and gets restored when returning to user
mode, but I don't think it was intended, and it is inconsistent with the
case of only the FPU being in use. Sometimes leaving the FPU enabled may
also mask kernel bugs where FPU operations are executed when the FPU
might not be enabled.

So lets disable the FPU in the MSA case too.

Fixes: 33c771ba5c5d ("MIPS: save/disable MSA in lose_fpu")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9323/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/include/asm/fpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index dd56241..99f71e8 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -150,6 +150,7 @@ static inline void lose_fpu(int save)
 		}
 		disable_msa();
 		clear_thread_flag(TIF_USEDMSA);
+		__disable_fpu();
 	} else if (is_fpu_owner()) {
 		if (save)
 			_save_fp(current);
-- 
2.1.0
