Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 18:46:39 +0200 (CEST)
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34450 "EHLO
        mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010563AbbGNQqa2cBNn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 18:46:30 +0200
Received: by obre1 with SMTP id e1so9761473obr.1
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=frFMa945be/kjc/1NRmhzivX66vnoefjuT12peQJMJg=;
        b=IDk4TRLrmptWy9Es1fVhDU2OajVOYgzTx7VEQhmu3PLpJHOiZ87J4YhBmUYLRf6zTf
         G+99AnCYJLoOsZmhXMTJ+pSlpDOoBqOpLFjjpisDD8vny7cNAL3Nqvk4KGENXW3UziDR
         UbUue7QdF5X2exnt7LiTP92Oot5f3EBpmO7Tius9i/QsaLGm5hd/mu37EwiyNddxyewp
         8/Ls3WBch5W+QX84d6k+AIbZMTpFa9qZElVcvatMHvIMHm70BTGj740p3rtDg8Z+0nBC
         3DdkK/Olu52zmFrUDz9JPJgRk1Xm4m+PuEaIpmKYt9Et5ToI4JT7VYtZU4Uc6irHwDDK
         FBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=frFMa945be/kjc/1NRmhzivX66vnoefjuT12peQJMJg=;
        b=DCpNDhNP9FKuitT0byWQ0ohweg48z74/t8BMOjPbSHLNdJ8N6Wx8UABHATbjN8ocZM
         sbXbHnoTpAjvGKc0Y9DD2wVd9mhpr7oAMpDPacrt1TEOkS4zvZ6V1Qr/UF4r97eXSweQ
         88aSnXDlcld6R4FymLWPDIUrL4al6RVZtv2VnIKsutQdBIL3jMyK/RDXU1U6BUmCHz2O
         roOkdbQodDBboISwE7ygTtkhEFjp4dR5ZPtt1dXyw3AI9djq1G97hC+iaAp+8g7KeX0V
         QB3I3Uns8F9hJgzcVsUE/LyQcyUXG9Yy4RNW22PHSA/sPVG6toTGYBvO3XcgCxX4xIWg
         7ZEg==
X-Gm-Message-State: ALoCoQmBi9c7eAC9kD3zhCL8F7epaSdU1sg3NwyoxOBXo2QOSwU/IDtH1IsW27slSgTicaPrrJYK
X-Received: by 10.60.141.42 with SMTP id rl10mr35492629oeb.25.1436892384622;
        Tue, 14 Jul 2015 09:46:24 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id v83sm752974oie.17.2015.07.14.09.46.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 09:46:23 -0700 (PDT)
Subject: [PATCH v2 1/8] MIPS: CPC: Remove "weak" from mips_cpc_phys_base()
 and make it static
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2015 11:46:21 -0500
Message-ID: <20150714164621.1541.84773.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

There's only one implementation of mips_cpc_phys_base(), and it's only used
within the same file, so it doesn't need to be weak, and it doesn't need an
extern declaration.

Remove the extern mips_cpc_phys_base() declaration and make it static.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mips-cpc.h |   10 ----------
 arch/mips/kernel/mips-cpc.c      |    9 ++++++++-
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
index 1cebe8c..f386f32 100644
--- a/arch/mips/include/asm/mips-cpc.h
+++ b/arch/mips/include/asm/mips-cpc.h
@@ -28,16 +28,6 @@ extern void __iomem *mips_cpc_base;
 extern phys_addr_t mips_cpc_default_phys_base(void);
 
 /**
- * mips_cpc_phys_base - retrieve the physical base address of the CPC
- *
- * This function returns the physical base address of the Cluster Power
- * Controller memory mapped registers, or 0 if no Cluster Power Controller
- * is present. It may be overriden by individual platforms which determine
- * this address in a different way.
- */
-extern phys_addr_t __weak mips_cpc_phys_base(void);
-
-/**
  * mips_cpc_probe - probe for a Cluster Power Controller
  *
  * Attempt to detect the presence of a Cluster Power Controller. Returns 0 if
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 1196450..7e9ea9b 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -21,7 +21,14 @@ static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
 
 static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
 
-phys_addr_t __weak mips_cpc_phys_base(void)
+/**
+ * mips_cpc_phys_base - retrieve the physical base address of the CPC
+ *
+ * This function returns the physical base address of the Cluster Power
+ * Controller memory mapped registers, or 0 if no Cluster Power Controller
+ * is present.
+ */
+static phys_addr_t mips_cpc_phys_base(void)
 {
 	u32 cpc_base;
 
