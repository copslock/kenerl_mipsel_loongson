Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Aug 2013 12:05:34 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33443 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822344Ab3H3KF1Y5Les (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Aug 2013 12:05:27 +0200
Received: by mail-pa0-f42.google.com with SMTP id lj1so2152067pab.1
        for <linux-mips@linux-mips.org>; Fri, 30 Aug 2013 03:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wqJzT6yH8g7VMCOW4HQ3cYztVMLP5MtY05LGUiJW0NE=;
        b=iDpiADHPEG32UhBiBUPGWWggo12FqLW5Bn2u78hgWlPDNd3jxMhQP58lxOecRMSkQ1
         P05hXKDK/H2Ma+Dt+LCaQpCpBP4+5qI89SSpqejnqX7spodrKz5ZkfH7EcbHonmlk80n
         uEqJmElJklOUYnHAkOYXvR/IFMXlqkpllZnJ00+EuOx3SrFF2ruswK4KZZkgdEAEZluf
         6UMFcQpPsyziO+A5RByER4dkzeFrkellJHKVS0h7kmkyg9cycuLMeXeUlqRJQqnqm/+k
         phPLsB6+vFMsyzeYRKUtb2YIZC75tzlcH9YnL/6yYSDQdngH7UkAS7TXY/omW4kOhHET
         WGPg==
X-Received: by 10.68.197.36 with SMTP id ir4mr8931941pbc.96.1377857120916;
        Fri, 30 Aug 2013 03:05:20 -0700 (PDT)
Received: from localhost ([115.115.74.130])
        by mx.google.com with ESMTPSA id ht5sm43459853pbb.29.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 03:05:19 -0700 (PDT)
From:   Prem Mallappa <prem.mallappa@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>
Cc:     Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: KDUMP: skip walking indirection page for crashkernels
Date:   Fri, 30 Aug 2013 15:35:10 +0530
Message-Id: <1377857111-15493-1-git-send-email-pmallappa@caviumnetworks.com>
X-Mailer: git-send-email 1.8.4
Return-Path: <prem.mallappa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prem.mallappa@gmail.com
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


KDUMP: skip indirection page, as crashkernel has already copied to destination

Signed-off-by: Prem Mallappa <pmallappa@caviumnetworks.com>
---
 arch/mips/kernel/relocate_kernel.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index 43d2d78..2778a41 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -26,6 +26,11 @@ process_entry:
 	PTR_L		s2, (s0)
 	PTR_ADD		s0, s0, SZREG
 
+	/* In case of kdump/crash kernel, indirection page is not populated
+	* as the kernel is directly copied to reserved location
+	*/
+	beq             s2, zero, done
+
 	/* destination page */
 	and		s3, s2, 0x1
 	beq		s3, zero, 1f
-- 
1.8.4
