Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 01:13:18 +0200 (CEST)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38441 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010512AbbGLXMFBc9Qe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 01:12:05 +0200
Received: by iggf3 with SMTP id f3so9268777igg.1
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=3WDwN+vWUTpBSIvb2Y9d5QwDl0Z7ute7dEyfuj4kH/4=;
        b=PCccVZxR4WbPwpSioP13sHH1sD9uPNr2FBY9wjTEuhZtZ6sHLi89UT/pkc9g12rQ8Q
         tsJz+Lk6sZvaVkpgT4f2adkw9poz7vhAI+f/O2sEm6LR+tdqHBmeE1xnkcmfnYkQjA4y
         6qp5oGh3rFSBNhvWcU/NzzOAPdw7ffghVA51RxadQfOWHul7UMSKTVWyVW4mYa8K9KrP
         s9gyVRFNwnk1LViP1cLxJ1qFtNsAJxKQe1gOHtlkdRLO+ju55r7LMthONwXdFOl8k/ds
         fUN1wPz1j5ekVgaj9v7isiz0GR5miTJiFKJsN0W2B2EiZuhNdXq8vOyby3eICk/QDG1U
         qRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=3WDwN+vWUTpBSIvb2Y9d5QwDl0Z7ute7dEyfuj4kH/4=;
        b=EV8O+9rf7RVPQvhUPfEQMZLXgXLNjEWe6D+ayB76xd5AyjNiBxfUQleGkoL7krPz9r
         E/sTk4eMiyK6V4fI9iPnqnmTzFQ1zBp/2AMip3mJ8j+maP12tWiTzshjMkvcC34MBxsn
         +Je2vh3J01UoDV8Kai57Jyk0WD5NnZejctngaCzClcz3w2SLxPGuBpLCyNsn/1L+/bUP
         lfh+fsbCuI50y+9j5+MF7qYzliLwT2vfWf20Rb9OPDfN9L1NHO732+LKSQROcGQvBuPg
         gGhlUZHGX7GQLAmnIMW6DYa5jbJkN1IFSyN/JIANh1HtBK5BzLezdoyYd+75HsDpC+iC
         Tx/Q==
X-Gm-Message-State: ALoCoQlSqvyTpq0v1+GULiYv9ry9W4EzhMZlMxeiRf9ExXRejD8UpFOYPNZ4vu+5WrJWPdf2Js5W
X-Received: by 10.107.164.168 with SMTP id d40mr15441527ioj.130.1436742718136;
        Sun, 12 Jul 2015 16:11:58 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id j20sm4486783igt.16.2015.07.12.16.11.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 16:11:56 -0700 (PDT)
Subject: [PATCH 8/9] MIPS: Remove "weak" from mips_cdmm_phys_base()
 declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jul 2015 18:11:54 -0500
Message-ID: <20150712231154.11177.57126.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
X-archive-position: 48211
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
CC: James Hogan <james.hogan@imgtec.com>
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
