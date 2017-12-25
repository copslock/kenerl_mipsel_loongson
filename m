Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Dec 2017 16:26:28 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:41719 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990426AbdLYP0UEkrJf convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Dec 2017 16:26:20 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 25 Dec 2017 15:24:53 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Mon, 25 Dec 2017 07:23:53 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        James Hogan <James.Hogan@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH v11 0/3] MIPS: Add virtual Ranchu board as a
 generic-based board
Thread-Topic: [PATCH v11 0/3] MIPS: Add virtual Ranchu board as a
 generic-based board
Thread-Index: AQHTdcSzmHZkWEPSD0KVrWyNSeBmOKNUPQ2k
Date:   Mon, 25 Dec 2017 15:23:52 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEEC28217@MIPSMAIL01.mipstec.com>
References: <1513356553-7238-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1513356553-7238-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1514215492-321457-23977-129977-11
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188338
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
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

ping
________________________________________
From: Aleksandar Markovic [aleksandar.markovic@rt-rk.com]
Sent: Friday, December 15, 2017 5:48 PM
To: linux-mips@linux-mips.org
Cc: Aleksandar Markovic; David S. Miller; Douglas Leung; Goran Ferenc; Greg Kroah-Hartman; James Hogan; linux-kernel@vger.kernel.org; Mauro Carvalho Chehab; Miodrag Dinic; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Randy Dunlap
Subject: [PATCH v11 0/3] MIPS: Add virtual Ranchu board as a generic-based board

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

v10->v11:

    - rebased to the latest code

v9->v10:

    - added comment in code segment related to measuring frequency
    - rebased to the latest code

v8->v9:

    - cleaned up PIC initialization details
    - added missing '\n' to pr_err() invocations
    - removed two Goldfish FB patches, since they got accepted
    - rebased to the latest code

v7->v8:

    - cleaned commit message for patch #2
    - cleaned GPL licence text for patch #2
    - revised Goldfish PIC error and info messages
    - simplified code around MIPS_MACHINE() for Ranchu
    - changed an instance of "__initdata" to "__initconst" in Ranchu
    - rebased to the latest code

v6->v7:

    - improved commit message for patch 5 (Add Ranchu as a...)
    - added code comments for segment that reads clock high/low
    - revised usage of "u32", "u64" variables in Ranchu code
    - revised header inclusion in Ranchu code
    - added code comments for segment that reads clock high/low
    - improved displayed message for Ranchu in Kconfig
    - added a Ranchu-specific file as maintained in MAINTAINERS
    - added proper handling of an error case in PIC initialization
    - improved error messages issued during PIC initialization
    - rebased to the latest code

v5->v6:

    - revised cascading handling code in Goldfish PIC implementation
    - used more generic node name in Goldfish PIC documentation file
    - used more generic node name in Goldfish FB documentation file
    - corrected several minor items in both documentation files
    - revisited copyright messages in two source files
    - rebased to the latest code

v4->v5:

    - removed RTC clock-related patches since they are already applied
    - removed 8042-related patch since this issue is expected to be
      resolved on the whole platform level
    - redesigned Goldfish PIC driver
    - updated email addresses in commit messages and MAINTAINERS file
      to contain "@mips.com" instead of "@imgtec.com"
    - used "MIPS" instead of "Mips" in commit messages
    - rebased to the latest code

v3->v4:

    - corrected RTC clock patch so that it does not cause build
      errors for some targets, and limited compile support to MIPS
      architecture, since it is the only case where this driver is
      used
    - changed titles of patches 2 and 4 to make them consistent
      with commit messages of corresponding directories
    - applied "checkpatch --strict" to the whole series and
      corrected several instances of reported warnings
    - rebased to the latest code

v2->v3:

    - fixed configuration dependency for VIRTIO_NET and
        RTC_DRV_GOLDFISH
    - fixed frequency calculation in ranchu_measure_hpt_freq()
    - use DT info instead of hard-coding RTC base in
        ranchu_measure_hpt_freq()
    - Goldfish PIC reworked to follow legacy irq domain paradigm
    - Goldfish RTC reimplemented to support alarm functionality
    - added COMPILE_TEST to Goldfish PIC & RTC to extend compile
        test coverage
    - corrected location of documentation for Goldfish FB
    - added a patch on unselecting ARCH_MIGHT_HAVE_PC_SERIO
    - removed two patches on i8042 as not needed in new organization
    - removed the patch on separate MIPS Android config as not needed
    - rebased to the latest code

v1->v2:

    - patch on RTC driver cleaned up
    - added drivers for virtio console and net to the Ranchu board
    - minor improvements in commit messages
    - updated recipient lists using get_maintainer.pl
    - rebased to the latest code

This series adds MIPS Ranchu virtual machine used by Android emulator.
The board relies on the concept of MIPS generic boards, and utilizes
generic board framework for build and device organization.

The Ranchu board is intended to be used by Android emulator.The name
"Ranchu" originates from Android development community. "Goldfish" and
"Ranchu" are names for two generations of virtual boards used by
Android emulator. "Ranchu" is a newer one among the two, and this
series deals with Ranchu. However, for historical reasons, some file,
device, and variable names in this series still contain the word
"Goldfish".

MIPS Ranchu machine includes a number of Goldfish devices. The
support for Virtio devices is also included. Ranchu board supports
up to 16 virtio devices which can be attached using virtio MMIO Bus.
This is summarized in the following picture:

       ABUS
        ||----MIPS CPU
        ||       |                    IRQs
        ||----Goldfish PIC------------(32)--------
        ||                     | | | | | | | | |
        ||----Goldfish TTY------ | | | | | | | |
        ||                       | | | | | | | |
        ||----Goldfish RTC-------- | | | | | | |
        ||                         | | | | | | |
        ||----Goldfish FB----------- | | | | | |
        ||                           | | | | | |
        ||----Goldfish Events--------- | | | | |
        ||                             | | | | |
        ||----Goldfish Audio------------ | | | |
        ||                               | | | |
        ||----Goldfish Battery------------ | | |
        ||                                 | | |
        ||----Android PIPE------------------ | |
        ||                                   | |
        ||----Virtio MMIO Bus                | |
        ||    |    |    |                    | |
        ||    |    |   (virtio-block)--------- |
        ||   (16)  |                           |
        ||    |   (virtio-net)------------------


Device Tree is created on the QEMU side based on the information about
devices IO map and IRQ numbers. Kernel will load this DTB using UHI
boot protocol.

Checkpatch script outputs a small number of warnings if applied to
this series. We did not correct the code, since we think the code is
correct for those particular cases of checkpatch warnings.

Miodrag Dinic (3):
  Documentation: Add device tree binding for Goldfish PIC driver
  irqchip/irq-goldfish-pic: Add Goldfish PIC driver
  MIPS: ranchu: Add Ranchu as a new generic-based board

 .../interrupt-controller/google,goldfish-pic.txt   |  30 +++++
 MAINTAINERS                                        |  13 ++
 arch/mips/configs/generic/board-ranchu.config      |  30 +++++
 arch/mips/generic/Kconfig                          |  10 ++
 arch/mips/generic/Makefile                         |   1 +
 arch/mips/generic/board-ranchu.c                   |  92 ++++++++++++++
 drivers/irqchip/Kconfig                            |   8 ++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-goldfish-pic.c                 | 139 +++++++++++++++++++++
 9 files changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
 create mode 100644 arch/mips/configs/generic/board-ranchu.config
 create mode 100644 arch/mips/generic/board-ranchu.c
 create mode 100644 drivers/irqchip/irq-goldfish-pic.c

--
2.7.4
