Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 20:01:23 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34083 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012167AbcBITBDHy4CR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 20:01:03 +0100
Received: by mail-pf0-f193.google.com with SMTP id 71so5310860pfv.1;
        Tue, 09 Feb 2016 11:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Tx+TgQvw51g/TlRI7eRqX6zbclP8mQgtpdHL5vQ8SJ8=;
        b=mDprJzd9wCWEUX2uWBaNaZhL8KF2w1KmGaUSBaPZGAvHRMZCmDj1vfV9qoBKXCJV0K
         Q16UJnaY7sNUd94M8Wga7lSMyE6xs09wwr32VGWK0T54ZLczyXvR+53l5Fago4ZZJF+K
         DeD/NW2Kjfa6L4V+G3ftpH4GLOcsF24w0jebnYRpnFm2Hq3VURXoVFlXqQkJK8bKZCTP
         wSbHLdmmhNUAljS+RDOTPfLqbVQWebDQu72lEth5wAXQC12e2E+qBkXrvX5KCoQlGg+R
         IS53oZN7SuxEzODtpun+UdVnOcDchCHFxu+EPnQSYkgFIUbycx7+eB2N1vTIMEkYoNLp
         k0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tx+TgQvw51g/TlRI7eRqX6zbclP8mQgtpdHL5vQ8SJ8=;
        b=WhKuUEywAIu+63GCd/99ywoD2fWlUWCdgt/Qaai4gZVdxe+MIF+3CBx6ycGghr4XVl
         65Qr3Oft/HlVSR59xQWMQUgPrrilaSknArxTTyW3YFjSUvK56V+xpDSC65FafV2wP5lQ
         fnNJyylX7oIeKW23x1p6z6OmTzQfwejT+LWIM9169PcjiMaGoUkXXOYcAdx2kIewzlMZ
         KmmggFg9ZYP9p1/01Zcou90pysNDsjmk07dxFR2U6yY7RKoWGjiWOpA9QMZPHT/AKBgJ
         Hfvj632F50tR/0XtfvXHa7AbeY3vSgOLzwDMoKhnIvJBuxA7mtgcvfHs6kQnkfJfxjGP
         yFCA==
X-Gm-Message-State: AG10YORiXDIokg/bCE9jMc4DLVCZEPA7a9PwU3aQtjzzlyrR/bFTswN9tY238PLorxZesw==
X-Received: by 10.98.40.200 with SMTP id o191mr25435071pfo.83.1455044457158;
        Tue, 09 Feb 2016 11:00:57 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id r77sm52272972pfa.47.2016.02.09.11.00.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 11:00:53 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u19J0mUw009867;
        Tue, 9 Feb 2016 11:00:51 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u19J0V9A009864;
        Tue, 9 Feb 2016 11:00:32 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/8] MIPS: Add support for OCTEON cn78xx and cn73xx.
Date:   Tue,  9 Feb 2016 11:00:05 -0800
Message-Id: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51908
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

Changes from v1: Added Acked-by: Rob Herring to 6/8.  Simplifications
                 suggested by tglx.  Added 8/8.

David Daney (8):
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
  MIPS: OCTEON: Simplify code in octeon_irq_ciu_gpio_set_type()

 .../devicetree/bindings/mips/cavium/ciu3.txt       |  27 +
 arch/mips/Kconfig                                  |   1 +
 arch/mips/cavium-octeon/csrc-octeon.c              |  13 +-
 arch/mips/cavium-octeon/executive/octeon-model.c   |  82 ++-
 arch/mips/cavium-octeon/octeon-irq.c               | 679 ++++++++++++++++++++-
 arch/mips/cavium-octeon/setup.c                    |  36 +-
 arch/mips/cavium-octeon/smp.c                      | 145 ++++-
 arch/mips/include/asm/irq_regs.h                   |  10 +
 arch/mips/include/asm/octeon/cvmx-ciu3-defs.h      | 353 +++++++++++
 arch/mips/include/asm/octeon/cvmx-fpa-defs.h       |   1 +
 arch/mips/include/asm/octeon/cvmx-mio-defs.h       | 410 ++++++++++++-
 arch/mips/include/asm/octeon/cvmx.h                |  27 +-
 arch/mips/include/asm/octeon/octeon-feature.h      |  19 +-
 arch/mips/include/asm/octeon/octeon-model.h        |   5 +
 arch/mips/include/asm/octeon/octeon.h              |  25 +
 15 files changed, 1750 insertions(+), 83 deletions(-)
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
