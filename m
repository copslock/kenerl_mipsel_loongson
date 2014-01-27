Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:20:30 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43558 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817294AbaA0UU2PCoFQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:20:28 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 00/58] Add support for Enhanced Virtual Addressing
Date:   Mon, 27 Jan 2014 20:18:47 +0000
Message-ID: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_20_23
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi,

This patchset adds support for the Enhanced Virtual Addressing feature
of the MIPS 3.5 ISA currently present in the *Aptiv processors.
In Release 3, the memory architecture defines the partitioning of memory
space into fixed‐size segments, whose access properties and cacheability
attributes are programmable. The "mapped" and "unmapped" segment‐access
properties can now be modified so as to extend system memory space
(kseg0/kseg1) to include unmapped access to user space (xkseg), a
feature called Enhanced Virtual Addressing (EVA). Instructions that
facilitate system read/write access to xkseg have also been added to the
R3 ISA (lwe, swe, lbue, etc).

This patchset also adds EVA support for the Malta board. The unmapped
address space (kseg0/kseg1) has been extended to 2GB.

If you want to try it, you can use the 'eva-next' branch on
the following git repository

https://github.com/hwoarang/linux.git eva-next

The patchset applies on top of the upstream-sfr/mips-for-linux-next tree.

Leonid Yegoshin (18):
  MIPS: Kconfig: Add Kconfig symbols for EVA support
  MIPS: asm: Add prefetch instruction for EVA
  MIPS: uapi: inst: Add new EVA opcodes
  MIPS: uapi: inst: Add instruction format for SPECIAL3 instructions
  MIPS: traps: Set correct address limit for breakpoints and traps
  MIPS: asm: uaccess: Disable unaligned access macros for EVA
  MIPS: kernel: unaligned: Handle unaligned accesses for EVA
  MIPS: asm: checksum: Split kernel and user copy operations
  MIPS: asm: checksum: Add MIPS specific csum_and_copy_from_user
    function
  MIPS: kernel: signal: Prevent save/restore FPU context in user memory
  MIPS: asm: r4kcache: Build flushing code for instruction cache
  MIPS: asm: r4kcache: Add protected cache operation for EVA
  MIPS: asm: r4kcache: Add EVA cache flushing functions
  MIPS: kernel: {ftrace,kgdb}: Set correct address limit for cache
    flushes
  MIPS: asm: page: Allow __pa_symbol overrides
  MIPS: mm: c-r4k: Build EVA {d,i}cache flushing functions
  MIPS: mm: c-r4k: Flush scache to avoid cache aliases
  MIPS: malta: malta-init: Fix System Controller memory mapping for EVA

