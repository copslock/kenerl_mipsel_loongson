Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Nov 2014 23:08:22 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:54469 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013682AbaKOWIUGnTcH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Nov 2014 23:08:20 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1XplVt-0003rO-Km from Maciej_Rozycki@mentor.com ; Sat, 15 Nov 2014 14:08:13 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server (TLS) id 14.3.181.6; Sat, 15 Nov
 2014 22:08:12 +0000
Date:   Sat, 15 Nov 2014 22:08:09 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 3/7] MIPS: signal.c: Fix an invalid cast in ISA mode bit
 handling
In-Reply-To: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
Message-ID: <alpine.DEB.1.10.1411152059520.2881@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44186
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

Fix:

arch/mips/kernel/signal.c: In function 'handle_signal':
arch/mips/kernel/signal.c:533:21: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  unsigned int tmp = (unsigned int)current->mm->context.vdso;
                     ^
arch/mips/kernel/signal.c:536:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  vdso = (void *)tmp;
         ^
cc1: all warnings being treated as errors

when building a 64-bit kernel.

This is not really a supported configuration, but the cast is wrong 
either way, Linux makes the assumption that sizeof(void *) equals 
sizeof(unsigned long) and therefore the latter type is expected to be 
used where integer operations have to be applied to pointers for some 
reason.

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
linux-umips-pointer-size.diff
Index: linux-3.17-stable-malta64/arch/mips/kernel/signal.c
===================================================================
--- linux-3.17-stable-malta64.orig/arch/mips/kernel/signal.c	2014-11-14 04:06:50.000000000 +0000
+++ linux-3.17-stable-malta64/arch/mips/kernel/signal.c	2014-11-14 16:55:05.891621120 +0000
@@ -530,7 +530,7 @@ static void handle_signal(struct ksignal
 	struct mips_abi *abi = current->thread.abi;
 #ifdef CONFIG_CPU_MICROMIPS
 	void *vdso;
-	unsigned int tmp = (unsigned int)current->mm->context.vdso;
+	unsigned long tmp = (unsigned long)current->mm->context.vdso;
 
 	set_isa16_mode(tmp);
 	vdso = (void *)tmp;
