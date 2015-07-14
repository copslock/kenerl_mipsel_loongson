Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 18:48:26 +0200 (CEST)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36039 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010425AbbGNQrUNp0Vn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 18:47:20 +0200
Received: by oibn4 with SMTP id n4so10512832oib.3
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=cbcYro5zUjC47YOqGlxOBy/JwZ328I/scMhoknIEixU=;
        b=kX3dcV/hu3QBkwUSc898C25lP1nSQyYVTwTy3ooTXfR6+JZbbH9s6eb2mfaq/KXdHY
         CJjoprY1RZXrT8WYTBxBwTyczRh0WW5cQIBWPUAntK8Hdm3wNlCAZun4JkEuPur3iLEY
         41p1Y15E40LwJ+cvtZWB70ICVamSSBIerJfNnTgfj18UcJeH21IC740atQP6PmMJUTdY
         lTBUm+xn2q1yrGckzmJUh9SsURP/wYJ5yQ49Lj6PMl96Vs0JooJeqAKEFPJqLejcQR2a
         bF4Qoh3wlJtgQhZqc80u2l2Ga6bCSJzyzKy/A+W4CejFOpXulxPr4cSSW5D4GTwT9D+n
         2Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=cbcYro5zUjC47YOqGlxOBy/JwZ328I/scMhoknIEixU=;
        b=SJId2FDGqU95TLn324IbvuqR/JkPaiWURmoqyLvSl9aIrIJMiB6IHaLAahYRbVq51l
         4g5Wt1sb2YAAGKDgBdq6dM30wFGh0RoxAhD28lqLiUAc83p9yYrPyOJDdQO2V8vfPuXI
         ai0FmnVvPY4BH9cNH7iXf2stfWNPAMP8EAeoMLjYVZ6SwjyQjJpTXlXog5vX+ZzemZY/
         pP9NDJcYhedI2hMNpAqLVofx3mrsoG0LQNERNsQKcdOZzHd0EeyvJgXDipp8qhSwpbRM
         0ckTAZMDd9bKiTJ5g2lIHYhMk0KuKg8DJh15Az3owfkwEgOVdYF/efiw+SlWmF9Kl7Xj
         NdJw==
X-Gm-Message-State: ALoCoQk+SD4sji5c1NIpjWCQoWNd4u8A6LCBPC0O9Oz2hhNEbxg8EsPS3MbwNyQA9faujYeuxxx+
X-Received: by 10.202.175.82 with SMTP id y79mr34987846oie.22.1436892434630;
        Tue, 14 Jul 2015 09:47:14 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id a10sm763392obl.9.2015.07.14.09.47.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 09:47:13 -0700 (PDT)
Subject: [PATCH v2 7/8] MIPS: Remove "weak" from mips_cdmm_phys_base()
 declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2015 11:47:11 -0500
Message-ID: <20150714164711.1541.5850.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
X-archive-position: 48290
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

Weak header file declarations are error-prone because they make every
definition weak, and the linker chooses one based on link order (see
10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
decl")).

mips_cdmm_phys_base() is defined only in arch/mips/mti-malta/malta-memory.c
so there's no problem with multiple definitions.  But it works better to
have a weak default implementation and allow a strong function to override
it.  Then we don't have to test whether a definition is present, and if
there are ever multiple strong definitions, we get a link error instead of
calling a random definition.

Add a weak mips_cdmm_phys_base() definition and remove the weak annotation
from the declaration in arch/mips/include/asm/cdmm.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/include/asm/cdmm.h |    4 ++--
 drivers/bus/mips_cdmm.c      |   14 +++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/cdmm.h b/arch/mips/include/asm/cdmm.h
index 16e22ce..bece206 100644
--- a/arch/mips/include/asm/cdmm.h
+++ b/arch/mips/include/asm/cdmm.h
@@ -53,7 +53,7 @@ struct mips_cdmm_driver {
  * mips_cdmm_phys_base() - Choose a physical base address for CDMM region.
  *
  * Picking a suitable physical address at which to map the CDMM region is
- * platform specific, so this weak function can be defined by platform code to
+ * platform specific, so this function can be defined by platform code to
  * pick a suitable value if none is configured by the bootloader.
  *
  * This address must be 32kB aligned, and the region occupies a maximum of 32kB
@@ -61,7 +61,7 @@ struct mips_cdmm_driver {
  *
  * Returns:	Physical base address for CDMM region, or 0 on failure.
  */
-phys_addr_t __weak mips_cdmm_phys_base(void);
+phys_addr_t mips_cdmm_phys_base(void);
 
 extern struct bus_type mips_cdmm_bustype;
 void __iomem *mips_cdmm_early_probe(unsigned int dev_type);
diff --git a/drivers/bus/mips_cdmm.c b/drivers/bus/mips_cdmm.c
index ab3bde1..1c543ef 100644
--- a/drivers/bus/mips_cdmm.c
+++ b/drivers/bus/mips_cdmm.c
@@ -332,6 +332,18 @@ static phys_addr_t mips_cdmm_cur_base(void)
 }
 
 /**
+ * mips_cdmm_phys_base() - Choose a physical base address for CDMM region.
+ *
+ * Picking a suitable physical address at which to map the CDMM region is
+ * platform specific, so this weak function can be overridden by platform
+ * code to pick a suitable value if none is configured by the bootloader.
+ */
+phys_addr_t __weak mips_cdmm_phys_base(void)
+{
+	return 0;
+}
+
+/**
  * mips_cdmm_setup() - Ensure the CDMM bus is initialised and usable.
  * @bus:	Pointer to bus information for current CPU.
  *		IS_ERR(bus) is checked, so no need for caller to check.
@@ -368,7 +380,7 @@ static int mips_cdmm_setup(struct mips_cdmm_bus *bus)
 	if (!bus->phys)
 		bus->phys = mips_cdmm_cur_base();
 	/* Otherwise, ask platform code for suggestions */
-	if (!bus->phys && mips_cdmm_phys_base)
+	if (!bus->phys)
 		bus->phys = mips_cdmm_phys_base();
 	/* Otherwise, copy what other CPUs have done */
 	if (!bus->phys)
