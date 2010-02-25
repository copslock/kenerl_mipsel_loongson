Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 05:29:50 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:54528 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490967Ab0BYE3r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 05:29:47 +0100
Received: by gwj21 with SMTP id 21so1999515gwj.36
        for <multiple recipients>; Wed, 24 Feb 2010 20:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=FEmir0ebNHbSfDfBi/GyysU89U/gs/q3dlfP4px0TTI=;
        b=Md6ntPmRLmi7ABgdzCfQIphTKUA2+TwFH+QdXj9UHUeKpAcGMgz6Mt6WheI3UD/gXS
         IOKGSObaZk7ru10k9oymJTLrnUSozAAfd7LoUdcvTfbkArkNGhiUowAnYgzS+jU7Zei2
         p86v0KhiuSMGssq0g/5UfRq5/QjDdZBnIbLeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MNgf3m4PqMzqpWmJ8HEmv8DMg+kRxgtggNJBc41g7JF+60uufuuz0n8FfPbkjzO9KL
         cO0xMiMGQYvqJjhuoKUSVzFAPxBGMH3qPKv0Cn0UH3WoAaL18xXzbZYkRDaFk9MsTkse
         pGlotRl85MW10UapSAL3sgrcWAQFg+aKmOu0w=
Received: by 10.90.24.13 with SMTP id 13mr525619agx.84.1267072180903;
        Wed, 24 Feb 2010 20:29:40 -0800 (PST)
Received: from mattst88@gmail.com ([204.84.232.251])
        by mx.google.com with ESMTPS id 7sm2294966ywc.4.2010.02.24.20.29.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 20:29:40 -0800 (PST)
Received: by mattst88@gmail.com (sSMTP sendmail emulation); Wed, 24 Feb 2010 23:30:30 -0500
From:   Matt Turner <mattst88@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Matt Turner <mattst88@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Use ALIGN(x, bytes) instead of __ALIGN_MASK(x, bytes - 1)
Date:   Wed, 24 Feb 2010 23:30:14 -0500
Message-Id: <1267072214-23269-1-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.6.4.4
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

ALIGN(x, bytes) expands to __ALIGN_MASK(x, bytes - 1), so use the one
that is most clear.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index 25666da..fdf5f19 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -253,7 +253,7 @@ int64_t cvmx_bootmem_phy_alloc(uint64_t req_size, uint64_t address_min,
 	 * impossible requests up front. (NOP for address_min == 0)
 	 */
 	if (alignment)
-		address_min = __ALIGN_MASK(address_min, (alignment - 1));
+		address_min = ALIGN(address_min, alignment);
 
 	/*
 	 * Reject inconsistent args.  We have adjusted these, so this
@@ -291,7 +291,7 @@ int64_t cvmx_bootmem_phy_alloc(uint64_t req_size, uint64_t address_min,
 		 * satisfy request.
 		 */
 		usable_base =
-		    __ALIGN_MASK(max(address_min, ent_addr), alignment - 1);
+		    ALIGN(max(address_min, ent_addr), alignment);
 		usable_max = min(address_max, ent_addr + ent_size);
 		/*
 		 * We should be able to allocate block at address
@@ -671,7 +671,7 @@ int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size, uint64_t min_addr,
 	 * coallesced when they are freed.  The alloc routine does the
 	 * same rounding up on all allocations.
 	 */
-	size = __ALIGN_MASK(size, (CVMX_BOOTMEM_ALIGNMENT_SIZE - 1));
+	size = ALIGN(size, CVMX_BOOTMEM_ALIGNMENT_SIZE);
 
 	addr_allocated = cvmx_bootmem_phy_alloc(size, min_addr, max_addr,
 						alignment,
-- 
1.6.4.4
