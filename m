Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Feb 2012 20:21:38 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:65501 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903788Ab2B2TVa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Feb 2012 20:21:30 +0100
Received: by ghbf11 with SMTP id f11so1750057ghb.36
        for <multiple recipients>; Wed, 29 Feb 2012 11:21:23 -0800 (PST)
Received-SPF: pass (google.com: domain of ddaney.cavm@gmail.com designates 10.101.152.32 as permitted sender) client-ip=10.101.152.32;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of ddaney.cavm@gmail.com designates 10.101.152.32 as permitted sender) smtp.mail=ddaney.cavm@gmail.com; dkim=pass header.i=ddaney.cavm@gmail.com
Received: from mr.google.com ([10.101.152.32])
        by 10.101.152.32 with SMTP id e32mr763263ano.68.1330543283767 (num_hops = 1);
        Wed, 29 Feb 2012 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=hKvZLRd3zvQvUDjgDu5WjSOXkOi2KJN9+SRjGL1Z9Uw=;
        b=sfZiNmNRoje9GfEfqT6gYnrma6oyVt5SuT/0XssqSBO9Y8f64aAUWFQrShbLO8nXph
         KWo5l/xchetawqQ9VTEdnJ1lwlWuSUhU/qbR7ApyTEB5p1eRqwKy66V4uAWYk89Myw/w
         EO8+WkcR1QCqWPmsQifh1wB9WEoMzDr0aQg/E=
Received: by 10.101.152.32 with SMTP id e32mr605265ano.68.1330543283668;
        Wed, 29 Feb 2012 11:21:23 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id k16sm22577663anm.18.2012.02.29.11.21.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 11:21:22 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q1TJLKDo018137;
        Wed, 29 Feb 2012 11:21:20 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q1TJLH1v018136;
        Wed, 29 Feb 2012 11:21:17 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 0/2] of: Device Tree enhancements needed by MIPS/OCTEON
Date:   Wed, 29 Feb 2012 11:21:02 -0800
Message-Id: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

These two patches have been around for quite a while now.  I am
currently making a big push to get all out-of-tree OCTEON patches
upstream, and these two are prerequisites for all the rest.  The last
changes requested by Grant Likely and David Gibson (last May) are
incorporated.

As always, more comments are welcome, but it would be nice to see them
get merged too.


v6: No changes other than to split these out of the MIPS/OCTEON patch
    set to allow them to be merged separately if desired.

v5: Build libfdt in the lib directory instead of devices/of, and
    include all libfdt files.

    Changes to of_find_node_by_path() requested by Grant Likely.

v4: No changes to these two patches.

v3: libfdt building moved to devices/of/libfdt.  Cleanup and style
    improvements as suggested by Grant Likley.

v2: No changes to these two patches.


Background: The Octeon family of SOCs has a variety of on-chip
controllers for Ethernet, MDIO, I2C, and several other I/O devices.
These chips are used on boards with a great variety of different
configurations.  To date, the configuration and bus topology
information has been hard coded in the drivers and support code.

To facilitate supporting new chips and boards, we make use use the
Device Tree to encode the configuration information.  Migration to use
of the device tree is as follows:

o A device tree template is statically linked into the kernel image.
  Based on SOC type and board type, legacy configuration probing code
  is used to prune and patch the device tree template.

o New SOCs and boards will directly use a device tree passed by the
  bootloader.


These two patches are prerequisites for the bulk of the OCTEON changes.

1/2 - Infrastructure to allow scripts/dtc/libfdt to be used in the
      kernel.  As mentioned above, when using legacy bootloaders, we
      prune an in-kernel FDT image based on legacy probing code.
      libfdt is used to do the pruning.

2/2 - Enhancements to of_find_node_by_path() to allow it to traverse
      /aliases.  This is used by the OCTEON Ethernet drivers.


David Daney (2):
  of/lib: Allow scripts/dtc/libfdt to be used from kernel code
  of: Make of_find_node_by_path() traverse /aliases for relative paths.

 drivers/of/base.c          |   65 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/libfdt.h     |    8 +++++
 include/linux/libfdt_env.h |   13 +++++++++
 lib/Kconfig                |    6 ++++
 lib/Makefile               |    5 +++
 lib/fdt.c                  |    2 +
 lib/fdt_ro.c               |    2 +
 lib/fdt_rw.c               |    2 +
 lib/fdt_strerror.c         |    2 +
 lib/fdt_sw.c               |    2 +
 lib/fdt_wip.c              |    2 +
 11 files changed, 106 insertions(+), 3 deletions(-)
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
