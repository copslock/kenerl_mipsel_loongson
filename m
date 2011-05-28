Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2011 13:17:18 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45155 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1490987Ab1E1LRO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 May 2011 13:17:14 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4SBHIl3009535
        for <linux-mips@linux-mips.org>; Sat, 28 May 2011 12:17:18 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4SBHISB009534
        for linux-mips@linux-mips.org; Sat, 28 May 2011 12:17:18 +0100
Date:   Sat, 28 May 2011 12:17:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: PC speaker
Message-ID: <20110528111717.GA9443@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Everybody's favorite sound experience - some old games just aren't right
with 24-bit sound from 100W speakers ;)

This patch allows the PC speaker support to be selected again on RM200,
Jazz family machines and the MIPS Malta - but it's quite some time, I'm
not even sure which of the MIPS platforms actually support a PC speaker.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a4b2973..a7e383a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -192,6 +192,7 @@ config MACH_JAZZ
 	select IRQ_CPU
 	select I8259
 	select ISA
+	select PCSPKR_PLATFORM
 	select SYS_HAS_CPU_R4X00
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
@@ -279,6 +280,7 @@ config MIPS_MALTA
 	select MIPS_BONITO64
 	select MIPS_CPU_SCACHE
 	select PCI_GT64XXX_PCI0
+	select PCSPKR_PLATFORM
 	select MIPS_MSC
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
@@ -654,6 +656,7 @@ config SNI_RM
 	select IRQ_CPU
 	select I8259
 	select ISA
+	select PCSPKR_PLATFORM
 	select SWAP_IO_SPACE if CPU_BIG_ENDIAN
 	select SYS_HAS_CPU_R4X00
 	select SYS_HAS_CPU_R5000
