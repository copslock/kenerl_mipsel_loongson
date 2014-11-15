Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Nov 2014 23:07:25 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:54440 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013726AbaKOWHWND9rm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Nov 2014 23:07:22 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1XplUu-0003ej-CC from Maciej_Rozycki@mentor.com ; Sat, 15 Nov 2014 14:07:12 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server (TLS) id 14.3.181.6; Sat, 15 Nov
 2014 22:07:10 +0000
Date:   Sat, 15 Nov 2014 22:07:07 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 1/7] MIPS: Kconfig: Enable microMIPS support for Malta
In-Reply-To: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
Message-ID: <alpine.DEB.1.10.1411152040190.2881@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

Add missing microMIPS support to Malta.  Currently the kernel only 
enables support for the instruction set for the SEAD-3 board despite the 
fact processor features have nothing to do with the board a processor is 
installed in.

In this case there is no way to run microMIPS software in a fully 
supported way under Linux on QEMU.  QEMU supports the emulation of a 
Malta board, but does not emulate SEAD-3.  Linux supports running 
microMIPS code on a SEAD-3 board, but hardcodes such support to off on 
an emulated Malta board even if the processor selected has the microMIPS 
instruction set implemented.

Adding support for the SEAD-3 to QEMU is a major project.  Flipping a 
bit in the kernel that shouldn't have been cleared in the first place is 
a trivial effort.  Thus the answer is plain...

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
Hi,

 Depending on a processor configuration and particular software run you 
may get away -- as long as your code doesn't trap into the kernel for 
emulation.  This makes things even more frustrating as the thing appears 
to run at first and then breaks in an odd place.

 Frankly I fail to see the point of having microMIPS disabled unless the 
processor implied by the platform is plain too old (e.g. the DECstation) 
or otherwise not ever supposed to support it (e.g. NetLogic or Octeon).  
But I'll leave that for another occasion, for now let's just fix the 
Malta that has an actual use.

 Hmm, we should probably have:

	BUG_ON(!cpu_has_mmips && (cpu_data[0].options & MIPS_CPU_MICROMIPS));

somewhere too, to avoid leading user code astray; we may consider more 
consistency checks like this for cpu-feature-overrides.h, but this one 
is at least semi-obvious.  Another, less invasive way could be the ELF 
loader refusing microMIPS executables if (!cpu_has_mmips), but that has 
the drawback the user won't notice until the last moment.

 We could have a similar `cpu_has_mips16' override too if people are so 
concerned with the kernel binary size increase with optional features, 
and consequently `cpu_has_mips', for pure-microMIPS processors.

 Please apply.

  Maciej

linux-malta-micromips.diff
Index: linux-3.18-rc4-malta/arch/mips/Kconfig
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/Kconfig	2014-11-15 05:55:54.441908087 +0000
+++ linux-3.18-rc4-malta/arch/mips/Kconfig	2014-11-15 05:55:56.441902868 +0000
@@ -340,6 +340,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_MICROMIPS
 	select SYS_SUPPORTS_MIPS_CMP
 	select SYS_SUPPORTS_MIPS_CPS
 	select SYS_SUPPORTS_MIPS16
