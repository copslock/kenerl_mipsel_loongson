Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 01:49:57 +0200 (CEST)
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37910 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012228AbbD2XtzMFSXx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 01:49:55 +0200
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3F6C3806BF;
        Thu, 30 Apr 2015 11:49:52 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1430351392;
        bh=FAC3gGX4fXNt2wmNEBeHkUS71PSrr7nZLxJZf+adpJs=;
        h=From:To:Cc:Subject:Date;
        b=FeupHgyvSBz0Hv+SiQLvBPsyV/FbWcmzjcON7LaELdpbGqfbJnI0trmAV5tDm7EWM
         h1xTvgKc6xLtpLyWJAK354AcbuO7kRZIP62rZgV/LodZIFzer5eeLTem3YIg4yCTxk
         ++kggTxR4xlqeb1ukgE/a72QKtMXUMeRBgVfYsA4=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,3,0,7277)
        id <B55416e1c0000>; Thu, 30 Apr 2015 11:49:48 +1200
Received: from mattb-dl.ws.atlnz.lc (mattb-dl.ws.atlnz.lc [10.33.14.25])
        by smtp (Postfix) with ESMTP id 90ADC13EC0D;
        Thu, 30 Apr 2015 11:48:11 +1200 (NZST)
Received: by mattb-dl.ws.atlnz.lc (Postfix, from userid 1672)
        id 7DCF9C05A9; Thu, 30 Apr 2015 11:49:48 +1200 (NZST)
From:   Matt Bennett <matt.bennett@alliedtelesis.co.nz>
To:     david.daney@cavium.com
Cc:     Matt Bennett <matt.bennett@alliedtelesis.co.nz>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: OCTEON: Stop .bss memory being allocated to the kernel
Date:   Thu, 30 Apr 2015 11:48:31 +1200
Message-Id: <1430351311-21056-1-git-send-email-matt.bennett@alliedtelesis.co.nz>
X-Mailer: git-send-email 1.9.1
Return-Path: <mattb@alliedtelesis.co.nz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47166
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

During development work on a 3.16 based kernel it was found that a
number of builds would panic during the kernel init process, more
specifically in 'delayed_fput()'. The panic showed the kernel trying
to access a memory address of '0xb7fdc00' while traversing the
'delayed_fput_list' structure. Comparing this memory address to the
value of the pointer used on builds that did not panic confirmed
that the pointer on crashing builds must have been corrupted at some
stage earlier in the init process.

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
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/cavium-octeon/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 7e4367b..f632f14 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1008,7 +1008,7 @@ void __init plat_mem_setup(void)
 	while ((boot_mem_map.nr_map < BOOT_MEM_MAP_MAX)
 		&& (total < MAX_MEMORY)) {
 		memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
-						__pa_symbol(&__init_end), -1,
+						__pa_symbol(&_end), -1,
 						0x100000,
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
 		if (memory >= 0) {
-- 
1.9.1
