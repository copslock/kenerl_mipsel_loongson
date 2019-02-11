Return-Path: <SRS0=yT8e=QS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268DDC282DA
	for <linux-mips@archiver.kernel.org>; Mon, 11 Feb 2019 13:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4339218F0
	for <linux-mips@archiver.kernel.org>; Mon, 11 Feb 2019 13:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4itl8ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfBKNgf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:36:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfBKNgd (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 11 Feb 2019 08:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O8I73hNgPq1i0YknAQzZK/SZwGESK6ho2LgdRemJ6wA=; b=T4itl8ESeCAofrA7v9hAqYnGpH
        Qeq7kBbM7eQXlgtubYFQxGfspMYFsFqKUrs4s3F7ksTQ+1K1hp1P2zc+Ac4zLsrJtOUR9x2mamSwu
        ewAcyxfHIVh7fxM64wROIZ/7oVY9Uj7avBdNa23gbHzRe5OyWelTCGkH4XBh648f2jwpzHPWxw0hR
        kcYwLzFC3y9Iaa2ANHBwoWCbBKDTGVzmxqU7V73c/W2ApqHYiIQrCOfyioHL2BJS3qeV2ax1z+Hhk
        Y0kAZoNwttq+v6x+grIoveQHPU90cNYJnvYTgr97Ysn+4nA/UXchhoN//Cvswd1sXVZusojZA2mJT
        XTkas5kA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBl2-0000Hx-40; Mon, 11 Feb 2019 13:36:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] dma-mapping: remove the DMA_MEMORY_EXCLUSIVE flag
Date:   Mon, 11 Feb 2019 14:35:51 +0100
Message-Id: <20190211133554.30055-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

All users of dma_declare_coherent want their allocations to be
exclusive, so default to exclusive allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API.txt                     |  9 +------
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c   | 12 +++------
 arch/arm/mach-imx/mach-mx31moboard.c          |  3 +--
 arch/sh/boards/mach-ap325rxa/setup.c          |  5 ++--
 arch/sh/boards/mach-ecovec24/setup.c          |  6 ++---
 arch/sh/boards/mach-kfr2r09/setup.c           |  5 ++--
 arch/sh/boards/mach-migor/setup.c             |  5 ++--
 arch/sh/boards/mach-se/7724/setup.c           |  6 ++---
 arch/sh/drivers/pci/fixups-dreamcast.c        |  3 +--
 .../soc_camera/sh_mobile_ceu_camera.c         |  3 +--
 drivers/usb/host/ohci-sm501.c                 |  3 +--
 drivers/usb/host/ohci-tmio.c                  |  2 +-
 include/linux/dma-mapping.h                   |  7 ++----
 kernel/dma/coherent.c                         | 25 ++++++-------------
 14 files changed, 29 insertions(+), 65 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index b9d0cba83877..38e561b773b4 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -566,8 +566,7 @@ boundaries when doing this.
 
 	int
 	dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
-				    dma_addr_t device_addr, size_t size, int
-				    flags)
+				    dma_addr_t device_addr, size_t size);
 
 Declare region of memory to be handed out by dma_alloc_coherent() when
 it's asked for coherent memory for this device.
@@ -581,12 +580,6 @@ dma_addr_t in dma_alloc_coherent()).
 
 size is the size of the area (must be multiples of PAGE_SIZE).
 
-flags can be ORed together and are:
-
-- DMA_MEMORY_EXCLUSIVE - only allocate memory from the declared regions.
-  Do not allow dma_alloc_coherent() to fall back to system memory when
-  it's out of memory in the declared region.
-
 As a simplification for the platforms, only *one* such region of
 memory may be declared per device.
 
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 5169dfba9718..07d4fcfe5c2e 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -258,8 +258,7 @@ static void __init visstrim_analog_camera_init(void)
 		return;
 
 	dma_declare_coherent_memory(&pdev->dev, mx2_camera_base,
-				    mx2_camera_base, MX2_CAMERA_BUF_SIZE,
-				    DMA_MEMORY_EXCLUSIVE);
+				    mx2_camera_base, MX2_CAMERA_BUF_SIZE);
 }
 
 static void __init visstrim_reserve(void)
@@ -445,8 +444,7 @@ static void __init visstrim_coda_init(void)
 	dma_declare_coherent_memory(&pdev->dev,
 				    mx2_camera_base + MX2_CAMERA_BUF_SIZE,
 				    mx2_camera_base + MX2_CAMERA_BUF_SIZE,
-				    MX2_CAMERA_BUF_SIZE,
-				    DMA_MEMORY_EXCLUSIVE);
+				    MX2_CAMERA_BUF_SIZE);
 }
 
 /* DMA deinterlace */
@@ -465,8 +463,7 @@ static void __init visstrim_deinterlace_init(void)
 	dma_declare_coherent_memory(&pdev->dev,
 				    mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
 				    mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
-				    MX2_CAMERA_BUF_SIZE,
-				    DMA_MEMORY_EXCLUSIVE);
+				    MX2_CAMERA_BUF_SIZE);
 }
 
 /* Emma-PrP for format conversion */
