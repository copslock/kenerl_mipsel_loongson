Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 14:04:40 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:54730 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994714AbeBUNEccD-GT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 14:04:32 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F1F661125;
        Wed, 21 Feb 2018 13:04:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.14 111/167] MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN
Date:   Wed, 21 Feb 2018 13:48:42 +0100
Message-Id: <20180221124530.441016161@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corentin Labbe <clabbe.montjoie@gmail.com>

commit 2e6522c565522a2e18409c315c49d78c8b74807b upstream.

MIPS_GENERIC selects some options conditional on BIG_ENDIAN which does
not exist.

Replace BIG_ENDIAN with CPU_BIG_ENDIAN which is the correct kconfig
name. Note that BMIPS_GENERIC does the same which confirms that this
patch is needed.

Fixes: eed0eabd12ef0 ("MIPS: generic: Introduce generic DT-based board support")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.9+
Patchwork: https://patchwork.linux-mips.org/patch/18495/
[jhogan@kernel.org: Clean up commit message]
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -119,12 +119,12 @@ config MIPS_GENERIC
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_RELOCATABLE
 	select SYS_SUPPORTS_SMARTMIPS
-	select USB_EHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_EHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
-	select USB_OHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_OHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
-	select USB_UHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_UHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USE_OF
 	help
 	  Select this to build a kernel which aims to support multiple boards,
