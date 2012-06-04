Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2012 23:10:31 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:38979 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903665Ab2FDVKF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jun 2012 23:10:05 +0200
Received: by dadm1 with SMTP id m1so6925575dad.36
        for <multiple recipients>; Mon, 04 Jun 2012 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+97HaSBKoV7yMXZjC4kjeltIoRADADEYTJ7Ww31XfLc=;
        b=c7lSzhcIR0ybDSD8jvH+GVAtoKKDDf7CGSm3BcGc64NjwGDSLHTkbl/GqZ/Y1tO0Z9
         HLkUyAaBKg7fBBvZa6aw/RezOuPXz4X9YfjbcksOK1QSzjzEk4T9hvo21co8SdP2Cyyy
         a6tN9fkwuAqch+tmWzNOWKcE0nQDkuDDEtm4L9slYYMMqdZj5Rz6l+Vy3BhKdwV54g0j
         EBwC4h/BBVpDJjKcsVo0tXoNKeZMiFddWoftkslwcGwrqSdEfPMq9hjdcENGYsYW66wb
         31OZsVVxHKk5wOLoRk/+CjrGIN2BtR2d8EQzaZ0c9Ff4ojwWN0gqymJRXJ0rBU0ky96q
         x7gg==
Received: by 10.68.193.233 with SMTP id hr9mr42694291pbc.99.1338844198280;
        Mon, 04 Jun 2012 14:09:58 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id jv6sm14462854pbc.40.2012.06.04.14.09.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 14:09:57 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q54L9tN5019833;
        Mon, 4 Jun 2012 14:09:55 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q54L9sJ2019831;
        Mon, 4 Jun 2012 14:09:54 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: OCTEON: Remove some unused files.
Date:   Mon,  4 Jun 2012 14:09:53 -0700
Message-Id: <1338844193-19800-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33510
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

These FPA related files are not used anywhere in the kernel.  Remove
them.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/cvmx-fpa.c       |  183 ---------------
 .../mips/cavium-octeon/executive/cvmx-helper-fpa.c |  243 --------------------
 arch/mips/include/asm/octeon/cvmx-helper-fpa.h     |   64 -----
 arch/mips/include/asm/octeon/cvmx-helper.h         |    2 -
 4 files changed, 0 insertions(+), 492 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/executive/cvmx-fpa.c
 delete mode 100644 arch/mips/cavium-octeon/executive/cvmx-helper-fpa.c
 delete mode 100644 arch/mips/include/asm/octeon/cvmx-helper-fpa.h