@@ -485,8 +482,7 @@ static void __init visstrim_emmaprp_init(void)
 	 */
 	ret = dma_declare_coherent_memory(&pdev->dev,
 				mx2_camera_base, mx2_camera_base,
-				MX2_CAMERA_BUF_SIZE,
-				DMA_MEMORY_EXCLUSIVE);
+				MX2_CAMERA_BUF_SIZE);
 	if (ret)
 		pr_err("Failed to declare memory for emmaprp\n");
 }
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 643a3d749703..fe50f4cf00a7 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -475,8 +475,7 @@ static int __init mx31moboard_init_cam(void)
 
 	ret = dma_declare_coherent_memory(&pdev->dev,
 					  mx3_camera_base, mx3_camera_base,
-					  MX3_CAMERA_BUF_SIZE,
-					  DMA_MEMORY_EXCLUSIVE);
+					  MX3_CAMERA_BUF_SIZE);
 	if (ret)
 		goto err;
 
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 8f234d0435aa..7899b4f51fdd 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -529,9 +529,8 @@ static int __init ap325rxa_devices_setup(void)
 	device_initialize(&ap325rxa_ceu_device.dev);
 	arch_setup_pdev_archdata(&ap325rxa_ceu_device);
 	dma_declare_coherent_memory(&ap325rxa_ceu_device.dev,
-				    ceu_dma_membase, ceu_dma_membase,
-				    ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1,
-				    DMA_MEMORY_EXCLUSIVE);
+			ceu_dma_membase, ceu_dma_membase,
+			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
 
 	platform_device_add(&ap325rxa_ceu_device);
 
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 22b4106b8084..eb66754cfb8c 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1440,8 +1440,7 @@ static int __init arch_setup(void)
 	dma_declare_coherent_memory(&ecovec_ceu_devices[0]->dev,
 				    ceu0_dma_membase, ceu0_dma_membase,
 				    ceu0_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1,
-				    DMA_MEMORY_EXCLUSIVE);
+				    CEU_BUFFER_MEMORY_SIZE - 1);
 	platform_device_add(ecovec_ceu_devices[0]);
 
 	device_initialize(&ecovec_ceu_devices[1]->dev);
@@ -1449,8 +1448,7 @@ static int __init arch_setup(void)
 	dma_declare_coherent_memory(&ecovec_ceu_devices[1]->dev,
 				    ceu1_dma_membase, ceu1_dma_membase,
 				    ceu1_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1,
-				    DMA_MEMORY_EXCLUSIVE);
+				    CEU_BUFFER_MEMORY_SIZE - 1);
 	platform_device_add(ecovec_ceu_devices[1]);
 
 	gpiod_add_lookup_table(&cn12_power_gpiod_table);
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 203d249a0a2b..b8bf67c86eab 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -603,9 +603,8 @@ static int __init kfr2r09_devices_setup(void)
 	device_initialize(&kfr2r09_ceu_device.dev);
 	arch_setup_pdev_archdata(&kfr2r09_ceu_device);
 	dma_declare_coherent_memory(&kfr2r09_ceu_device.dev,
-				    ceu_dma_membase, ceu_dma_membase,
-				    ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1,
-				    DMA_MEMORY_EXCLUSIVE);
+			ceu_dma_membase, ceu_dma_membase,
+			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
 
 	platform_device_add(&kfr2r09_ceu_device);
 
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index f4ad33c6d2aa..bcd249e6cfcc 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -603,9 +603,8 @@ static int __init migor_devices_setup(void)
 	device_initialize(&migor_ceu_device.dev);
 	arch_setup_pdev_archdata(&migor_ceu_device);
 	dma_declare_coherent_memory(&migor_ceu_device.dev,
-				    ceu_dma_membase, ceu_dma_membase,
-				    ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1,
-				    DMA_MEMORY_EXCLUSIVE);
+			ceu_dma_membase, ceu_dma_membase,
+			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
 
 	platform_device_add(&migor_ceu_device);
 
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index fdbec22ae687..13c2d3ce78f4 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -941,8 +941,7 @@ static int __init devices_setup(void)
 	dma_declare_coherent_memory(&ms7724se_ceu_devices[0]->dev,
 				    ceu0_dma_membase, ceu0_dma_membase,
 				    ceu0_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1,
-				    DMA_MEMORY_EXCLUSIVE);
+				    CEU_BUFFER_MEMORY_SIZE - 1);
 	platform_device_add(ms7724se_ceu_devices[0]);
 
 	device_initialize(&ms7724se_ceu_devices[1]->dev);
@@ -950,8 +949,7 @@ static int __init devices_setup(void)
 	dma_declare_coherent_memory(&ms7724se_ceu_devices[1]->dev,
 				    ceu1_dma_membase, ceu1_dma_membase,
 				    ceu1_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1,
-				    DMA_MEMORY_EXCLUSIVE);
+				    CEU_BUFFER_MEMORY_SIZE - 1);
 	platform_device_add(ms7724se_ceu_devices[1]);
 
 	return platform_add_devices(ms7724se_devices,
diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
index dfdbd05b6eb1..7be8694c0d13 100644
--- a/arch/sh/drivers/pci/fixups-dreamcast.c
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c
@@ -63,8 +63,7 @@ static void gapspci_fixup_resources(struct pci_dev *dev)
 		BUG_ON(dma_declare_coherent_memory(&dev->dev,
 						res.start,
 						region.start,
-						resource_size(&res),
-						DMA_MEMORY_EXCLUSIVE));
+						resource_size(&res)));
 		break;
 	default:
 		printk("PCI: Failed resource fixup\n");
