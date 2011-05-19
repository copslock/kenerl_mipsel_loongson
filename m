Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 15:30:50 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46527 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491073Ab1ESNar (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2011 15:30:47 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4JDUqqS030732;
        Thu, 19 May 2011 14:30:52 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4JDUpUY030729;
        Thu, 19 May 2011 14:30:51 +0100
Date:   Thu, 19 May 2011 14:30:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: DMA: Add plat_extra_sync_for_cpu()
Message-ID: <20110519133051.GA30483@linux-mips.org>
References: <064bb0722da5d8c271c2bd9fe0a521cc@localhost>
 <99a0868bdbcfa8785a92b4af4f6d9b99@localhost>
 <4C88AA27.5070206@mvista.com>
 <AANLkTinAhsetaV2F8SfBZE_BtaMhhmJO2fEwL+LJpZxB@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTinAhsetaV2F8SfBZE_BtaMhhmJO2fEwL+LJpZxB@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 09, 2010 at 05:39:32AM -0700, Kevin Cernekee wrote:

> On Thu, Sep 9, 2010 at 2:34 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> >> +static inline void plat_extra_sync_for_cpu(struct device *dev,
> >> +       dma_addr_t dma_handle, unsigned long offset, size_t size,
> >> +       enum dma_data_direction direction)
> >> +{
> >> +       return;
> >
> >   Why not just empty function bodies?
> 
> For consistency with plat_extra_sync_for_device().

Consistency is good - but let's just stop the madness.  The lone return
in a void function doesn't help readability and I'm not sure how it ever
got into the code.  I just went through all the MIPS includes and cleaned
all instances I found.

  Ralf

MIPS: Remove pointless return statement from empty void functions.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/irq.h                         |    1 -
 arch/mips/include/asm/mach-generic/dma-coherence.h  |    1 -
 arch/mips/include/asm/mach-ip27/dma-coherence.h     |    1 -
 arch/mips/include/asm/mach-jazz/dma-coherence.h     |    1 -
 arch/mips/include/asm/mach-loongson/dma-coherence.h |    1 -
 arch/mips/include/asm/mach-powertv/dma-coherence.h  |    1 -
 6 files changed, 6 deletions(-)

Index: linux-queue/arch/mips/include/asm/mach-ip27/dma-coherence.h
===================================================================
--- linux-queue.orig/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ linux-queue/arch/mips/include/asm/mach-ip27/dma-coherence.h
@@ -60,7 +60,6 @@ static inline int plat_dma_supported(str
 
 static inline void plat_extra_sync_for_device(struct device *dev)
 {
-	return;
 }
 
 static inline int plat_dma_mapping_error(struct device *dev,
Index: linux-queue/arch/mips/include/asm/irq.h
===================================================================
--- linux-queue.orig/arch/mips/include/asm/irq.h
+++ linux-queue/arch/mips/include/asm/irq.h
@@ -18,7 +18,6 @@
 
 static inline void irq_dispose_mapping(unsigned int virq)
 {
-	return;
 }
 
 #ifdef CONFIG_I8259
Index: linux-queue/arch/mips/include/asm/mach-generic/dma-coherence.h
===================================================================
--- linux-queue.orig/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ linux-queue/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -49,7 +49,6 @@ static inline int plat_dma_supported(str
 
 static inline void plat_extra_sync_for_device(struct device *dev)
 {
-	return;
 }
 
 static inline int plat_dma_mapping_error(struct device *dev,
Index: linux-queue/arch/mips/include/asm/mach-jazz/dma-coherence.h
===================================================================
--- linux-queue.orig/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ linux-queue/arch/mips/include/asm/mach-jazz/dma-coherence.h
@@ -50,7 +50,6 @@ static inline int plat_dma_supported(str
 
 static inline void plat_extra_sync_for_device(struct device *dev)
 {
-	return;
 }
 
 static inline int plat_dma_mapping_error(struct device *dev,
Index: linux-queue/arch/mips/include/asm/mach-loongson/dma-coherence.h
===================================================================
--- linux-queue.orig/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ linux-queue/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -55,7 +55,6 @@ static inline int plat_dma_supported(str
 
 static inline void plat_extra_sync_for_device(struct device *dev)
 {
-	return;
 }
 
 static inline int plat_dma_mapping_error(struct device *dev,
Index: linux-queue/arch/mips/include/asm/mach-powertv/dma-coherence.h
===================================================================
--- linux-queue.orig/arch/mips/include/asm/mach-powertv/dma-coherence.h
+++ linux-queue/arch/mips/include/asm/mach-powertv/dma-coherence.h
@@ -102,7 +102,6 @@ static inline int plat_dma_supported(str
 
 static inline void plat_extra_sync_for_device(struct device *dev)
 {
-	return;
 }
 
 static inline int plat_dma_mapping_error(struct device *dev,