Markos Chandras (40):
  MIPS: asm: Add wrappers for EVA/non-EVA instructions
  MIPS: futex: Add EVA support for futex operations
  MIPS: kernel: scall32-o32: Use EVA wrappers to fetch syscall arguments
  MIPS: kernel: traps: Whitespace clean up
  MIPS: lib: strnlen_user: Use macro to build the strnlen_user symbol
  MIPS: lib: strnlen_user: Add EVA support
  MIPS: lib: strlen_user: Use macro to build the strlen_user symbol
  MIPS: lib: strlen_user: Add EVA support
  MIPS: lib: strncpy_user: Use macro to build the strncpy_from_user
    symbol
  MIPS: lib: strncpy_user: Add EVA support
  MIPS: lib: memcpy: Merge EXC and load/store macros
  MIPS: lib: memcpy: Split source and destination prefetch macros
  MIPS: lib: memcpy: Use macro to build the copy_user code
  MIPS: lib: memcpy: Add EVA support
  MIPS: lib: memset: Whitespace fixes
  MIPS: lib: memset: Use macro to build the __bzero symbol
  MIPS: lib: memset: Add EVA support for the __bzero function.
  MIPS: asm: uaccess: Add instruction argument to __{put,get}_user_asm
  MIPS: asm: uaccess: Move duplicated code to common function
  MIPS: asm: uaccess: Use EVA instructions wrappers
  MIPS: asm: uaccess: Rename {get,put}_user_asm macros
  MIPS: asm: uaccess: Add EVA support to copy_{in, to,from}_user
  MIPS: asm: uaccess: Add EVA support for str*_user operations
  MIPS: kernel: unaligned: Add EVA instruction wrappers
  MIPS: checksum: Split the 'copy_user' symbol
  MIPS: lib: csum_partial: Merge EXC and load/store macros
  MIPS: lib: csum_partial: Add macro to build csum_partial symbols
  MIPS: lib: csum_partial: Add EVA support
  MIPS: asm: cpu: Add cpu flag for Enhanced Virtual Addressing
  MIPS: kernel: cpu-probe: Enable EVA option on supported cores
  MIPS: kernel: proc: Add EVA to the list of CPU features
  MIPS: mm: init: Add free_init_pages() callback for EVA
  MIPS: mm: c-r4k: Add support for flushing user pages from cache
  MIPS: malta: Configure Segment Control registers for EVA boot
  MIPS: malta: spaces.h: Add spaces.h file for Malta (EVA)
  MIPS: malta: malta-memory: Add support for the 'ememsize' variable
  MIPS: malta: malta-memory: Use the PHYS_OFFSET to build the memory map
  MIPS: malta: malta-memory: Add free_init_pages_eva() callback
  MIPS: malta: Add support for SMP EVA
  MIPS: Enable MIPS 3.5 features on Malta

 arch/mips/Kconfig                                  |  29 +-
 arch/mips/include/asm/asm.h                        | 130 +++++
 arch/mips/include/asm/bootinfo.h                   |   2 +
 arch/mips/include/asm/checksum.h                   |  44 +-
 arch/mips/include/asm/cpu-features.h               |   4 +-
 arch/mips/include/asm/cpu.h                        |   1 +
 arch/mips/include/asm/futex.h                      |   9 +-
 arch/mips/include/asm/fw/fw.h                      |   2 +-
 .../include/asm/mach-malta/kernel-entry-init.h     | 115 ++++-
 arch/mips/include/asm/mach-malta/spaces.h          |  46 ++
 arch/mips/include/asm/page.h                       |   2 +
 arch/mips/include/asm/r4kcache.h                   | 173 ++++++-
 arch/mips/include/asm/uaccess.h                    | 559 ++++++++++++++++-----
 arch/mips/include/uapi/asm/inst.h                  |  25 +-
 arch/mips/kernel/cpu-probe.c                       |   3 +
 arch/mips/kernel/ftrace.c                          |   4 +
 arch/mips/kernel/head.S                            |   2 +-
 arch/mips/kernel/kgdb.c                            |  17 +-
 arch/mips/kernel/mips_ksyms.c                      |  24 +-
 arch/mips/kernel/proc.c                            |   1 +
 arch/mips/kernel/scall32-o32.S                     |   9 +-
 arch/mips/kernel/signal.c                          |  26 +
 arch/mips/kernel/traps.c                           |  29 +-
 arch/mips/kernel/unaligned.c                       | 135 ++++-
 arch/mips/lib/csum_partial.S                       | 282 +++++++----
 arch/mips/lib/memcpy.S                             | 416 ++++++++++-----
 arch/mips/lib/memset.S                             | 146 ++++--
 arch/mips/lib/strlen_user.S                        |  36 +-
 arch/mips/lib/strncpy_user.S                       |  40 +-
 arch/mips/lib/strnlen_user.S                       |  36 +-
 arch/mips/mm/c-r4k.c                               |  64 ++-
 arch/mips/mm/init.c                                |  12 +-
 arch/mips/mti-malta/malta-init.c                   |  13 +
 arch/mips/mti-malta/malta-memory.c                 |  58 ++-
 arch/mips/mti-malta/malta-setup.c                  |   4 +
 35 files changed, 1974 insertions(+), 524 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-malta/spaces.h

-- 
1.8.5.3
