Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 02:11:44 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:59574 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904250Ab1KKBLk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 02:11:40 +0100
Received: by yenl9 with SMTP id l9so3178425yen.36
        for <multiple recipients>; Thu, 10 Nov 2011 17:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=36L341+dZovcUHbZPF6elEJzA9UDmiYsyBP6Yoh065I=;
        b=RAxIa/oNYtZOTl/6a8GuaEd0OJpD/hxSozHrCK7UOpqZ4af1K3r5V2aC6JxSVNj5Bd
         Hdhmib70Y+NcksduQVukG9MMTP6ciUoApKE5ABrdOiRNGNBrav5ASh9IHCLs5qj1UpBm
         /qrp6KsJ7cBgFjESyvAVVOxwE8IP5kDhL/iF8=
Received: by 10.101.155.21 with SMTP id h21mr4711653ano.69.1320973894537;
        Thu, 10 Nov 2011 17:11:34 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 33sm13318485ano.1.2011.11.10.17.11.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 17:11:34 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAB1BWBY030114;
        Thu, 10 Nov 2011 17:11:32 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAB1BUS6030112;
        Thu, 10 Nov 2011 17:11:30 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] of: Allow scripts/dtc/libfdt to be used from kernel code and more...
Date:   Thu, 10 Nov 2011 17:11:27 -0800
Message-Id: <1320973889-30079-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9896

From: David Daney <david.daney@cavium.com>

My next patch set for OCTEON device tree support relies on these two
patches.  I split these out as they are architecture independent.

I iterated on these several times under the guise of an RFC, this is
their first appearance as a request to be merged.

Thanks,

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
