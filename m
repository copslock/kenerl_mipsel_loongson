Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 18:47:15 +0200 (CEST)
Received: from mail-ob0-f179.google.com ([209.85.214.179]:32964 "EHLO
        mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009874AbbGNQqsp1ZJn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 18:46:48 +0200
Received: by obbgp5 with SMTP id gp5so9779024obb.0
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=QlxCA5dVj+O/9VIu1MVb6K1G81w5KZvtCW+Cnx/LJn4=;
        b=gT3HnrnArnJLTpddYCii41ahUiev+N8mGT91oL/RUHV6Pmpta/c9uqLx34qREZjo8m
         wZeeojGB9xOGvEejo9at9TxUqErhzIbCn2fKF2HEepGvuI29pdhcDMCJk88zVFdUcRu7
         onhNzz6H/ztZkJ9IX6o03GJAivoT+gJg0TQfhJQXCbPpyoLkuW7nEzeZLMkaJSohv9eD
         YZwWl3V63eqGaQzG+wrUfg1u8aHy8mkiioY9hp/rPQrVzDlSuFfI/dQSVGn7tRGctsrp
         6bK6qPspvIuYUFQXg88HTVZd8l2JdZcSM8p8kTwQj312biYaH2stoctkfS+3XkPbMbvA
         U05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=QlxCA5dVj+O/9VIu1MVb6K1G81w5KZvtCW+Cnx/LJn4=;
        b=b5a9PMMQzJ2/QFENvdk9QXfDEXXMxomfSN8m3ZB5Qn6fG8VLHFktE6e5r3eYVILFJC
         xl1t65D2JRiobsa9sCc0bYF9DMNzxWfcHAddUZ3O3KU0EpjcY6YtblpmFaP+eNfewj3E
         mp5u+py70FUf606zc21YLEeozvS4MyommD+LWYjUVNmoE0Qvqk4pC6cRTwrj8rVuqInK
         QkUyQSVG+GA6QkywfaDDMMCSaTJMc25vJTbAg2i4bc9lJJBJ/aSsA5ryuOOKkZhoNGWU
         xp2Niim+4+qaXMy70xllvBeRTjiX+dPhBNB37a2G8ABquQjiIkCnDyJa6PCmL+wE+9TQ
         o7tw==
X-Gm-Message-State: ALoCoQm1emazkAOAP7QKtxz1bLzzpmmsU6trRMNjLmSolkjGtrPATo8A2mU0ucei79K5a3bKnG+o
X-Received: by 10.60.62.235 with SMTP id b11mr37792942oes.18.1436892401982;
        Tue, 14 Jul 2015 09:46:41 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id mg19sm743127oeb.10.2015.07.14.09.46.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 09:46:40 -0700 (PDT)
Subject: [PATCH v2 3/8] MIPS: MT: Remove "weak" from vpe_run() declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2015 11:46:38 -0500
Message-ID: <20150714164638.1541.68971.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
X-archive-position: 48286
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

That's not a problem for vpe_run() because Kconfig ensures there's exactly
one definition if we build vpe.o:

  - vpe_run() is defined in arch/mips/kernel/vpe-mt.c if
    CONFIG_MIPS_VPE_LOADER_MT=y

  - vpe_run() is defined in arch/mips/mti-malta/malta-amon.c if
    CONFIG_MIPS_VPE_LOADER_CMP=y

  - CONFIG_MIPS_VPE_LOADER_MT and CONFIG_MIPS_VPE_LOADER_CMP cannot both be
    set (MIPS_VPE_LOADER_CMP depends on MIPS_VPE_LOADER && MIPS_CMP;
    MIPS_VPE_LOADER_MT depends on MIPS_VPE_LOADER && !MIPS_CMP)

Remove "weak" from the vpe_run() declaration and don't test whether
vpe_run() is defined.

Simplification-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/include/asm/vpe.h |    2 +-
 arch/mips/kernel/vpe.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index 11da314..1fd05b5 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -827,7 +827,7 @@ static int vpe_release(struct inode *inode, struct file *filp)
 
 	hdr = (Elf_Ehdr *) v->pbuffer;
 	if (memcmp(hdr->e_ident, ELFMAG, SELFMAG) == 0) {
-		if ((vpe_elfload(v) >= 0) && vpe_run) {
+		if (vpe_elfload(v) >= 0) {
 			vpe_run(v);
 		} else {
 			pr_warn("VPE loader: ELF load failed.\n");
