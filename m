Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 21:20:09 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11413 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab1FFTUD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 21:20:03 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ded289f0000>; Mon, 06 Jun 2011 12:21:03 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 6 Jun 2011 12:19:58 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 6 Jun 2011 12:19:58 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p56JJp8v027108;
        Mon, 6 Jun 2011 12:19:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p56JJmix027107;
        Mon, 6 Jun 2011 12:19:48 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH v5 0/6] MIPS: Octeon: Use Device Tree.
Date:   Mon,  6 Jun 2011 12:19:40 -0700
Message-Id: <1307387986-27069-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 06 Jun 2011 19:19:58.0642 (UTC) FILETIME=[B9ABB920:01CC247E]
X-archive-position: 30258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4737

Note: Ralf has started to work on converting more of the MIPS tree to
use the device tree.  We will be working to make both efforts mesh.

New in v5:

Build libfdt in the lib directory instead of devices/of, and include
all libfdt files.

Changes to of_find_node_by_path() requested by Grant Likely.

New irq triggering mode constants.

Boot protocol to pass flattened device tree from bootloader.  This
protocol may change based on attempts to arrive at a common protocol
for all MIPS boards.

New in v4:

Cleanup and error checking suggested by Sergei Shtylyov.

Use device tree passed by bootloader if present.

New in v3:

More updates to device tree bindings, and perhaps more importantly
descriptions/definitions of the bindings

libfdt building moved to devices/of/libfdt.

Cleanup and style improvements as suggested by Grant Likley.

Omitted all the driver changes, as they are unchanged from the last
set, and at this stage the patches are just an RFC.

New in v2:

Changed many device tree bindings.  They should be closer to the
standard naming scheme now.

Editing of the template device tree is done in the flattened form
using libfdt.

Standard platform driver functions used in preference to the
 of_platform variety.

v1:

Background: The Octeon family of SOCs has a variety of on-chip
controllers for Ethernet, MDIO, I2C, and several other I/O devices.
These chips are used on boards with a great variety of different
configurations.  To date, the configuration and bus topology
information has been hard coded in the drivers and support code.

To facilitate supporting new chips and boards, we would like to make
use use the Device Tree to encode the configuration information.

I would like to get some feedback on the current code I am working
with.  The migration approach is as follows:

o A device tree template is statically linked into the kernel image.
  Based on SOC type and board type, legacy configuration probing code
  is used to prune and patch the device tree template.

o New SOCs and boards will directly use a device tree passed by the
  bootloader.


1/6 -  Infrastructure to allow scripts/dtc/libfdt to be used in the
       kernel.

2/6 - OF patch to simplify of_find_node_by_path().

3/6 - Add the statically linked Device Tree templates and bindings
      descriptions.

4/6 - Remove unused arch/mips/prom.c code that conflicts with
      following patches.

5/6 - irq_create_of_mapping() function.

6/6 - Fix up Device Tree template for current environment.

David Daney (6):
  of/lib: Allow scripts/dtc/libfdt to be used from kernel code
  of: Make of_find_node_by_path() traverse /aliases for relative paths.
  MIPS: Octeon: Add device tree source files.
  MIPS: Prune some target specific code out of prom.c
  MIPS: Octeon: Add irq_create_of_mapping() and GPIO interrupts.
  MIPS: Octeon: Initialize and fixup device tree.

 .../devicetree/bindings/mips/cavium/bootbus.txt    |   37 ++
 .../devicetree/bindings/mips/cavium/ciu.txt        |   26 ++
 .../devicetree/bindings/mips/cavium/gpio.txt       |   48 +++
 .../devicetree/bindings/mips/cavium/mdio.txt       |   27 ++
 .../devicetree/bindings/mips/cavium/mix.txt        |   40 ++
 .../devicetree/bindings/mips/cavium/pip.txt        |   98 +++++
 .../devicetree/bindings/mips/cavium/twsi.txt       |   34 ++
 .../devicetree/bindings/mips/cavium/uart.txt       |   19 +
 .../devicetree/bindings/mips/cavium/uctl.txt       |   47 +++
 arch/mips/Kconfig                                  |    1 +
 arch/mips/cavium-octeon/.gitignore                 |    2 +
 arch/mips/cavium-octeon/Makefile                   |   16 +
 arch/mips/cavium-octeon/octeon-irq.c               |  188 +++++++++-
 arch/mips/cavium-octeon/octeon-platform.c          |  319 +++++++++++++++
 arch/mips/cavium-octeon/octeon_3xxx.dts            |  427 ++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c                    |   39 ++
 arch/mips/kernel/prom.c                            |   50 ---
 drivers/of/base.c                                  |   65 +++-
 include/linux/libfdt.h                             |    8 +
 include/linux/libfdt_env.h                         |   13 +
 lib/Kconfig                                        |    6 +
 lib/Makefile                                       |    5 +
 lib/fdt.c                                          |    2 +
 lib/fdt_ro.c                                       |    2 +
 lib/fdt_rw.c                                       |    2 +
 lib/fdt_strerror.c                                 |    2 +
 lib/fdt_sw.c                                       |    2 +
 lib/fdt_wip.c                                      |    2 +
 28 files changed, 1473 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/bootbus.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/ciu.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/gpio.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/mdio.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/mix.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/pip.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/twsi.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/uart.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/uctl.txt
 create mode 100644 arch/mips/cavium-octeon/.gitignore
 create mode 100644 arch/mips/cavium-octeon/octeon_3xxx.dts
 create mode 100644 include/linux/libfdt.h
 create mode 100644 include/linux/libfdt_env.h
 create mode 100644 lib/fdt.c
 create mode 100644 lib/fdt_ro.c
 create mode 100644 lib/fdt_rw.c
 create mode 100644 lib/fdt_strerror.c
 create mode 100644 lib/fdt_sw.c
 create mode 100644 lib/fdt_wip.c

-- 
1.7.2.3