diff --git a/arch/mips/cavium-octeon/executive/cvmx-fpa.c b/arch/mips/cavium-octeon/executive/cvmx-fpa.c
deleted file mode 100644
index ad44b8b..0000000
--- a/arch/mips/cavium-octeon/executive/cvmx-fpa.c
+++ /dev/null
@@ -1,183 +0,0 @@
-/***********************license start***************
- * Author: Cavium Networks
- *
- * Contact: support@caviumnetworks.com
- * This file is part of the OCTEON SDK
- *
- * Copyright (c) 2003-2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- *
- * This file is distributed in the hope that it will be useful, but
- * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
- * NONINFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- * or visit http://www.gnu.org/licenses/.
- *
- * This file may also be available under a different license from Cavium.
- * Contact Cavium Networks for more information
- ***********************license end**************************************/
-
-/**
- * @file
- *
- * Support library for the hardware Free Pool Allocator.
- *
- *
- */
-
-#include "cvmx-config.h"
-#include "cvmx.h"
-#include "cvmx-fpa.h"
-#include "cvmx-ipd.h"
-
-/**
- * Current state of all the pools. Use access functions
- * instead of using it directly.
- */
-CVMX_SHARED cvmx_fpa_pool_info_t cvmx_fpa_pool_info[CVMX_FPA_NUM_POOLS];
-
-/**
- * Setup a FPA pool to control a new block of memory. The
- * buffer pointer must be a physical address.
- *
- * @pool:       Pool to initialize
- *                   0 <= pool < 8
- * @name:       Constant character string to name this pool.
- *                   String is not copied.
- * @buffer:     Pointer to the block of memory to use. This must be
- *                   accessible by all processors and external hardware.
- * @block_size: Size for each block controlled by the FPA
- * @num_blocks: Number of blocks
- *
- * Returns 0 on Success,
- *         -1 on failure
- */
-int cvmx_fpa_setup_pool(uint64_t pool, const char *name, void *buffer,
-			uint64_t block_size, uint64_t num_blocks)
-{
-	char *ptr;
-	if (!buffer) {
-		cvmx_dprintf
-		    ("ERROR: cvmx_fpa_setup_pool: NULL buffer pointer!\n");
-		return -1;
-	}
-	if (pool >= CVMX_FPA_NUM_POOLS) {
-		cvmx_dprintf("ERROR: cvmx_fpa_setup_pool: Illegal pool!\n");
-		return -1;
-	}
-
-	if (block_size < CVMX_FPA_MIN_BLOCK_SIZE) {
-		cvmx_dprintf
-		    ("ERROR: cvmx_fpa_setup_pool: Block size too small.\n");
-		return -1;
-	}
-
-	if (((unsigned long)buffer & (CVMX_FPA_ALIGNMENT - 1)) != 0) {
-		cvmx_dprintf
-		    ("ERROR: cvmx_fpa_setup_pool: Buffer not aligned properly.\n");
-		return -1;
-	}
-
-	cvmx_fpa_pool_info[pool].name = name;
-	cvmx_fpa_pool_info[pool].size = block_size;
-	cvmx_fpa_pool_info[pool].starting_element_count = num_blocks;
-	cvmx_fpa_pool_info[pool].base = buffer;
-
-	ptr = (char *)buffer;
-	while (num_blocks--) {
-		cvmx_fpa_free(ptr, pool, 0);
-		ptr += block_size;
-	}
-	return 0;
-}
-
-/**
- * Shutdown a Memory pool and validate that it had all of
- * the buffers originally placed in it.
- *
- * @pool:   Pool to shutdown
- * Returns Zero on success
- *         - Positive is count of missing buffers
- *         - Negative is too many buffers or corrupted pointers
- */
-uint64_t cvmx_fpa_shutdown_pool(uint64_t pool)
-{
-	uint64_t errors = 0;
-	uint64_t count = 0;
-	uint64_t base = cvmx_ptr_to_phys(cvmx_fpa_pool_info[pool].base);
-	uint64_t finish =
-	    base +
-	    cvmx_fpa_pool_info[pool].size *
-	    cvmx_fpa_pool_info[pool].starting_element_count;
-	void *ptr;
-	uint64_t address;
-
-	count = 0;
-	do {
-		ptr = cvmx_fpa_alloc(pool);
-		if (ptr)
-			address = cvmx_ptr_to_phys(ptr);
-		else
-			address = 0;
-		if (address) {
-			if ((address >= base) && (address < finish) &&
-			    (((address -
-			       base) % cvmx_fpa_pool_info[pool].size) == 0)) {
-				count++;
-			} else {
-				cvmx_dprintf
-				    ("ERROR: cvmx_fpa_shutdown_pool: Illegal address 0x%llx in pool %s(%d)\n",
-				     (unsigned long long)address,
-				     cvmx_fpa_pool_info[pool].name, (int)pool);
-				errors++;
-			}
-		}
-	} while (address);
-
-#ifdef CVMX_ENABLE_PKO_FUNCTIONS
-	if (pool == 0)
-		cvmx_ipd_free_ptr();
-#endif
-
-	if (errors) {
-		cvmx_dprintf
-		    ("ERROR: cvmx_fpa_shutdown_pool: Pool %s(%d) started at 0x%llx, ended at 0x%llx, with a step of 0x%llx\n",
-		     cvmx_fpa_pool_info[pool].name, (int)pool,
-		     (unsigned long long)base, (unsigned long long)finish,
-		     (unsigned long long)cvmx_fpa_pool_info[pool].size);
-		return -errors;
-	} else
-		return 0;
-}
-
-uint64_t cvmx_fpa_get_block_size(uint64_t pool)
-{
-	switch (pool) {
-	case 0:
-		return CVMX_FPA_POOL_0_SIZE;
-	case 1:
-		return CVMX_FPA_POOL_1_SIZE;
-	case 2:
-		return CVMX_FPA_POOL_2_SIZE;
-	case 3:
-		return CVMX_FPA_POOL_3_SIZE;
-	case 4:
-		return CVMX_FPA_POOL_4_SIZE;
-	case 5:
-		return CVMX_FPA_POOL_5_SIZE;
-	case 6:
-		return CVMX_FPA_POOL_6_SIZE;
-	case 7:
-		return CVMX_FPA_POOL_7_SIZE;
-	default:
-		return 0;
-	}
-}
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-fpa.c b/arch/mips/cavium-octeon/executive/cvmx-helper-fpa.c
deleted file mode 100644
index c239e5f..0000000
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-fpa.c
+++ /dev/null
@@ -1,243 +0,0 @@
-/***********************license start***************
- * Author: Cavium Networks
- *
- * Contact: support@caviumnetworks.com
- * This file is part of the OCTEON SDK
- *
- * Copyright (c) 2003-2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- *
- * This file is distributed in the hope that it will be useful, but
- * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
- * NONINFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- * or visit http://www.gnu.org/licenses/.
- *
- * This file may also be available under a different license from Cavium.
- * Contact Cavium Networks for more information
- ***********************license end**************************************/
-
-/**
- * @file
- *
- * Helper functions for FPA setup.
- *
- */
-#include "executive-config.h"
-#include "cvmx-config.h"
-#include "cvmx.h"
-#include "cvmx-bootmem.h"
-#include "cvmx-fpa.h"
-#include "cvmx-helper-fpa.h"
-
-/**
- * Allocate memory for and initialize a single FPA pool.
- *
- * @pool:    Pool to initialize
- * @buffer_size:  Size of buffers to allocate in bytes
- * @buffers: Number of buffers to put in the pool. Zero is allowed
- * @name:    String name of the pool for debugging purposes
- * Returns Zero on success, non-zero on failure
- */
-static int __cvmx_helper_initialize_fpa_pool(int pool, uint64_t buffer_size,
-					     uint64_t buffers, const char *name)
-{
-	uint64_t current_num;
-	void *memory;
-	uint64_t align = CVMX_CACHE_LINE_SIZE;
-
-	/*
-	 * Align the allocation so that power of 2 size buffers are
-	 * naturally aligned.
-	 */
-	while (align < buffer_size)
-		align = align << 1;
-
-	if (buffers == 0)
-		return 0;
-
-	current_num = cvmx_read_csr(CVMX_FPA_QUEX_AVAILABLE(pool));
-	if (current_num) {
-		cvmx_dprintf("Fpa pool %d(%s) already has %llu buffers. "
-			     "Skipping setup.\n",
-		     pool, name, (unsigned long long)current_num);
-		return 0;
-	}
-
-	memory = cvmx_bootmem_alloc(buffer_size * buffers, align);
-	if (memory == NULL) {
-		cvmx_dprintf("Out of memory initializing fpa pool %d(%s).\n",
-			     pool, name);
-		return -1;
-	}
-	cvmx_fpa_setup_pool(pool, name, memory, buffer_size, buffers);
-	return 0;
-}
-
-/**
- * Allocate memory and initialize the FPA pools using memory
- * from cvmx-bootmem. Specifying zero for the number of
- * buffers will cause that FPA pool to not be setup. This is
- * useful if you aren't using some of the hardware and want
- * to save memory. Use cvmx_helper_initialize_fpa instead of
- * this function directly.
- *
- * @pip_pool: Should always be CVMX_FPA_PACKET_POOL
- * @pip_size: Should always be CVMX_FPA_PACKET_POOL_SIZE
- * @pip_buffers:
- *                 Number of packet buffers.
- * @wqe_pool: Should always be CVMX_FPA_WQE_POOL
- * @wqe_size: Should always be CVMX_FPA_WQE_POOL_SIZE
- * @wqe_entries:
- *                 Number of work queue entries
- * @pko_pool: Should always be CVMX_FPA_OUTPUT_BUFFER_POOL
- * @pko_size: Should always be CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE
- * @pko_buffers:
- *                 PKO Command buffers. You should at minimum have two per
- *                 each PKO queue.
- * @tim_pool: Should always be CVMX_FPA_TIMER_POOL
- * @tim_size: Should always be CVMX_FPA_TIMER_POOL_SIZE
- * @tim_buffers:
- *                 TIM ring buffer command queues. At least two per timer bucket
- *                 is recommened.
- * @dfa_pool: Should always be CVMX_FPA_DFA_POOL
- * @dfa_size: Should always be CVMX_FPA_DFA_POOL_SIZE
- * @dfa_buffers:
- *                 DFA command buffer. A relatively small (32 for example)
- *                 number should work.
- * Returns Zero on success, non-zero if out of memory
- */
-static int __cvmx_helper_initialize_fpa(int pip_pool, int pip_size,
-					int pip_buffers, int wqe_pool,
-					int wqe_size, int wqe_entries,
-					int pko_pool, int pko_size,
-					int pko_buffers, int tim_pool,
-					int tim_size, int tim_buffers,
-					int dfa_pool, int dfa_size,
-					int dfa_buffers)
-{
-	int status;
-
-	cvmx_fpa_enable();
-
-	if ((pip_buffers > 0) && (pip_buffers <= 64))
-		cvmx_dprintf
-		    ("Warning: %d packet buffers may not be enough for hardware"
-		     " prefetch. 65 or more is recommended.\n", pip_buffers);
-
-	if (pip_pool >= 0) {
-		status =
-		    __cvmx_helper_initialize_fpa_pool(pip_pool, pip_size,
-						      pip_buffers,
-						      "Packet Buffers");
-		if (status)
-			return status;
-	}
-
-	if (wqe_pool >= 0) {
-		status =
-		    __cvmx_helper_initialize_fpa_pool(wqe_pool, wqe_size,
-						      wqe_entries,
-						      "Work Queue Entries");
-		if (status)
-			return status;
-	}
-
-	if (pko_pool >= 0) {
-		status =
-		    __cvmx_helper_initialize_fpa_pool(pko_pool, pko_size,
-						      pko_buffers,
-						      "PKO Command Buffers");
-		if (status)
-			return status;
-	}
-
-	if (tim_pool >= 0) {
-		status =
-		    __cvmx_helper_initialize_fpa_pool(tim_pool, tim_size,
-						      tim_buffers,
-						      "TIM Command Buffers");
-		if (status)
-			return status;
-	}
-
-	if (dfa_pool >= 0) {
-		status =
-		    __cvmx_helper_initialize_fpa_pool(dfa_pool, dfa_size,
-						      dfa_buffers,
-						      "DFA Command Buffers");
-		if (status)
-			return status;
-	}
-
-	return 0;
-}
-
-/**
- * Allocate memory and initialize the FPA pools using memory
- * from cvmx-bootmem. Sizes of each element in the pools is
- * controlled by the cvmx-config.h header file. Specifying
- * zero for any parameter will cause that FPA pool to not be
- * setup. This is useful if you aren't using some of the
- * hardware and want to save memory.
- *
- * @packet_buffers:
- *               Number of packet buffers to allocate
- * @work_queue_entries:
- *               Number of work queue entries
- * @pko_buffers:
- *               PKO Command buffers. You should at minimum have two per
- *               each PKO queue.
- * @tim_buffers:
- *               TIM ring buffer command queues. At least two per timer bucket
- *               is recommened.
- * @dfa_buffers:
- *               DFA command buffer. A relatively small (32 for example)
- *               number should work.
- * Returns Zero on success, non-zero if out of memory
- */
-int cvmx_helper_initialize_fpa(int packet_buffers, int work_queue_entries,
-			       int pko_buffers, int tim_buffers,
-			       int dfa_buffers)
-{
-#ifndef CVMX_FPA_PACKET_POOL
-#define CVMX_FPA_PACKET_POOL -1
-#define CVMX_FPA_PACKET_POOL_SIZE 0
-#endif
-#ifndef CVMX_FPA_WQE_POOL
-#define CVMX_FPA_WQE_POOL -1
-#define CVMX_FPA_WQE_POOL_SIZE 0
-#endif
-#ifndef CVMX_FPA_OUTPUT_BUFFER_POOL
-#define CVMX_FPA_OUTPUT_BUFFER_POOL -1
-#define CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE 0
-#endif
-#ifndef CVMX_FPA_TIMER_POOL
-#define CVMX_FPA_TIMER_POOL -1
-#define CVMX_FPA_TIMER_POOL_SIZE 0
-#endif
-#ifndef CVMX_FPA_DFA_POOL
-#define CVMX_FPA_DFA_POOL -1
-#define CVMX_FPA_DFA_POOL_SIZE 0
-#endif
-	return __cvmx_helper_initialize_fpa(CVMX_FPA_PACKET_POOL,
-					    CVMX_FPA_PACKET_POOL_SIZE,
-					    packet_buffers, CVMX_FPA_WQE_POOL,
-					    CVMX_FPA_WQE_POOL_SIZE,
-					    work_queue_entries,
-					    CVMX_FPA_OUTPUT_BUFFER_POOL,
-					    CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE,
-					    pko_buffers, CVMX_FPA_TIMER_POOL,
-					    CVMX_FPA_TIMER_POOL_SIZE,
-					    tim_buffers, CVMX_FPA_DFA_POOL,
-					    CVMX_FPA_DFA_POOL_SIZE,
-					    dfa_buffers);
-}
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-fpa.h b/arch/mips/include/asm/octeon/cvmx-helper-fpa.h
deleted file mode 100644
index 5ff8c93..0000000
--- a/arch/mips/include/asm/octeon/cvmx-helper-fpa.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/***********************license start***************
- * Author: Cavium Networks
- *
- * Contact: support@caviumnetworks.com
- * This file is part of the OCTEON SDK
- *
- * Copyright (c) 2003-2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- *
- * This file is distributed in the hope that it will be useful, but
- * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
- * NONINFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- * or visit http://www.gnu.org/licenses/.
- *
- * This file may also be available under a different license from Cavium.
- * Contact Cavium Networks for more information
- ***********************license end**************************************/
-
-/**
- * @file
- *
- * Helper functions for FPA setup.
- *
- */
-#ifndef __CVMX_HELPER_H_FPA__
-#define __CVMX_HELPER_H_FPA__
-
-/**
- * Allocate memory and initialize the FPA pools using memory
- * from cvmx-bootmem. Sizes of each element in the pools is
- * controlled by the cvmx-config.h header file. Specifying
- * zero for any parameter will cause that FPA pool to not be
- * setup. This is useful if you aren't using some of the
- * hardware and want to save memory.
- *
- * @packet_buffers:
- *               Number of packet buffers to allocate
- * @work_queue_entries:
- *               Number of work queue entries
- * @pko_buffers:
- *               PKO Command buffers. You should at minimum have two per
- *               each PKO queue.
- * @tim_buffers:
- *               TIM ring buffer command queues. At least two per timer bucket
- *               is recommened.
- * @dfa_buffers:
- *               DFA command buffer. A relatively small (32 for example)
- *               number should work.
- * Returns Zero on success, non-zero if out of memory
- */
-extern int cvmx_helper_initialize_fpa(int packet_buffers,
-				      int work_queue_entries, int pko_buffers,
-				      int tim_buffers, int dfa_buffers);
-
-#endif /* __CVMX_HELPER_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-helper.h b/arch/mips/include/asm/octeon/cvmx-helper.h
index 3169cd7..0ac6b9f 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper.h
@@ -61,8 +61,6 @@ typedef union {
 	} s;
 } cvmx_helper_link_info_t;
 
-#include "cvmx-helper-fpa.h"
-
 #include <asm/octeon/cvmx-helper-errata.h>
 #include "cvmx-helper-loop.h"
 #include "cvmx-helper-npi.h"
-- 
1.7.2.3
