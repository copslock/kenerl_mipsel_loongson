Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 13:39:59 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:46292 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491205Ab0ACMjy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2010 13:39:54 +0100
Received: from list by lo.gmane.org with local (Exim 4.50)
        id 1NRPkM-0007h7-O5
        for linux-mips@linux-mips.org; Sun, 03 Jan 2010 13:39:50 +0100
Received: from rob92-6-82-231-243-221.fbx.proxad.net ([82.231.243.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 03 Jan 2010 13:39:50 +0100
Received: from pascal by rob92-6-82-231-243-221.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 03 Jan 2010 13:39:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   "pascal@pabr.org" <pascal@pabr.org>
Subject:  [RFC] Support 36-bit iomem on 32-bit Au1x00
Date:   Sun, 03 Jan 2010 13:39:12 +0100
Message-ID: <hhq35v$m1q$1@ger.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=ISO-8859-1
Content-Transfer-Encoding:  7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rob92-6-82-231-243-221.fbx.proxad.net
X-archive-position: 25473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pascal@pabr.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1901

Hi,

I believe these changes are needed on Alchemy SoCs in order to
use iomem above 4G with the usual platform_device machinery:

- Set CONFIG_ARCH_PHYS_ADDR_T_64BIT to make resource_size_t 64-bit.
- Increase IOMEM_RESOURCE_END so that platforms can register resources.


--- linux-2.6.33-rc2/arch/mips/Kconfig.orig     2009-12-30 18:06:02.000000000 +0100
+++ linux-2.6.33-rc2/arch/mips/Kconfig  2009-12-30 22:05:38.000000000 +0100
@@ -1725,6 +1725,9 @@
 config 64BIT_PHYS_ADDR
        bool

+config ARCH_PHYS_ADDR_T_64BIT
+       def_bool 64BIT_PHYS_ADDR
+
 config CPU_HAS_SMARTMIPS
        depends on SYS_SUPPORTS_SMARTMIPS
        bool "Support for the SmartMIPS ASE"
--- linux-2.6.33-rc2/arch/mips/include/asm/mach-au1x00/au1000.h.orig    2009-12-30 19:45:35.000000000 +0100
+++ linux-2.6.33-rc2/arch/mips/include/asm/mach-au1x00/au1000.h 2010-01-03 13:28:50.000000000 +0100
@@ -1728,7 +1728,7 @@
 #define IOPORT_RESOURCE_START  0x10000000
 #define IOPORT_RESOURCE_END    0xffffffff
 #define IOMEM_RESOURCE_START   0x10000000
-#define IOMEM_RESOURCE_END     0xffffffff
+#define IOMEM_RESOURCE_END     0xfffffffffLL

 #define PCI_IO_START   0
 #define PCI_IO_END     0
