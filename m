Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 01:43:14 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33048 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011619AbcBEAnMdW5ql (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 01:43:12 +0100
Received: by mail-pa0-f66.google.com with SMTP id pv5so1733139pac.0;
        Thu, 04 Feb 2016 16:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1syASTiN8af8oRXB3aQQm8kpEU2toMeIiKyI4UyFfrY=;
        b=p1gfyrh44/vrY09+sK551ZDd0e8lQ+KxWkfQXo0CErEHyyQ8Z+NzuE4bwoxAIGVz8/
         1ECZ2eOFU0fgWVlFpqxMUqIvJ+avufUEic8Qar+htqekYV2bAG2OU4xjGD2ygyxKREV1
         ZcIO0vUJRfm19ImMxXkQTm0MTulkXY8OwnggbQeBImyjTe5HLIOuc9BeOS64h81dDHSH
         U1fLZQufFImuIg1HmmlTZVIRJ4nIIh4fpK0Wbg7awsK83ZhsIzhZOZEIDj0cuyKiW5eZ
         aBairvaKhMUg3esxDXBIOplIzZ9nmx8dXaBOoPalKuyIWEunBNbX1l9smrmjljdrubBX
         OLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1syASTiN8af8oRXB3aQQm8kpEU2toMeIiKyI4UyFfrY=;
        b=CuzgvrA9e5VZJ57ZjEQYojTxvgrv8mBeh9kjBm6L9JaWw0mD3HuoI2RoaFdHhHzLTt
         Jy3oOBjuEi6KFnMUCS/z5lSp5E3jQzxwn37ONP2wp+EwxLz4h2khnprM+2+uQiYQbgcd
         9oPsz5lSZLEXjgeYtYGFHZEKrm171i4lMtRy+iB961rpVeqx1A4+nC7K2PfBdLE8y5GX
         R/WtTBquJpB4Z95qwrtcZHaymSYITOsUP56V9zoV6pBR9EfmLAzKhERsYN10ES7s9IQN
         p2q9RuFuHttJHFylqC5D3GUAP/Kpan3kCt3GEh91xLPFQUtdtKW0q0c3LKZF4np2nXfY
         +7+A==
X-Gm-Message-State: AG10YOTMjlMMCFLe5PworVSqh9llQzgIWhr/GzriqbbfyeSx6kNXBu3j6xkO6fqprPAhKA==
X-Received: by 10.66.142.234 with SMTP id rz10mr15603998pab.113.1454632986440;
        Thu, 04 Feb 2016 16:43:06 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id q16sm19730004pfi.80.2016.02.04.16.43.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 16:43:04 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u150h2Nt007727;
        Thu, 4 Feb 2016 16:43:03 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u150gvbX007725;
        Thu, 4 Feb 2016 16:42:57 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/7] MIPS: Add support for OCTEON cn78xx and cn73xx.
Date:   Thu,  4 Feb 2016 16:42:47 -0800
Message-Id: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The OCTEON III cn78xx and cn73xx family of SoCs has some architectural
differences from previous OCTEON processors.

Here we add support for the new interrupt controller and related IPI
machinery.  This is enough to be able to boot an initrd based system
to a command prompt on the serial console.

Still pending are support for: PCI, Watchdog, I2C, Sata, USB,
Ethernet, etc.

This set depends on these two sets:
http://www.linux-mips.org/archives/linux-mips/2016-02/msg00051.html
http://www.linux-mips.org/archives/linux-mips/2016-02/msg00041.html

All patches are to the MIPS tree except the device tree binding
definition.  Probably they could be merged via Ralf's tree if there
were no objections.

David Daney (7):
  MIPS: OCTEON: Remove some code limiting NR_IRQS to 255
  MIPS: Select CONFIG_HANDLE_DOMAIN_IRQ and make it work.
  MIPS: OCTEON: Add register definitions for cn73xx, cnf75xx and
    cn78xx.
  MIPS: OCTEON: Add model checking support for cn73xx, cnf75xx and
    cn78xx
  MIPS: OCTEON: Don't attempt to use nonexistent registers on OCTEON
    III models.
  MIPS: OCTEON: Add support for OCTEON III interrupt  controller.
  MIPS: OCTEON: Add SMP support for OCTEON cn78xx et al.

 .../devicetree/bindings/mips/cavium/ciu3.txt       |  27 +
 arch/mips/Kconfig                                  |   1 +
 arch/mips/cavium-octeon/csrc-octeon.c              |  13 +-
 arch/mips/cavium-octeon/executive/octeon-model.c   |  82 ++-
 arch/mips/cavium-octeon/octeon-irq.c               | 678 ++++++++++++++++++++-
 arch/mips/cavium-octeon/setup.c                    |  36 +-
 arch/mips/cavium-octeon/smp.c                      | 145 ++++-
 arch/mips/include/asm/irq_regs.h                   |  10 +
 arch/mips/include/asm/octeon/cvmx-ciu3-defs.h      | 353 +++++++++++
 arch/mips/include/asm/octeon/cvmx-fpa-defs.h       |   1 +
 arch/mips/include/asm/octeon/cvmx-mio-defs.h       | 410 ++++++++++++-
 arch/mips/include/asm/octeon/cvmx.h                |  27 +-
 arch/mips/include/asm/octeon/octeon-feature.h      |  19 +-
 arch/mips/include/asm/octeon/octeon-model.h        |   5 +
 arch/mips/include/asm/octeon/octeon.h              |   8 +
 15 files changed, 1733 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/ciu3.txt
 create mode 100644 arch/mips/include/asm/octeon/cvmx-ciu3-defs.h

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>

-- 
1.7.11.7
