Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:51:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43234 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006683AbbEVPvvBzkUE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:51:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5806754655B07;
        Fri, 22 May 2015 16:51:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:51:47 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:51:46 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Hannes Reinecke <hare@suse.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        <linux-serial@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Christoph Hellwig <hch@lst.de>, Michal Marek <mmarek@suse.cz>,
        Jason Cooper <jason@lakedaemon.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 00/15] MIPS Malta DT Conversion
Date:   Fri, 22 May 2015 16:50:59 +0100
Message-ID: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series begins converting the MIPS Malta board to use device tree,
which is done with a few goals in mind:

  - To modernise the Malta board support, providing a cleaner example to
    people referencing it when bringing up new boards and reducing the
    amount of code they need to write.

  - To make the code at the board level more generic with the eventual
    aim of sharing it between multiple boards & allowing for
    multi-platform kernel binaries. Although this series doesn't result
    in the kernel reaching those goals, it is a step in that direction.

  - To result in a more maintainable kernel through a combination of the
    above.


Paul Burton (15):
  MIPS: define GCR_GIC_STATUS register fields
  MIPS: include errno.h for ENODEV in mips-cm.h
  MIPS: malta: basic DT plumbing
  MIPS: i8259: DT support
  irqchip: mips-gic: register IRQ domain with MIPS_GIC_IRQ_BASE
  MIPS: malta: probe interrupt controllers via DT
  MIPS: remove [SR]ocIt(2) IRQ handling code
  of_serial: support for UARTs on I/O ports
  MIPS: malta: probe UARTs using DT
  MIPS: malta: probe RTC via DT
  MIPS: malta: probe pflash via DT
  MIPS: malta: remove fw_memblock_t abstraction
  MIPS: malta: remove nonsense memory limit
  MIPS: malta: setup RAM regions via DT
  MIPS: malta: setup post-I/O hole RAM on non-EVA

 arch/mips/Kconfig                               |   3 +
 arch/mips/boot/dts/mti/Makefile                 |   1 +
 arch/mips/boot/dts/mti/malta.dts                | 150 +++++++++++++++
 arch/mips/configs/malta_defconfig               |   3 +-
 arch/mips/configs/malta_kvm_defconfig           |   3 +-
 arch/mips/configs/malta_kvm_guest_defconfig     |   3 +-
 arch/mips/configs/malta_qemu_32r6_defconfig     |   1 +
 arch/mips/configs/maltaaprp_defconfig           |   1 +
 arch/mips/configs/maltasmvp_defconfig           |   1 +
 arch/mips/configs/maltasmvp_eva_defconfig       |   1 +
 arch/mips/configs/maltaup_defconfig             |   1 +
 arch/mips/configs/maltaup_xpa_defconfig         |   3 +-
 arch/mips/include/asm/fw/fw.h                   |  16 --
 arch/mips/include/asm/i8259.h                   |   1 +
 arch/mips/include/asm/mach-malta/malta-dtshim.h |  29 +++
 arch/mips/include/asm/mips-cm.h                 |   5 +
 arch/mips/include/asm/msc01_ic.h                | 147 ---------------
 arch/mips/kernel/Makefile                       |   1 -
 arch/mips/kernel/i8259.c                        |  43 ++++-
 arch/mips/kernel/irq-msc01.c                    | 159 ----------------
 arch/mips/mti-malta/Makefile                    |   6 +-
 arch/mips/mti-malta/malta-dt.c                  |  34 ++++
 arch/mips/mti-malta/malta-dtshim.c              | 238 ++++++++++++++++++++++++
 arch/mips/mti-malta/malta-int.c                 | 130 +------------
 arch/mips/mti-malta/malta-memory.c              | 131 +------------
 arch/mips/mti-malta/malta-platform.c            | 147 ---------------
 arch/mips/mti-malta/malta-setup.c               |   7 +
 arch/mips/mti-malta/malta-time.c                |   1 -
 drivers/irqchip/irq-mips-gic.c                  |   2 +-
 drivers/tty/serial/of_serial.c                  |   7 +-
 30 files changed, 542 insertions(+), 733 deletions(-)
 create mode 100644 arch/mips/boot/dts/mti/malta.dts
 create mode 100644 arch/mips/include/asm/mach-malta/malta-dtshim.h
 delete mode 100644 arch/mips/include/asm/msc01_ic.h
 delete mode 100644 arch/mips/kernel/irq-msc01.c
 create mode 100644 arch/mips/mti-malta/malta-dt.c
 create mode 100644 arch/mips/mti-malta/malta-dtshim.c
 delete mode 100644 arch/mips/mti-malta/malta-platform.c

-- 
2.4.1
