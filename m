Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 17:03:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36034 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011683AbcBCQDUzmQFQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 17:03:20 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 6E46394F5AEE1;
        Wed,  3 Feb 2016 16:03:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 16:03:12 +0000
Received: from localhost (10.100.200.164) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 16:03:11 +0000
Date:   Wed, 3 Feb 2016 16:03:11 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Phil Edworthy" <phil.edworthy@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Joshua Kinard" <kumba@gentoo.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Jiri Slaby" <jslaby@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Zubair Lutfullah Kakakhel" <Zubair.Kakakhel@imgtec.com>,
        Kumar Gala <galak@codeaurora.org>,
        Yijing Wang <wangyijing@huawei.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        "John Crispin" <blogic@openwrt.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        "Russell Joyce" <russell.joyce@york.ac.uk>,
        Scott Branden <sbranden@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Pawel Moll <pawel.moll@arm.com>, <linux-pci@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ley Foon Tan <lftan@altera.com>,
        <devicetree@vger.kernel.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        "Rob Herring" <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Jens Axboe <axboe@fb.com>, Duc Dang <dhdang@apm.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vinod Koul <vinod.koul@intel.com>,
        "Gabriele Paoloni" <gabriele.paoloni@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Perches <joe@perches.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "Yinghai Lu" <yinghai@kernel.org>, <dmaengine@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "Ravikiran Gummaluri" <rgummal@xilinx.com>
Subject: Re: [PATCH v2 00/15] MIPS Boston board support
Message-ID: <20160203160311.GD30470@NP-P-BURTON>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
 <56B1F40E.3090607@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <56B1F40E.3090607@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.164]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51697
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

On Wed, Feb 03, 2016 at 01:35:26PM +0100, Michal Simek wrote:
> On 3.2.2016 12:30, Paul Burton wrote:
> > This series introduces support for the Imagination Technologies MIPS
> > Boston development board. Boston is an FPGA-based development board
> > akin to the much older Malta board, built around a Xilinx FPGA running
> > a MIPS CPU & other logic including a PCIe root port connected to an
> > Intel EG20T Platform Controller Hub. This provides a base set of
> > peripherals including SATA, USB, SD/MMC, ethernet, I2C & GPIOs. PCIe
> > slots are also present for expansion.
> > 
> > v2 of this series splits out the pch_gbe ethernet driver changes to a
> > separate series, but keeps the Xilinx PCIe driver changes since PCIe is
> > so central to the Boston board & the series has shrunk somewhat since
> > its earlier submission.
> > 
> > Applies atop v4.5-rc2.
> > 
> > Paul Burton (15):
> >   dt-bindings: ascii-lcd: Document a binding for simple ASCII LCDs
> >   auxdisplay: driver for simple memory mapped ASCII LCD displays
> >   MIPS: PCI: Compatibility with ARM-like PCI host drivers
> >   PCI: xilinx: Keep references to both IRQ domains
> >   PCI: xilinx: Unify INTx & MSI interrupt FIFO decode
> >   PCI: xilinx: Always clear interrupt decode register
> >   PCI: xilinx: Clear interrupt FIFO during probe
> >   PCI: xilinx: Fix INTX irq dispatch
> >   PCI: xilinx: Allow build on MIPS platforms
> >   misc: pch_phub: Allow build on MIPS platforms
> >   dmaengine: pch_dma: Allow build on MIPS platforms
> >   ptp: pch: Allow build on MIPS platforms
> >   MIPS: Support for generating FIT (.itb) images
> >   dt-bindings: mips: img,boston: Document img,boston binding
> >   MIPS: Boston board support
> > 
> >  Documentation/devicetree/bindings/ascii-lcd.txt    |  10 +
> >  .../devicetree/bindings/mips/img/boston.txt        |  15 ++
> >  MAINTAINERS                                        |  14 ++
> >  arch/mips/Kbuild.platforms                         |   1 +
> >  arch/mips/Kconfig                                  |  48 +++++
> >  arch/mips/Makefile                                 |   6 +-
> >  arch/mips/boot/Makefile                            |  61 ++++++
> >  arch/mips/boot/dts/Makefile                        |   1 +
> >  arch/mips/boot/dts/img/Makefile                    |   7 +
> >  arch/mips/boot/dts/img/boston.dts                  | 204 ++++++++++++++++++
> >  arch/mips/boot/skeleton.its                        |  24 +++
> >  arch/mips/boston/Makefile                          |  12 ++
> >  arch/mips/boston/Platform                          |   8 +
> >  arch/mips/boston/init.c                            | 106 ++++++++++
> >  arch/mips/boston/int.c                             |  33 +++
> >  arch/mips/boston/time.c                            |  89 ++++++++
> >  arch/mips/boston/vmlinux.its                       |  23 ++
> >  arch/mips/configs/boston_defconfig                 | 173 +++++++++++++++
> >  .../asm/mach-boston/cpu-feature-overrides.h        |  26 +++
> >  arch/mips/include/asm/mach-boston/irq.h            |  18 ++
> >  arch/mips/include/asm/mach-boston/spaces.h         |  20 ++
> >  arch/mips/include/asm/pci.h                        |  67 +++++-
> >  arch/mips/lib/iomap-pci.c                          |   2 +-
> >  arch/mips/pci/Makefile                             |   6 +
> >  arch/mips/pci/pci-generic.c                        | 138 ++++++++++++
> >  arch/mips/pci/pci-legacy.c                         | 232 +++++++++++++++++++++
> >  arch/mips/pci/pci.c                                | 226 +-------------------
> >  drivers/auxdisplay/Kconfig                         |   7 +
> >  drivers/auxdisplay/Makefile                        |   1 +
> >  drivers/auxdisplay/ascii-lcd.c                     | 230 ++++++++++++++++++++
> >  drivers/dma/Kconfig                                |   2 +-
> >  drivers/misc/Kconfig                               |   2 +-
> >  drivers/pci/host/Kconfig                           |   2 +-
> >  drivers/pci/host/pcie-xilinx.c                     | 125 ++++++-----
> >  drivers/ptp/Kconfig                                |   2 +-
> >  35 files changed, 1649 insertions(+), 292 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/ascii-lcd.txt
> >  create mode 100644 Documentation/devicetree/bindings/mips/img/boston.txt
> >  create mode 100644 arch/mips/boot/dts/img/Makefile
> >  create mode 100644 arch/mips/boot/dts/img/boston.dts
> >  create mode 100644 arch/mips/boot/skeleton.its
> >  create mode 100644 arch/mips/boston/Makefile
> >  create mode 100644 arch/mips/boston/Platform
> >  create mode 100644 arch/mips/boston/init.c
> >  create mode 100644 arch/mips/boston/int.c
> >  create mode 100644 arch/mips/boston/time.c
> >  create mode 100644 arch/mips/boston/vmlinux.its
> >  create mode 100644 arch/mips/configs/boston_defconfig
> >  create mode 100644 arch/mips/include/asm/mach-boston/cpu-feature-overrides.h
> >  create mode 100644 arch/mips/include/asm/mach-boston/irq.h
> >  create mode 100644 arch/mips/include/asm/mach-boston/spaces.h
> >  create mode 100644 arch/mips/pci/pci-generic.c
> >  create mode 100644 arch/mips/pci/pci-legacy.c
> >  create mode 100644 drivers/auxdisplay/ascii-lcd.c
> > 
> 

