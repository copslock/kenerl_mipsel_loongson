Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 18:31:26 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:20625 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21366446AbZA1SbX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Jan 2009 18:31:23 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0SIUsn7001740;
	Wed, 28 Jan 2009 18:30:54 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0SIUlLn001737;
	Wed, 28 Jan 2009 18:30:47 GMT
Date:	Wed, 28 Jan 2009 18:30:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ddaney@caviumnetworks.com, msundius@cisco.com,
	linux-mips@linux-mips.org, dvomlehn@cisco.com, msundius@sundius.com
Subject: Re: memcpy and prefetch
Message-ID: <20090128183047.GA1691@linux-mips.org>
References: <497F9214.1000609@cisco.com> <497F93C1.3090401@caviumnetworks.com> <20090128103753.GC2234@linux-mips.org> <20090129.002850.118974677.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090129.002850.118974677.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 29, 2009 at 12:28:50AM +0900, Atsushi Nemoto wrote:

> #if !defined(CONFIG_DMA_COHERENT) || !defined(CONFIG_DMA_IP27)
> #undef CONFIG_CPU_HAS_PREFETCH
> #endif
> #ifdef CONFIG_MIPS_MALTA
> #undef CONFIG_CPU_HAS_PREFETCH
> #endif
> 
> Are there any configuration which do not undef CONFIG_CPU_HAS_PREFETCH ? ;-)

Yes, that's been a long standing one.  Fixed also.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 52c80c2..71e8ebd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -351,7 +351,7 @@ config SGI_IP27
 	select ARC64
 	select BOOT_ELF64
 	select DEFAULT_SGI_PARTITION
-	select DMA_IP27
+	select DMA_COHERENT
 	select SYS_HAS_EARLY_PRINTK
 	select HW_HAS_PCI
 	select NR_CPUS_DEFAULT_64
@@ -761,9 +761,6 @@ config CFE
 config DMA_COHERENT
 	bool
 
-config DMA_IP27
-	bool
-
 config DMA_NONCOHERENT
 	bool
 	select DMA_NEED_PCI_MAP_STATE
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 34ea319..f2baea3 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -53,7 +53,7 @@ CONFIG_GENERIC_TIME=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_ARC=y
-CONFIG_DMA_IP27=y
+CONFIG_DMA_COHERENT=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_SYS_HAS_EARLY_PRINTK=y
 # CONFIG_NO_IOPORT is not set
diff --git a/arch/mips/lib/memcpy-inatomic.S b/arch/mips/lib/memcpy-inatomic.S
index 736d0fb..68853a0 100644
--- a/arch/mips/lib/memcpy-inatomic.S
+++ b/arch/mips/lib/memcpy-inatomic.S
@@ -21,7 +21,7 @@
  * end of memory on some systems.  It's also a seriously bad idea on non
  * dma-coherent systems.
  */
-#if !defined(CONFIG_DMA_COHERENT) || !defined(CONFIG_DMA_IP27)
+#ifdef CONFIG_DMA_NONCOHERENT
 #undef CONFIG_CPU_HAS_PREFETCH
 #endif
 #ifdef CONFIG_MIPS_MALTA
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index c06cccf..56a1f85 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -21,7 +21,7 @@
  * end of memory on some systems.  It's also a seriously bad idea on non
  * dma-coherent systems.
  */
-#if !defined(CONFIG_DMA_COHERENT) || !defined(CONFIG_DMA_IP27)
+#ifdef CONFIG_DMA_NONCOHERENT
 #undef CONFIG_CPU_HAS_PREFETCH
 #endif
 #ifdef CONFIG_MIPS_MALTA