diff --git a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
index 6803f744e307..cc357b8db1dc 100644
--- a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
+++ b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
@@ -1708,8 +1708,7 @@ static int sh_mobile_ceu_probe(struct platform_device *pdev)
 	if (res) {
 		err = dma_declare_coherent_memory(&pdev->dev, res->start,
 						  res->start,
-						  resource_size(res),
-						  DMA_MEMORY_EXCLUSIVE);
+						  resource_size(res));
 		if (err) {
 			dev_err(&pdev->dev, "Unable to declare CEU memory.\n");
 			return err;
diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index c9233cddf9a2..c26228c25f99 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -126,8 +126,7 @@ static int ohci_hcd_sm501_drv_probe(struct platform_device *pdev)
 
 	retval = dma_declare_coherent_memory(dev, mem->start,
 					 mem->start - mem->parent->start,
-					 resource_size(mem),
-					 DMA_MEMORY_EXCLUSIVE);
+					 resource_size(mem));
 	if (retval) {
 		dev_err(dev, "cannot declare coherent memory\n");
 		goto err1;
diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index a631dbb369d7..f88a0370659f 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -225,7 +225,7 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	}
 
 	ret = dma_declare_coherent_memory(&dev->dev, sram->start, sram->start,
-				resource_size(sram), DMA_MEMORY_EXCLUSIVE);
+				resource_size(sram));
 	if (ret)
 		goto err_dma_declare;
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 9df0f4d318c5..b12fba725f19 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -728,17 +728,14 @@ static inline int dma_get_cache_alignment(void)
 	return 1;
 }
 
-/* flags for the coherent memory api */
-#define DMA_MEMORY_EXCLUSIVE		0x01
-
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
-				dma_addr_t device_addr, size_t size, int flags);
+				dma_addr_t device_addr, size_t size);
 void dma_release_declared_memory(struct device *dev);
 #else
 static inline int
 dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
-			    dma_addr_t device_addr, size_t size, int flags)
+			    dma_addr_t device_addr, size_t size)
 {
 	return -ENOSYS;
 }
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 1d12a31af6d7..29fd6590dc1e 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -14,7 +14,6 @@ struct dma_coherent_mem {
 	dma_addr_t	device_base;
 	unsigned long	pfn_base;
 	int		size;
-	int		flags;
 	unsigned long	*bitmap;
 	spinlock_t	spinlock;
 	bool		use_dev_dma_pfn_offset;
@@ -38,9 +37,9 @@ static inline dma_addr_t dma_get_device_base(struct device *dev,
 		return mem->device_base;
 }
 
-static int dma_init_coherent_memory(
-	phys_addr_t phys_addr, dma_addr_t device_addr, size_t size, int flags,
-	struct dma_coherent_mem **mem)
+static int dma_init_coherent_memory(phys_addr_t phys_addr,
+		dma_addr_t device_addr, size_t size,
+		struct dma_coherent_mem **mem)
 {
 	struct dma_coherent_mem *dma_mem = NULL;
 	void *mem_base = NULL;
@@ -73,7 +72,6 @@ static int dma_init_coherent_memory(
 	dma_mem->device_base = device_addr;
 	dma_mem->pfn_base = PFN_DOWN(phys_addr);
 	dma_mem->size = pages;
-	dma_mem->flags = flags;
 	spin_lock_init(&dma_mem->spinlock);
 
 	*mem = dma_mem;
@@ -110,12 +108,12 @@ static int dma_assign_coherent_memory(struct device *dev,
 }
 
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
-				dma_addr_t device_addr, size_t size, int flags)
+				dma_addr_t device_addr, size_t size)
 {
 	struct dma_coherent_mem *mem;
 	int ret;
 
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, flags, &mem);
+	ret = dma_init_coherent_memory(phys_addr, device_addr, size, &mem);
 	if (ret)
 		return ret;
 
@@ -190,15 +188,7 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 		return 0;
 
 	*ret = __dma_alloc_from_coherent(mem, size, dma_handle);
-	if (*ret)
-		return 1;
-
-	/*
-	 * In the case where the allocation can not be satisfied from the
-	 * per-device area, try to fall back to generic memory if the
-	 * constraints allow it.
-	 */
-	return mem->flags & DMA_MEMORY_EXCLUSIVE;
+	return 1;
 }
 
 void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
@@ -327,8 +317,7 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 
 	if (!mem) {
 		ret = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size,
-					       DMA_MEMORY_EXCLUSIVE, &mem);
+					       rmem->size, &mem);
 		if (ret) {
 			pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
 				&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.20.1

