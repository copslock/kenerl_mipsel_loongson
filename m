Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 01:12:08 +0200 (CEST)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35479 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010499AbbGLXL35A2Le (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 01:11:29 +0200
Received: by iecuq6 with SMTP id uq6so224725089iec.2
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 16:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Wcrj2i5XTq+CqQwQPClxVOjIfDIhfj2MotilXscR5jE=;
        b=mWY6mqD5qOu+IhE2bBs+2Jdng4wXSoDlO1MnLAcLKdg6UzINUPke6rQIeaaFocFZ7R
         hp1J0Mq917yHuzCjpQvHrWiofFNrw6qvsTzRt3GhGrXjJdQvQKt1V0+zYtnPcjV+ZACS
         t7bgnA3+U5QrO9gEdqqQ2IbBUcJIyWIxxG396W8U8fnL9jwxJ59525sGJr6W/bfATpxv
         xAz9rPb6O6G1RPnFhTjhuZwOfyN0sgOHfr6bKw2VYxU8LCgj5X/PqrMYIV7H8SUZpXXk
         6o+WThE1Gj4qlVLoUOjOyaekwBHxmTNc8F+xgZNhggB+saBUR0RMvY9PnY8ylGO+LX7r
         3WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Wcrj2i5XTq+CqQwQPClxVOjIfDIhfj2MotilXscR5jE=;
        b=cGIHwgdvHKrs0zjuYSZisxnJs0JqfcaY8ZuGaC8m3gt8LDldqbCY8dT8n0HnCB2KQQ
         /pOTSf4hnKgi1BWDH+wdjT2ufXyUnGh5oD2ENjLMMlVqkKiVBHxv6sxZ+0FHdlCTJ3BH
         wQ0oGEtQtPMrMnn0uSDtkVjcaIcOWnOj1XZWBleJicsDnaAXMh64KrhCw6ANLl/xmNQ8
         3p4HQ5GSlN3GKh04/Ko2f6WcLWt5j2AFWihq7fr9MR/tyfDSmCVcAeWSH/IxF+2LDxFe
         Zk+pCGHXt2vir3iiGuoM1spTuWPb2SGFQSvmXSJCXCu2WCzEr9drtMTzXrP57LtfulDN
         NwjQ==
X-Gm-Message-State: ALoCoQmI3F3eMts593+Rguavs+VwcIIbclgagmXhRxauI+1qfcHUV8OSuyCUSy3fSRG9htO4TASv
X-Received: by 10.50.102.98 with SMTP id fn2mr8600404igb.55.1436742684384;
        Sun, 12 Jul 2015 16:11:24 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id b9sm10388637ioj.6.2015.07.12.16.11.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 16:11:23 -0700 (PDT)
Subject: [PATCH 4/9] MIPS: MT: Remove "weak" from vpe_run() declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jul 2015 18:11:20 -0500
Message-ID: <20150712231120.11177.53145.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
X-archive-position: 48207
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

That's not a problem for vpe_run() because Kconfig ensures there's never
more than one definition:

  - vpe_run() is defined in arch/mips/kernel/vpe-mt.c if
    CONFIG_MIPS_VPE_LOADER_MT=y

  - vpe_run() is defined in arch/mips/mti-malta/malta-amon.c if
    CONFIG_MIPS_CMP=y

  - CONFIG_MIPS_VPE_LOADER_MT cannot be set if CONFIG_MIPS_CMP=y

But it's simpler to verify correctness if we remove "weak" from the picture
and test the config symbols directly.

Remove "weak" from the vpe_run() declaration and use #if to test whether a
definition should be present.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/include/asm/vpe.h |    2 +-
 arch/mips/kernel/vpe.c      |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index 7849f39..80e70db 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -122,7 +122,7 @@ void release_vpe(struct vpe *v);
 void *alloc_progmem(unsigned long len);
 void release_progmem(void *ptr);
 
-int __weak vpe_run(struct vpe *v);
+int vpe_run(struct vpe *v);
 void cleanup_tc(struct tc *tc);
 
 int __init vpe_module_init(void);
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 72cae9f..04539d6 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -817,15 +817,11 @@ static int vpe_open(struct inode *inode, struct file *filp)
 
 static int vpe_release(struct inode *inode, struct file *filp)
 {
+#if defined(CONFIG_MIPS_VPE_LOADER_MT) || defined(CONFIG_MIPS_CMP)
 	struct vpe *v;
 	Elf_Ehdr *hdr;
 	int ret = 0;
 
-	if (!vpe_run) {
-		pr_warn("VPE loader: ELF load failed.\n");
-		return -ENOEXEC;
-	}
-
 	v = get_vpe(aprp_cpu_index());
 	if (v == NULL)
 		return -ENODEV;
@@ -855,6 +851,10 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	v->plen = 0;
 
 	return ret;
+#else
+	pr_warn("VPE loader: ELF load failed.\n");
+	return -ENOEXEC;
+#endif
 }
 
 static ssize_t vpe_write(struct file *file, const char __user *buffer,
