Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Sep 2015 06:40:59 +0200 (CEST)
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:57196 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007017AbbI3Ek52Nmg5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Sep 2015 06:40:57 +0200
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9D7EA82545;
        Wed, 30 Sep 2015 17:40:53 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1443588053;
        bh=P9ha7nFU8VwJNf0ivl/XXNI/TRhAzxtqdv2FksorHUk=;
        h=From:To:Cc:Subject:Date;
        b=w5Ji5aRiyZLSiaBEF4Ce51bZ3oM4nPYJDXv6A+kPextJLaOFO24AVUHaGmOOqFwnl
         nY+Zs6cnCPRpnnq+/V0VUn4c8S0Zvc8mVnFfdPgGki59GBEkYxcbs+dtdw2ckaGRcG
         gaFj4Y2D1JRQJxJ1eJsgcCM8fZsg4Bv8ebELl/bY=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,3,0,7277)
        id <B560b67cc0000>; Wed, 30 Sep 2015 17:40:49 +1300
Received: from mattb-dl.ws.atlnz.lc (mattb-dl.ws.atlnz.lc [10.33.14.25])
        by smtp (Postfix) with ESMTP id D116313EE12;
        Wed, 30 Sep 2015 17:34:35 +1300 (NZDT)
Received: by mattb-dl.ws.atlnz.lc (Postfix, from userid 1672)
        id 9F3F2C04F3; Wed, 30 Sep 2015 17:40:44 +1300 (NZDT)
From:   Matt Bennett <matt.bennett@alliedtelesis.co.nz>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, aleksey.makarov@auriga.com,
        david.daney@cavium.com,
        Matt Bennett <matt.bennett@alliedtelesis.co.nz>
Subject: [PATCH] MIPS: Octeon: Fix kernel panic on startup from memory corruption
Date:   Wed, 30 Sep 2015 17:40:42 +1300
Message-Id: <1443588042-21496-1-git-send-email-matt.bennett@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.5.3
Return-Path: <mattb@alliedtelesis.co.nz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.bennett@alliedtelesis.co.nz
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

During development it was found that a number of builds would panic
during the kernel init process, more specifically in 'delayed_fput()'.
The panic showed the kernel trying to access a memory address of
'0xb7fdc00' while traversing the 'delayed_fput_list' structure.
Comparing this memory address to the value of the pointer used on
builds that did not panic confirmed that the pointer on crashing
builds must have been corrupted at some stage earlier in the init
process.

By traversing the list earlier and earlier in the code it was found
that 'plat_mem_setup()' was responsible for corrupting the list.
Specifically the line:

    memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
			__pa_symbol(&__init_end), -1,
			0x100000,
			CVMX_BOOTMEM_FLAG_NO_LOCKING);

Which would eventually call:

    cvmx_bootmem_phy_set_size(new_ent_addr,
		cvmx_bootmem_phy_get_size
		(ent_addr) -
		(desired_min_addr -
			ent_addr));

Where 'new_ent_addr'=0x4800000 (the address of 'delayed_fput_list')
and the second argument (size)=0xb7fdc00 (the address causing the
kernel panic). The job of this part of 'plat_mem_setup()' is to
allocate chunks of memory for the kernel to use. At the start of
each chunk of memory the size of the chunk is written, hence the
value 0xb7fdc00 is written onto memory at 0x4800000, therefore the
kernel panics when it goes back to access 'delayed_fput_list' later
on in the initialisation process.

On builds that were not crashing it was found that the compiler had
placed 'delayed_fput_list' at 0x4800008, meaning it wasn't corrupted
(but something else in memory was overwritten).

As can be seen in the first function call above the code begins to
allocate chunks of memory beginning from the symbol '__init_end'.
The MIPS linker script (vmlinux.lds.S) however defines the .bss
section to begin after '__init_end'. Therefore memory within the
.bss section is allocated to the kernel to use (System.map shows
'delayed_fput_list' and other kernel structures to be in .bss).

To stop the kernel panic (and the .bss section being corrupted)
memory should begin being allocated from the symbol '_end'.

Signed-off-by: Matt Bennett <matt.bennett@alliedtelesis.co.nz>
---
 arch/mips/cavium-octeon/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 89a6284..bd63425 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -933,7 +933,7 @@ void __init plat_mem_setup(void)
 	while ((boot_mem_map.nr_map < BOOT_MEM_MAP_MAX)
 		&& (total < MAX_MEMORY)) {
 		memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
-						__pa_symbol(&__init_end), -1,
+						__pa_symbol(&_end), -1,
 						0x100000,
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
 		if (memory >= 0) {
-- 
2.5.3
