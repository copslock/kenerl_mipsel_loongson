Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 20:37:10 +0200 (CEST)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:56032 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822308Ab3HHShG3eglo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Aug 2013 20:37:06 +0200
Received: by mail-ie0-f170.google.com with SMTP id e14so2527947iej.15
        for <multiple recipients>; Thu, 08 Aug 2013 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lTLfgd1NK99V87PBKA4VbJ16GZpBF6snrpuVu+YWGhQ=;
        b=WPNe90vtksX0CvvwjtPqI43y2WGfzejNZw5uCWkJFFo/J4NXFIXaEcHjWzAthgOchZ
         2lLVi54tdJcVK2jVU+s9w9q8lG1XV1Tj/mXT+SPIYz8PnW9Ylzk7zX25CV5k3kCGeTiC
         rQTSKD/lQICnWBpCls7YbIfdPbKrcPFo28S/+jHSoU/FCJYKGM/Dw5YBE6o+2luPnfuB
         SDhkJR728ilyt2ujGDotvmk20Z0uHxdSnsZnHbsadigIi3rxbbBZT5oyJ7CD2GpF8Ctq
         RZb2jaA4EViPdcAJ8cYzwfIRlIb3MU/W9znj0iSQIURV3qY4etZsz5uds1e5zKCVZEyS
         1V9A==
X-Received: by 10.43.67.73 with SMTP id xt9mr2744409icb.99.1375987019801;
        Thu, 08 Aug 2013 11:36:59 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id io8sm8254056igb.7.2013.08.08.11.36.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 11:36:59 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r78IauKT003633;
        Thu, 8 Aug 2013 11:36:56 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r78IatXf003632;
        Thu, 8 Aug 2013 11:36:55 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Discard .eh_frame sections in linker script.
Date:   Thu,  8 Aug 2013 11:36:53 -0700
Message-Id: <1375987013-3599-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Some toolchains (including Cavimu OCTEON SDK) are emitting .eh_frame
sections by default.  Discard them as they are useless in the kernel.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 05826d2..3b46f7c 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -179,5 +179,6 @@ SECTIONS
 		*(.options)
 		*(.pdr)
 		*(.reginfo)
+		*(.eh_frame)
 	}
 }
-- 
1.7.11.7
