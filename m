Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 13:43:09 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:40069 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860095AbaGaLnHEUvRG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 13:43:07 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.14.9/8.14.5) with ESMTP id s6VBgwtZ004192
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 31 Jul 2014 04:42:59 -0700 (PDT)
Received: from pek-wyang1-d1.wrs.com (128.224.162.170) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.174.1; Thu, 31 Jul 2014 04:42:58 -0700
From:   <Wei.Yang@windriver.com>
To:     <ralf@linux-mips.org>
CC:     <Wei.Yang@windriver.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] MIPS:KDUMP: set a right value to kexec_indirection_page variable
Date:   Thu, 31 Jul 2014 19:42:29 +0800
Message-ID: <1406806949-27039-1-git-send-email-Wei.Yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Wei.Yang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Wei.Yang@windriver.com
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

From: Yang Wei <Wei.Yang@windriver.com>

Since there is not indirection page in crash type, so the vaule of the head
field of kimage structure is not equal to the address of indirection page but
IND_DONE. so we have to set kexec_indirection_page variable to the address of
the head field of image structure.

Signed-off-by: Yang Wei <Wei.Yang@windriver.com>

          Hi Ralf,

		  Please help me take a look at this patch, I have already verified it on Cavium 6100EVB board.

		  Thanks
		  Wei
---
 arch/mips/kernel/machine_kexec.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 992e184..531b70d 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -71,8 +71,13 @@ machine_kexec(struct kimage *image)
 	kexec_start_address =
 		(unsigned long) phys_to_virt(image->start);
 
-	kexec_indirection_page =
-		(unsigned long) phys_to_virt(image->head & PAGE_MASK);
+	if (image->type == KEXEC_TYPE_DEFAULT) {
+		kexec_indirection_page =
+			(unsigned long) phys_to_virt(image->head & PAGE_MASK);
+	} else {
+		kexec_indirection_page = (unsigned long)&image->head;
+	}
+	
 
 	memcpy((void*)reboot_code_buffer, relocate_new_kernel,
 	       relocate_new_kernel_size);
-- 
1.7.9.5
