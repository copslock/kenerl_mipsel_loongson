Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:05:59 +0100 (CET)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:39018 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007249AbaLOSF5pGcgp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:05:57 +0100
Received: by mail-lb0-f171.google.com with SMTP id w7so5351873lbi.16
        for <linux-mips@linux-mips.org>; Mon, 15 Dec 2014 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nVyYk2zRE8K017NaT+fVRKgwrgZFr8hmeMfEnV1gAJE=;
        b=uwRfZWjjXIIxgIwQrBAgPhlC4wkYBwGLuFTciLxjJbFWGnSjLU10Wev109hYx+xTp2
         kz+dBSpaE3APd+iO6MLOUo1S9H3VHshwJGnWbfl7AJSwg8T0AgHzWlTuW811VfA6Y7l5
         84r6n31RO32J9WtYrv3jc8gp4JCcxTebmVEo9IuWPy3ZIW6+Nlh121JaEfbWsjFnWn+v
         vFQMt0dDWMe/c9dlLZRU584GRjJYKiYhXCZmhEGRwjuKqKr57zt5E4qrv83TgaLDecT2
         FgCAmC3o9lvrXrZmyuAXOdx5PvsuY4ddCmPkY5sR7Ix76cyhQZlbZSvql2dAkpeG3OiW
         WueA==
X-Received: by 10.112.142.201 with SMTP id ry9mr8457508lbb.4.1418666752273;
        Mon, 15 Dec 2014 10:05:52 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.05.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:05:51 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>
Subject: [PATCH 00/14] MIPS: OCTEON: Some partial support for Octeon III
Date:   Mon, 15 Dec 2014 21:03:06 +0300
Message-Id: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: feumilieu@gmail.com
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

These patches fix some issues in the Cavium Octeon code and
introduce some partial support for Octeon III and little-endian.

Aleksey Makarov (1):
  MIPS: OCTEON: Delete unused COP2 saving code

Chandrakala Chavva (1):
  MIPS: OCTEON: Use correct instruction to read 64-bit COP0 register

David Daney (12):
  MIPS: OCTEON: Save/Restore wider multiply registers in OCTEON III CPUs
  MIPS: OCTEON: Fix FP context save.
  MIPS: OCTEON: Save and restore CP2 SHA3 state
  MIPS: Remove unneeded #ifdef __KERNEL__ from asm/processor.h
  MIPS: OCTEON: Implement the core-16057 workaround
  MIPS: OCTEON: Don't do acknowledge operations for level triggered
    irqs.
  MIPS: OCTEON: Add ability to used an initrd from a named memory block.
  MIPS: OCTEON: Add little-endian support to asm/octeon/octeon.h
  MIPS: OCTEON: Implement DCache errata workaround for all CN6XXX
  MIPS: OCTEON: Update octeon-model.h code for new SoCs.
  MIPS: OCTEON: Add register definitions for OCTEON III reset unit.
  MIPS: OCTEON: Handle OCTEON III in csrc-octeon.

 arch/mips/cavium-octeon/csrc-octeon.c              |  10 +
 arch/mips/cavium-octeon/octeon-irq.c               |  45 ++-
 arch/mips/cavium-octeon/setup.c                    |  81 +++-
 arch/mips/include/asm/bootinfo.h                   |   1 +
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  22 +
 arch/mips/include/asm/mach-cavium-octeon/war.h     |   3 +
 arch/mips/include/asm/octeon/cvmx-rst-defs.h       | 441 +++++++++++++++++++++
 arch/mips/include/asm/octeon/octeon-model.h        |  65 ++-
 arch/mips/include/asm/octeon/octeon.h              | 148 +++++--
 arch/mips/include/asm/processor.h                  |   8 +-
 arch/mips/include/asm/ptrace.h                     |   4 +-
 arch/mips/kernel/asm-offsets.c                     |   1 +
 arch/mips/kernel/octeon_switch.S                   | 218 ++++++----
 arch/mips/kernel/setup.c                           |  19 +-
 arch/mips/mm/uasm.c                                |   2 +-
 15 files changed, 935 insertions(+), 133 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-rst-defs.h

-- 
2.1.3
