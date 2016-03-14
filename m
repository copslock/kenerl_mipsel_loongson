Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 18:52:06 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007808AbcCNRwEwzz0i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Mar 2016 18:52:04 +0100
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7BAF5D0A;
        Mon, 14 Mar 2016 17:51:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 46/50] MIPS: Fix build error when SMP is used without GIC
Date:   Mon, 14 Mar 2016 10:51:04 -0700
Message-Id: <20160314175019.898810635@linuxfoundation.org>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <20160314175013.403628835@linuxfoundation.org>
References: <20160314175013.403628835@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52584
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hauke Mehrtens <hauke@hauke-m.de>

commit 7a50e4688dabb8005df39b2b992d76629b8af8aa upstream.

The MIPS_GIC_IPI should only be selected when MIPS_GIC is also
selected, otherwise it results in a compile error. smp-gic.c uses some
functions from include/linux/irqchip/mips-gic.h like
plat_ipi_call_int_xlate() which are only added to the header file when
MIPS_GIC is set. The Lantiq SoC does not use the GIC, but supports SMP.
The calls top the functions from smp-gic.c are already protected by
some #ifdefs

The first part of this was introduced in commit 72e20142b2bf ("MIPS:
Move GIC IPI functions out of smp-cmp.c")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12774/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2155,7 +2155,7 @@ config MIPS_MT_SMP
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select MIPS_MT
 	select SMP
 	select SMP_UP
@@ -2253,7 +2253,7 @@ config MIPS_VPE_APSP_API_MT
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MIPS_CMP && !CPU_MIPSR6
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select SMP
 	select SYNC_R4K
 	select SYS_SUPPORTS_SMP
@@ -2273,7 +2273,7 @@ config MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
@@ -2292,6 +2292,7 @@ config MIPS_CPS_PM
 	bool
 
 config MIPS_GIC_IPI
+	depends on MIPS_GIC
 	bool
 
 config MIPS_CM
