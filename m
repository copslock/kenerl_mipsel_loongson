Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jun 2013 20:28:51 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39913 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827897Ab3FLS2taEALf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Jun 2013 20:28:49 +0200
Received: by mail-pd0-f176.google.com with SMTP id t12so5530232pdi.7
        for <multiple recipients>; Wed, 12 Jun 2013 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LLB6xyAynAI6jhZjiOPSgZyPcIc1bfok44u+VmNUfPU=;
        b=H+c8k9huxFKIYI4LEjItxLRQkhx7IXFrShPPzqxK+jpYV5yT1sjjoh4y8OQ/SW8gqW
         i4E7U9bMwUrhg187l3uCBJfTuy4x1+SNQ/Id8ulWVaT0epM+ThN6oeDb9CpEGEiD6kTN
         D9qSE+L8QBYyAiBpd79CxlzPYYalW/3yhYV2eE2vtCk+YRTUueOL/HZHSBZjB19C3vYS
         nWHTQ/SV0asx/mSnSuRps1ZHq4a2p+b//pwI4czCqpbU+TWsoD23IDOxnoGn/PiXjAZi
         Ev4nnbbRBqVrjU96wfYWBUacLnybDtB5gwpMBma6hV2tCYJmuZ3Bttnym8UeRvxMLX15
         eREA==
X-Received: by 10.68.89.226 with SMTP id br2mr21392424pbb.101.1371061722996;
        Wed, 12 Jun 2013 11:28:42 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ag4sm20022124pbc.20.2013.06.12.11.28.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Jun 2013 11:28:42 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5CISdeG029064;
        Wed, 12 Jun 2013 11:28:39 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5CISZYI029062;
        Wed, 12 Jun 2013 11:28:35 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: OCTEON: Don't clobber bootloader data structures.
Date:   Wed, 12 Jun 2013 11:28:33 -0700
Message-Id: <1371061713-29028-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Commit abe77f90dc (MIPS: Octeon: Add kexec and kdump support) added a
bootmem region for the kernel image itself.  The problem is that this
is rounded up to a 0x100000 boundary, which is memory that may not be
owned by the kernel.  Depending on the kernel's configuration based
size, this 'extra' memory may contain data passed from the bootloader
to the kernel itself, which if clobbered makes the kernel crash in
various ways.

The fix: Quit rounding the size up, so that we only use memory
assigned to the kernel.

Can be applied to v3.8 and later.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: <stable@vger.kernel.org>
---

This should probably go into 3.10

 arch/mips/cavium-octeon/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 01b1b3f..1e1e18c 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -996,7 +996,7 @@ void __init plat_mem_setup(void)
 	cvmx_bootmem_unlock();
 	/* Add the memory region for the kernel. */
 	kernel_start = (unsigned long) _text;
-	kernel_size = ALIGN(_end - _text, 0x100000);
+	kernel_size = _end - _text;
 
 	/* Adjust for physical offset. */
 	kernel_start &= ~0xffffffff80000000ULL;
-- 
1.7.11.7
