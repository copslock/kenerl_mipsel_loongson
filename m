Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 11:08:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48070 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007603AbbLCKI2VFjFZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 11:08:28 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id A23E4AAD964C9
        for <linux-mips@linux-mips.org>; Thu,  3 Dec 2015 10:08:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 3 Dec 2015 10:08:21 +0000
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 3 Dec 2015 10:08:21 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 0/9] MIPS Relocatable kernel & KASLR
Date:   Thu, 3 Dec 2015 10:08:08 +0000
Message-ID: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

This series adds the ability for the MIPS kernel to relocate itself at
runtime, optionally to an address determined at random each boot. This
series is based on v4.3 and has been tested on the Malta platform.

Here is a description of how relocation is achieved:
* Kernel is compiled & statically linked as normal (no position
  independent code).
* The linker flag --emit-relocs is added to the linker command line,
  causing ld to include relocation sections in the output elf
* A tool derived from the x86 relocs tool is used to parse the
  relocation sections and create a binary table of relocations. Each
  entry in the table is 32bits, comprised of a 24bit offset (in words)
  from _text and an 8bit relocation type.
* The table is inserted into the vmlinux elf, into some space reserved
  for it in the linker script. Inserting the table into vmlinux means
  all boot targets will automatically include the relocation code and
  information.
* At boot, the kernel memcpy()s itself elsewhere in memory, then goes
  through the table performing each relocation on the new image.
* If all goes well, control is passed to the entry point of the new
  kernel.

Restrictions:
* The new kernel is not allowed to overlap the old kernel, such that
  the original kernel can still be booted if relocation fails.
* Relocation is supported only by multiples of 64k bytes. This
  eliminates the need to handle R_MIPS_LO16 relocations as the bottom
  16bits will remain the same at the relocated address.
* In 64 bit kernels, relocation is supported only within the same 4Gb
  memory segment as the kernel link address (CONFIG_PHYSICAL_START).
  This eliminates the need to handle R_MIPS_HIGHEST and R_MIPS_HIGHER
  relocations as the top 32bits will remain the same at the relocated
  address.
* Relocation is currently supported on R2 of the MIPS architecture,
  32bit and 64bit.

Matt Redfearn (9):
  MIPS: tools: Add relocs tool
  MIPS: tools: Build relocs tool
  MIPS: Reserve space for relocation table
  MIPS: Generate relocation table when CONFIG_RELOCATABLE
  MIPS: Kernel: Add relocate.c
  MIPS: Call relocate_kernel if CONFIG_RELOCATABLE=y
  MIPS: bootmem: When relocatable, free memory below kernel
  MIPS: Add CONFIG_RELOCATABLE Kconfig option
  MIPS: Kernel: Implement kASLR using CONFIG_RELOCATABLE

 arch/mips/Kconfig                  |  53 +++
 arch/mips/Makefile                 |  19 ++
 arch/mips/boot/tools/Makefile      |   8 +
 arch/mips/boot/tools/relocs.c      | 675 +++++++++++++++++++++++++++++++++++++
 arch/mips/boot/tools/relocs.h      |  34 ++
 arch/mips/boot/tools/relocs_32.c   |  17 +
 arch/mips/boot/tools/relocs_64.c   |  27 ++
 arch/mips/boot/tools/relocs_main.c |  84 +++++
 arch/mips/kernel/Makefile          |   2 +
 arch/mips/kernel/head.S            |  20 ++
 arch/mips/kernel/relocate.c        | 296 ++++++++++++++++
 arch/mips/kernel/setup.c           |  13 +
 arch/mips/kernel/vmlinux.lds.S     |  20 ++
 13 files changed, 1268 insertions(+)
 create mode 100644 arch/mips/boot/tools/Makefile
 create mode 100644 arch/mips/boot/tools/relocs.c
 create mode 100644 arch/mips/boot/tools/relocs.h
 create mode 100644 arch/mips/boot/tools/relocs_32.c
 create mode 100644 arch/mips/boot/tools/relocs_64.c
 create mode 100644 arch/mips/boot/tools/relocs_main.c
 create mode 100644 arch/mips/kernel/relocate.c

-- 
2.1.4
