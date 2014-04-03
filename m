Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 00:17:37 +0200 (CEST)
Received: from mail-oa0-f52.google.com ([209.85.219.52]:40462 "EHLO
        mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822081AbaDCWRc1RUEJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 00:17:32 +0200
Received: by mail-oa0-f52.google.com with SMTP id l6so2661312oag.25
        for <multiple recipients>; Thu, 03 Apr 2014 15:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/7IhpOVUoA2re7MUF8GgQ2WlyT1MxMF9niYIWrB0Mts=;
        b=yut//N9U5m0cEh4jAbCUvxmJtPM27hX5sKrw2E8nT2mkaiZ78zjrn84fFo5F7zeRv+
         XntxzL0gBo9WbcRnxRw2FnF+N7rxBswgDPonUDnn97m84avZEKYhA/jULlLMJqNovB+/
         MwlChkvbHdgBUu151E4+93rmkSvYpxJAi7abiXraAKPtJ49xnqWwtABnpexneHas9J2q
         T/X/Me+YHwthYX3b9e+ARYn6x9Jd/65SLSonBPzKxDINQpZlVzl1baztAmdiI8nDk4uk
         97HBYTAsMlSIsZEWpvEbxiBVnQwFZREa2/hzMFh48mYgwAvqOlFU2dPDI+Vbb5qLq0oi
         lywg==
X-Received: by 10.60.131.172 with SMTP id on12mr12643119oeb.18.1396563445862;
        Thu, 03 Apr 2014 15:17:25 -0700 (PDT)
Received: from localhost.localdomain (72-48-77-163.dyn.grandenetworks.net. [72.48.77.163])
        by mx.google.com with ESMTPSA id dh8sm27577997oeb.10.2014.04.03.15.17.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Apr 2014 15:17:25 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Bonn <jonas@southpole.se>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux@lists.openrisc.net, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org, Mark Salter <msalter@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org
Subject: [PATCH 00/20] FDT clean-ups and libfdt support
Date:   Thu,  3 Apr 2014 17:16:43 -0500
Message-Id: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

From: Rob Herring <robh@kernel.org>

This is a series of clean-ups of architecture FDT code and converts the
core FDT code over to using libfdt functions. This is in preparation
to add FDT based address translation parsing functions for early
console support. 

The current MIPS lantiq and xlp DT code is buggy as built-in DTBs need
to be copied out of init section. Patches 2 and 3 should be applied to
3.15.

A branch is available here[1]. Please test! I've compiled on arm,
arm64, mips, microblaze, and powerpc and booted on arm and arm64.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git libfdt

Rob Herring (20):
  mips: octeon: convert to use unflatten_and_copy_device_tree
  mips: lantiq: copy built-in DTB out of init section
  mips: xlp: copy built-in DTB out of init section
  mips: ralink: convert to use unflatten_and_copy_device_tree
  ARM: dt: use default early_init_dt_alloc_memory_arch
  c6x: convert fdt pointers to opaque pointers
  mips: convert fdt pointers to opaque pointers
  of/fdt: consolidate built-in dtb section variables
  of/fdt: create common debugfs
  of/fdt: remove some unneeded includes
  of/fdt: remove unused of_scan_flat_dt_by_path
  of/fdt: update of_get_flat_dt_prop in prep for libfdt
  of/fdt: Convert FDT functions to use libfdt
  of/fdt: use libfdt accessors for header data
  of/fdt: move memreserve and dtb memory reservations into core
  build: add libfdt include path globally
  powerpc: use libfdt accessors for header data
  x86: use libfdt accessors for header data
  of/fdt: convert initial_boot_params to opaque pointer
  of: push struct boot_param_header and defines into powerpc

 Makefile                                    |   5 +
 arch/arc/include/asm/sections.h             |   1 -
 arch/arc/kernel/devtree.c                   |   2 +-
 arch/arm/include/asm/prom.h                 |   2 -
 arch/arm/kernel/devtree.c                   |  34 +--
 arch/arm/mach-exynos/exynos.c               |   2 +-
 arch/arm/mach-vexpress/platsmp.c            |   2 +-
 arch/arm/mm/init.c                          |   1 -
 arch/arm/plat-samsung/s5p-dev-mfc.c         |   4 +-
 arch/arm64/mm/init.c                        |  21 --
 arch/c6x/kernel/setup.c                     |   4 +-
 arch/metag/kernel/setup.c                   |   4 -
 arch/microblaze/kernel/prom.c               |  37 +--
 arch/mips/cavium-octeon/Makefile            |   3 -
 arch/mips/cavium-octeon/setup.c             |  18 +-
 arch/mips/include/asm/mips-boards/generic.h |   4 -
 arch/mips/include/asm/prom.h                |   6 +-
 arch/mips/kernel/prom.c                     |   2 +-
 arch/mips/lantiq/prom.c                     |  15 +-
 arch/mips/lantiq/prom.h                     |   2 -
 arch/mips/mti-sead3/Makefile                |   2 -
 arch/mips/mti-sead3/sead3-setup.c           |   8 +-
 arch/mips/netlogic/xlp/dt.c                 |  17 +-
 arch/mips/ralink/of.c                       |  29 +--
 arch/openrisc/kernel/vmlinux.h              |   2 -
 arch/powerpc/include/asm/prom.h             |  39 +++
 arch/powerpc/kernel/epapr_paravirt.c        |   2 +-
 arch/powerpc/kernel/fadump.c                |   4 +-
 arch/powerpc/kernel/prom.c                  |  77 ++----
 arch/powerpc/kernel/rtas.c                  |   2 +-
 arch/powerpc/mm/hash_utils_64.c             |  22 +-
 arch/powerpc/platforms/52xx/efika.c         |   4 +-
 arch/powerpc/platforms/chrp/setup.c         |   4 +-
 arch/powerpc/platforms/powernv/opal.c       |  12 +-
 arch/powerpc/platforms/pseries/setup.c      |   4 +-
 arch/x86/kernel/devicetree.c                |   7 +-
 arch/xtensa/kernel/setup.c                  |   3 +-
 drivers/of/Kconfig                          |   1 +
 drivers/of/fdt.c                            | 379 +++++++++-------------------
 drivers/of/of_reserved_mem.c                |   4 +-
 include/linux/of_fdt.h                      |  64 +----
 lib/Makefile                                |   2 -
 42 files changed, 261 insertions(+), 596 deletions(-)

-- 
1.8.3.2
