Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Nov 2004 03:24:36 +0000 (GMT)
Received: from hibernia.jakma.org ([IPv6:::ffff:212.17.55.49]:27288 "EHLO
	hibernia.jakma.org") by linux-mips.org with ESMTP
	id <S8225250AbUK1DYa>; Sun, 28 Nov 2004 03:24:30 +0000
Received: from sheen.jakma.org (sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.12.11/8.12.11) with ESMTP id iAS3ODu1005166
	for <linux-mips@linux-mips.org>; Sun, 28 Nov 2004 03:24:15 GMT
Date: Sun, 28 Nov 2004 03:24:13 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Linux MIPS <linux-mips@linux-mips.org>
Subject: ip32 kconfig patch
Message-ID: <Pine.LNX.4.61.0411280316090.6275@sheen.jakma.org>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <paul@clubi.ie>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@clubi.ie
Precedence: bulk
X-list: linux-mips

Hi,

IP32 needs the below to build CVS. rm7k_sc_enable and 
__rm7k_sc_enable in arch/mips/mm/sc-r7k.c reference the MIPS32 
KSEG{0,1}ADDR macros. I dont know enough about MIPS to fixup the 
KSEGxADDR references unfortunately, but this lets me build for R10k 
at least.

Resulting kernel didnt /seem/ to boot though on an R12k O2 - I cant 
tell for sure sadly, no console at all, but it didnt blink the 
keyboard leds - and not sure if thats related.. i think r10k and r12k 
use the r4k cache enable functions, anyone know?.

Index: arch/mips/Kconfig
===================================================================
RCS file: /home/cvs/linux/arch/mips/Kconfig,v
retrieving revision 1.109
diff -u -6 -r1.109 Kconfig
--- arch/mips/Kconfig	24 Nov 2004 09:03:40 -0000	1.109
+++ arch/mips/Kconfig	28 Nov 2004 03:15:10 -0000
@@ -494,13 +494,12 @@
  config SGI_IP32
  	bool "Support for SGI IP32 (O2) (EXPERIMENTAL)"
  	depends on MIPS64 && EXPERIMENTAL
  	select DMA_NONCOHERENT
  	select HW_HAS_PCI
  	select R5000_CPU_SCACHE
-	select RM7000_CPU_SCACHE
  	help
  	  If you want this kernel to run on SGI O2 workstation, say Y here.

  config SOC_AU1X00
  	depends on MIPS32
  	bool "Support for AMD/Alchemy Au1X00 SOCs"

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
There is nothing wrong with Southern California that a rise in the
ocean level wouldn't cure.
 		-- Ross MacDonald
