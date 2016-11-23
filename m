Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 14:44:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55253 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992227AbcKWNoDodetG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 14:44:03 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C6EA2ECA90C59;
        Wed, 23 Nov 2016 13:43:52 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 23 Nov 2016 13:43:55 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 00/10] various fixes for kexec crashkernel support
Date:   Wed, 23 Nov 2016 14:43:42 +0100
Message-ID: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

This set of patches attempts to add support to generic MIPS kernels
for kexec and crashkernel loading, as well as fix some existing
potential issues with KASLR

Patches 1-7 fix various bootmem region definition problems, most importantly
ensuring that a firmware-loaded DTB is not corrupt during kernel relocation
or during bootmem initialisation

Patches 8-9 add some error checking and debug messages for kexec

Patch 10 adds support for loading the device tree blob through kexec
on generic platforms using UHI boot protocol.

I will be publishing supporting patches for kexec (especially for generic
platform dtb support) soon.


* Notes for crashkernel core dumps *

The following patches are required:
https://patchwork.linux-mips.org/patch/14588/
https://patchwork.linux-mips.org/patch/14587/
https://patchwork.linux-mips.org/patch/14586/

For non-generic platforms there is no standard method of passing
boot commandline, hence the required boot arguments (mem, elfcorehdr) need
to be set with CONFIG_CMDLINE (except for Cavium Octeon platforms which
have their own method implemented in soc-specific code as well as in
kexec userspace tool).

Marcin Nowakowski (10):
  MIPS: do not request resources for crashkernel if one isn't defined
  MIPS: init: ensure reserved memory regions are not added to bootmem
  MIPS: init: ensure bootmem does not corrupt reserved memory
  MIPS: use early_init_fdt_reserve_self to protect DTB location
  MIPS: platform: allow for DTB to be moved during kernel relocation
  MIPS: relocate: optionally relocate the DTB
  MIPS: fix mem=X@Y commandline processing
  MIPS: kexec: do not reserve invalid crashkernel memory on boot
  MIPS: kexec: add debug info about the new kexec'ed image
  MIPS: generic/kexec: add support for a DTB passed in a separate buffer

 arch/mips/generic/Makefile       |  1 +
 arch/mips/generic/init.c         | 13 ++++++
 arch/mips/generic/kexec.c        | 45 +++++++++++++++++++
 arch/mips/include/asm/bootinfo.h | 13 ++++++
 arch/mips/kernel/machine_kexec.c | 22 ++++++++++
 arch/mips/kernel/prom.c          |  7 +++
 arch/mips/kernel/relocate.c      | 37 +++++++++++++++-
 arch/mips/kernel/setup.c         | 94 ++++++++++++++++++++++++++++++++++++++--
 8 files changed, 228 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/generic/kexec.c

-- 
2.7.4
