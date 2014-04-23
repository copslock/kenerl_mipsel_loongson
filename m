Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 03:18:57 +0200 (CEST)
Received: from mail-ob0-f182.google.com ([209.85.214.182]:63484 "EHLO
        mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822265AbaDWBSzWKlVh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 03:18:55 +0200
Received: by mail-ob0-f182.google.com with SMTP id uy5so305359obc.27
        for <multiple recipients>; Tue, 22 Apr 2014 18:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=32O/J7o9elSEXpQGeDBXSZRNQplUWc+GSF0YwuG61Yg=;
        b=e0olYb0r+DwYVXkSWaWfplLCOBdeXarYacGQx/RZJjOQrASKo8t/9u5PiKD2kbTeri
         WdHSMxUQYtN+II/PyCVw3v7AgAjBR9rEzQrs6IejQjI3SQ9DNsUb2dUqdEyt30K0edQI
         nAnfmk7ueKwjVXS+WRkwD38k2m4U1lHEux7hfO/xVSjcL3y6fsNIYYxXUav/QyzZaVmW
         p9r/AXYIszOz7F4SYA1oTrHwxbmmRPDpgsakmrGoQ2d5IDVDrX6UZCW15lGfLK0lnepB
         oLyqVkX40GFwP4kN3IULr2YtjOuoshhL3MAzHQGviQwr3ZinldUUPo9K+0MUQItF5CRE
         akvQ==
X-Received: by 10.182.233.201 with SMTP id ty9mr40328619obc.29.1398215928750;
        Tue, 22 Apr 2014 18:18:48 -0700 (PDT)
Received: from localhost.localdomain (72-48-77-163.dyn.grandenetworks.net. [72.48.77.163])
        by mx.google.com with ESMTPSA id f1sm184735295oej.5.2014.04.22.18.18.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 18:18:48 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     Grant Likely <grant.likely@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v2 00/21] FDT clean-ups and libfdt support
Date:   Tue, 22 Apr 2014 20:18:00 -0500
Message-Id: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39900
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
console support. This series removes direct access to FDT data from all
arches except powerpc.

The current MIPS lantiq and xlp DT code is buggy as built-in DTBs need
to be copied out of init section. Patches 2 and 3 should be applied to
3.15.

Changes in v2 are relatively minor. There was a bug in the unflattening
code where walking up the tree was not being handled correctly (thanks
to Michal Simek). I re-worked things a bit to avoid globally adding
libfdt include paths.

A branch is available here[1], and I plan to put into linux-next in a few
days. Please test! I've compiled on arm, arm64, mips, microblaze, xtensa,
and powerpc and booted on arm and arm64.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git libfdt

Rob Herring (21):
  mips: octeon: convert to use unflatten_and_copy_device_tree
  mips: lantiq: copy built-in DTB out of init section
  mips: xlp: copy built-in DTB out of init section
  mips: ralink: convert to use unflatten_and_copy_device_tree
  ARM: dt: use default early_init_dt_alloc_memory_arch
  c6x: convert fdt pointers to opaque pointers
  mips: convert fdt pointers to opaque pointers
  of/fdt: consolidate built-in dtb section variables
  of/fdt: remove some unneeded includes
  of/fdt: remove unused of_scan_flat_dt_by_path
  of/fdt: update of_get_flat_dt_prop in prep for libfdt
  of/fdt: Convert FDT functions to use libfdt
  of/fdt: use libfdt accessors for header data
  of/fdt: create common debugfs
  of/fdt: move memreserve and dtb memory reservations into core
  of/fdt: fix phys_addr_t related print size warnings
  of/fdt: introduce of_get_flat_dt_size
  powerpc: use libfdt accessors for header data
  x86: use FDT accessors for FDT blob header data
  of/fdt: convert initial_boot_params to opaque pointer
  of: push struct boot_param_header and defines into powerpc

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
 arch/microblaze/kernel/prom.c               |  39 +--
 arch/mips/cavium-octeon/setup.c             |  20 +-
 arch/mips/include/asm/mips-boards/generic.h |   4 -
 arch/mips/include/asm/prom.h                |   6 +-
 arch/mips/kernel/prom.c                     |   2 +-
 arch/mips/lantiq/prom.c                     |  15 +-
 arch/mips/lantiq/prom.h                     |   2 -
 arch/mips/mti-sead3/sead3-setup.c           |   8 +-
 arch/mips/netlogic/xlp/dt.c                 |  19 +-
 arch/mips/ralink/of.c                       |  29 +-
 arch/openrisc/kernel/vmlinux.h              |   2 -
 arch/powerpc/include/asm/prom.h             |  39 +++
 arch/powerpc/kernel/Makefile                |   1 +
 arch/powerpc/kernel/epapr_paravirt.c        |   2 +-
 arch/powerpc/kernel/fadump.c                |   4 +-
 arch/powerpc/kernel/prom.c                  |  78 ++----
 arch/powerpc/kernel/rtas.c                  |   2 +-
 arch/powerpc/mm/hash_utils_64.c             |  22 +-
 arch/powerpc/platforms/52xx/efika.c         |   4 +-
 arch/powerpc/platforms/chrp/setup.c         |   4 +-
 arch/powerpc/platforms/powernv/opal.c       |  12 +-
 arch/powerpc/platforms/pseries/setup.c      |   4 +-
 arch/x86/kernel/devicetree.c                |  12 +-
 arch/xtensa/kernel/setup.c                  |   3 +-
 drivers/of/Kconfig                          |   1 +
 drivers/of/Makefile                         |   2 +
 drivers/of/fdt.c                            | 398 ++++++++++------------------
 drivers/of/of_reserved_mem.c                |   4 +-
 include/linux/of_fdt.h                      |  63 +----
 40 files changed, 280 insertions(+), 598 deletions(-)

-- 
1.9.1