Hi Michal,

On Wed, Feb 03, 2016 at 01:35:26PM +0100, Michal Simek wrote:
> These patches are targeting different subsystems and should go to the
> tree via different maintainers

Not necessarily, for example the dmaengine & ptp patches both received
acks last time they were posted - presumably with the intent that Ralf
can merge them through the MIPS tree.

On Wed, Feb 03, 2016 at 01:35:26PM +0100, Michal Simek wrote:
> that's why please split them to sensible pieces and send them separately.

I could split out the Xilinx PCIe changes if it's insisted upon, but:

  - They are the motivation for what's probably the largest of the MIPS
    patches, so it's good to see those changes in context.

  - The Boston board is very heavily PCIe based, with all peripherals
    apart from a single UART & an 8 character LCD display being accessed
    via PCIe. Thus Boston is pretty useless without the Xilinx PCIe
    driver.

  - Each patch is only CC'd to people who should be relevant to it
    anyway (using the patman tool), so it's not like the MIPS changes
    are spamming people only interested in PCI.

  - 15 patches really isn't all that many.

So I think there is value in keeping the remainder of this series
together. I already split out the fairly standalone ethernet driver
changes. I certainly think saying this approach isn't sensible is a
stretch.

> For pcie-xilinx.c changes please add to CC Bharat Kumar Gogada
> <bharatku@xilinx.com> and Ravikiran Gummaluri <rgummal@xilinx.com>.
> They have patches for pcie-xilinx and I expect there will be some sort
> of collision.

I'll CC them if there's another revision, but if they should be CC'd for
changes to this driver is there a reason they're not in MAINTAINERS?
That would lead to tools like patman automatically CC'ing them, which
makes tons more sense than people needing to be informed after
submitting patches that they should CC some random extra email
addresses.

Thanks,
    Paul

> Thanks,
> Michal
> 
> 
