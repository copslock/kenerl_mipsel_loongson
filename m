Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 11:52:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49257 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009381AbbJEJw5PQsX5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 11:52:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 84B3268A902C5
        for <linux-mips@linux-mips.org>; Mon,  5 Oct 2015 10:52:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 5 Oct 2015 10:52:50 +0100
Received: from mredfearn-linux.le.imgtec.org (192.168.154.117) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 5 Oct 2015 10:52:49 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [RFC PATCH 0/7] Relocatable Kernel
Date:   Mon, 5 Oct 2015 10:52:24 +0100
Message-ID: <1444038751-25105-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.117]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49424
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

Hi,
This patch series is a prerequisite of adding KASLR support for MIPS.
So far this supports 32/64 bit big/little endian CPUs and has been
tested in Qemu for Malta. It has not been tested on real hardware yet.
It is presented here as an early RFC for issues that people can forsee with
the many platforms, memory layouts etc that it must support.

Here is a description of how relocation is achieved:
* Kernel is compiled & statically linked as normal (no position independent code).
* The linker flag --emit-relocs is added to the linker command line, causing ld 
  to include additional ".rel" sections in the output elf
* A tool is used to parse the ".rel" sections and create a binary table of
  relocations. Each entry in the table is 32bits, comprised of a 24bit offset
  and 8bit relocation type.
* The table is appended to the kernel binary image, with some space in the
  memory map reserved for it in the linker script
* At boot, the kernel memcpy()s itself elsewhere in memory, then goes through
  the table performing each relocation on the new image
* If all goes well, control is passed to the entry point of the new kernel.

The net result of the relocation parsing is that the kernel as relocated is
binary identical to if it is statically linked to that address via the
CONFIG_PHYSICAL_START option.

Restrictions:
* Relocation is supported only by multiples of 64k bytes. This eliminates
  the need to handle R_MIPS_LO16 relocations as the bottom 16bits will
  remain the same at the relocated address.
* In 64 bit kernels, relocation is supported only within the same 4Gb memory
  segment. This eliminates the need to handle R_MIPS_HIGHEST and R_MIPS_HIGHER
  relocations as the top 32bits will remain the same at the relocated address.

What is not yet implemented:
* Cache flushing, likely to be implemented via the SYNCI instruction, but
  without this the relocated kernel will likely fail on real hardware
* Support for SMP (handling percpu sections)
* Currently the relocation target address is hard coded. In future this may
  be determined by command line argument or by choosing an address at random
  (within platform specific constraints) to implement KASLR.
* Support for CONFIG_RAW_APPENDED_DTB. This option appends a binary DTB 
  to the kernel image, which will currently not appear at the expected
  address. Also the size of the appended relocation table must be checked to
  ensure that it does not overflow the reserved space
* Currently the kernel reserves all memory up to the _end symbol as boot memory.
  While this is fine when the kernel is linked to appear near the bottom of RAM,
  once it can relocate elsewhere this will have to change so as not to waste
  a significant amount of memory. However, the way in which memory is reserved
  is very platform specific and I forsee there will be issues here :-)

Thanks,
Matt

Matt Redfearn (7):
  MIPS: tools: Add relocs tool
  MIPS: tools: Build relocs tool
  MIPS: Reserve space for relocation table
  MIPS: Generate relocation table when CONFIG_RELOCATABLE
  MIPS: Kernel: Add relocate.c
  MIPS: Call relocate_kernel if CONFIG_RELOCATABLE=y
  MIPS: Add CONFIG_RELOCATABLE Kconfig option

 arch/mips/Kconfig                  |   8 +
 arch/mips/Makefile                 |   7 +
 arch/mips/boot/Makefile            |  19 ++
 arch/mips/boot/tools/Makefile      |   6 +
 arch/mips/boot/tools/relocs.c      | 552 +++++++++++++++++++++++++++++++++++++
 arch/mips/boot/tools/relocs.h      |  32 +++
 arch/mips/boot/tools/relocs_32.c   |  17 ++
 arch/mips/boot/tools/relocs_64.c   |  17 ++
 arch/mips/boot/tools/relocs_main.c |  74 +++++
 arch/mips/kernel/Makefile          |   2 +
 arch/mips/kernel/head.S            |  18 ++
 arch/mips/kernel/relocate.c        | 225 +++++++++++++++
 arch/mips/kernel/vmlinux.lds.S     |   9 +
 13 files changed, 986 insertions(+)
 create mode 100644 arch/mips/boot/tools/Makefile
 create mode 100644 arch/mips/boot/tools/relocs.c
 create mode 100644 arch/mips/boot/tools/relocs.h
 create mode 100644 arch/mips/boot/tools/relocs_32.c
 create mode 100644 arch/mips/boot/tools/relocs_64.c
 create mode 100644 arch/mips/boot/tools/relocs_main.c
 create mode 100644 arch/mips/kernel/relocate.c

-- 
2.1.4
