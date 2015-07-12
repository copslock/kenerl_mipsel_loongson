Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 01:11:15 +0200 (CEST)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35623 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010492AbbGLXLFAQyTe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 01:11:05 +0200
Received: by igcqs7 with SMTP id qs7so45614251igc.0
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=frFMa945be/kjc/1NRmhzivX66vnoefjuT12peQJMJg=;
        b=YrobE7rfYpnsvnW6+jbTuOyAa6VOP3fLORm9Y5ZVwTF4+eW7RwCwogMiyyBPW0FaDT
         C/jQ0FVQt6PGRgxhuX1cqsrdUh+PfLIbuiDF/NS3vq5FDpD1hip++fK6Ly0DL27701HA
         rSClrBMWH9HS4LelugYwFo/YTPrn5ZT2/gO05PsiYMQP+SfQRqe4cT0qM89MvL0mC8Qt
         KUeXRr2gjeRGbBVRE8FHC58mXDx9cc8ivjarSJsode7d0jRrEZAE5YtEZiMU6110nNc2
         VIx0LP+s8bqOg61WFbwbA0e9qGA5D80DUUFme47DMjM3w3t5kTH0vrIobVGKeoeIbYdC
         tKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=frFMa945be/kjc/1NRmhzivX66vnoefjuT12peQJMJg=;
        b=C1z3vhKTuEJ/Ta5qk6ZgyiBa/iUs0ZFYn7s/P0ZClSE6KWy7jai2/Dvmd8iF3gZ/g5
         Une41PCE98qaxH6AgmWuqtFMR3PzzZQj1N2f/eP6QXMMGKcKWQ6+onZJ4WMNBQsXdILD
         IlDTmweG/LCJTs14ISFzVggGfsKfsOJHqJ14URI/zX/eIz4p+1ECxX4BSe3KBTMUXZh0
         gNZwx/lszMbqsMVgumW/g0rd55BvbhIz8Lc1h5aauNhCRBxdR0CBOajCoCjnZLjCzTFH
         FMfAOdEfQId2HHokjXPMtAP9JOyXXo3ktWGmRw5aOpaIRuL/+bnt9GerxqqwtwVMzYkr
         Y+ww==
X-Gm-Message-State: ALoCoQlVM9yLVqJjhHNLlCsIiDeFB5jQ+ycjVG12WrZnEYoh+OlD82O4FRFHMndtyBVQ6og+NsK+
X-Received: by 10.50.72.41 with SMTP id a9mr8668386igv.51.1436742659196;
        Sun, 12 Jul 2015 16:10:59 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id fv2sm4471694igb.22.2015.07.12.16.10.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 16:10:58 -0700 (PDT)
Subject: [PATCH 1/9] MIPS: CPC: Remove "weak" from mips_cpc_phys_base() and
 make it static
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jul 2015 18:10:56 -0500
Message-ID: <20150712231056.11177.24805.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48204
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
 
