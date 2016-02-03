Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 13:35:58 +0100 (CET)
Received: from mail-cys01nam02on0067.outbound.protection.outlook.com ([104.47.37.67]:57182
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011748AbcBCMfyOjiOE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2016 13:35:54 +0100
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (10.152.74.56) by CY1NAM02HT029.eop-nam02.prod.protection.outlook.com
 (10.152.75.100) with Microsoft SMTP Server (TLS) id 15.1.355.15; Wed, 3 Feb
 2016 12:35:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (TLS) id 15.1.409.7 via Frontend Transport; Wed, 3 Feb 2016 12:35:43
 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1aQwes-0000L2-D5; Wed, 03 Feb 2016 04:35:42 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1aQwes-0003Mu-84; Wed, 03 Feb 2016 04:35:42 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u13CZdda011651;
        Wed, 3 Feb 2016 04:35:39 -0800
Received: from [172.30.17.110]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1aQweo-0003Kc-R1; Wed, 03 Feb 2016 04:35:39 -0800
Subject: Re: [PATCH v2 00/15] MIPS Boston board support
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
CC:     Phil Edworthy <phil.edworthy@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Joshua Kinard <kumba@gentoo.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Kumar Gala <galak@codeaurora.org>,
        Yijing Wang <wangyijing@huawei.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Rob Herring" <robh+dt@kernel.org>,
        John Crispin <blogic@openwrt.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>,
        "Richard Cochran" <richardcochran@gmail.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Kalle Valo" <kvalo@codeaurora.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Scott Branden <sbranden@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Pawel Moll <pawel.moll@arm.com>, <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
From:   Michal Simek <michal.simek@xilinx.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <56B1F40E.3090607@xilinx.com>
Date:   Wed, 3 Feb 2016 13:35:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22108.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(2980300002)(438002)(199003)(24454002)(164054003)(189002)(19580395003)(4326007)(11100500001)(2906002)(87936001)(54356999)(76176999)(230700001)(107886002)(36756003)(4001430100002)(50986999)(65806001)(77096005)(2950100001)(65816999)(1096002)(5001770100001)(33656002)(50466002)(65956001)(19580405001)(5001960100002)(83506001)(4001350100001)(36386004)(47776003)(1220700001)(189998001)(87266999)(23746002)(106466001)(59896002)(92566002)(86362001)(63266004)(5008740100001)(586003)(6806005)(7059030)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1NAM02HT029;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;MLV:sfv;A:1;MX:1;LANG:en;
X-MS-Office365-Filtering-Correlation-Id: 10644a10-a991-44b0-6526-08d32c9689d7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:CY1NAM02HT029;
X-Microsoft-Antispam-PRVS: <5810416e321a4c64bc29d7dc71452582@CY1NAM02HT029.eop-nam02.prod.protection.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(13024025)(13023025)(8121501046)(13018025)(13017025)(13015025)(5005006)(10201501046)(3002001);SRVR:CY1NAM02HT029;BCL:0;PCL:0;RULEID:;SRVR:CY1NAM02HT029;
X-Forefront-PRVS: 08417837C5
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2016 12:35:43.1483
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1NAM02HT029
Return-Path: <michal.simek@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michal.simek@xilinx.com
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

On 3.2.2016 12:30, Paul Burton wrote:
> This series introduces support for the Imagination Technologies MIPS
> Boston development board. Boston is an FPGA-based development board
> akin to the much older Malta board, built around a Xilinx FPGA running
> a MIPS CPU & other logic including a PCIe root port connected to an
> Intel EG20T Platform Controller Hub. This provides a base set of
> peripherals including SATA, USB, SD/MMC, ethernet, I2C & GPIOs. PCIe
> slots are also present for expansion.
> 
> v2 of this series splits out the pch_gbe ethernet driver changes to a
> separate series, but keeps the Xilinx PCIe driver changes since PCIe is
> so central to the Boston board & the series has shrunk somewhat since
> its earlier submission.
> 
> Applies atop v4.5-rc2.
> 
> Paul Burton (15):
>   dt-bindings: ascii-lcd: Document a binding for simple ASCII LCDs
>   auxdisplay: driver for simple memory mapped ASCII LCD displays
>   MIPS: PCI: Compatibility with ARM-like PCI host drivers
>   PCI: xilinx: Keep references to both IRQ domains
>   PCI: xilinx: Unify INTx & MSI interrupt FIFO decode
>   PCI: xilinx: Always clear interrupt decode register
>   PCI: xilinx: Clear interrupt FIFO during probe
>   PCI: xilinx: Fix INTX irq dispatch
>   PCI: xilinx: Allow build on MIPS platforms
>   misc: pch_phub: Allow build on MIPS platforms
>   dmaengine: pch_dma: Allow build on MIPS platforms
>   ptp: pch: Allow build on MIPS platforms
>   MIPS: Support for generating FIT (.itb) images
>   dt-bindings: mips: img,boston: Document img,boston binding
>   MIPS: Boston board support
> 
>  Documentation/devicetree/bindings/ascii-lcd.txt    |  10 +
>  .../devicetree/bindings/mips/img/boston.txt        |  15 ++
>  MAINTAINERS                                        |  14 ++
>  arch/mips/Kbuild.platforms                         |   1 +
>  arch/mips/Kconfig                                  |  48 +++++
>  arch/mips/Makefile                                 |   6 +-
>  arch/mips/boot/Makefile                            |  61 ++++++
>  arch/mips/boot/dts/Makefile                        |   1 +
>  arch/mips/boot/dts/img/Makefile                    |   7 +
>  arch/mips/boot/dts/img/boston.dts                  | 204 ++++++++++++++++++
>  arch/mips/boot/skeleton.its                        |  24 +++
>  arch/mips/boston/Makefile                          |  12 ++
>  arch/mips/boston/Platform                          |   8 +
>  arch/mips/boston/init.c                            | 106 ++++++++++
>  arch/mips/boston/int.c                             |  33 +++
>  arch/mips/boston/time.c                            |  89 ++++++++
>  arch/mips/boston/vmlinux.its                       |  23 ++
>  arch/mips/configs/boston_defconfig                 | 173 +++++++++++++++
>  .../asm/mach-boston/cpu-feature-overrides.h        |  26 +++
>  arch/mips/include/asm/mach-boston/irq.h            |  18 ++
>  arch/mips/include/asm/mach-boston/spaces.h         |  20 ++
>  arch/mips/include/asm/pci.h                        |  67 +++++-
>  arch/mips/lib/iomap-pci.c                          |   2 +-
>  arch/mips/pci/Makefile                             |   6 +
>  arch/mips/pci/pci-generic.c                        | 138 ++++++++++++
>  arch/mips/pci/pci-legacy.c                         | 232 +++++++++++++++++++++
>  arch/mips/pci/pci.c                                | 226 +-------------------
>  drivers/auxdisplay/Kconfig                         |   7 +
>  drivers/auxdisplay/Makefile                        |   1 +
>  drivers/auxdisplay/ascii-lcd.c                     | 230 ++++++++++++++++++++
>  drivers/dma/Kconfig                                |   2 +-
>  drivers/misc/Kconfig                               |   2 +-
>  drivers/pci/host/Kconfig                           |   2 +-
>  drivers/pci/host/pcie-xilinx.c                     | 125 ++++++-----
>  drivers/ptp/Kconfig                                |   2 +-
>  35 files changed, 1649 insertions(+), 292 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ascii-lcd.txt
>  create mode 100644 Documentation/devicetree/bindings/mips/img/boston.txt
>  create mode 100644 arch/mips/boot/dts/img/Makefile
>  create mode 100644 arch/mips/boot/dts/img/boston.dts
>  create mode 100644 arch/mips/boot/skeleton.its
>  create mode 100644 arch/mips/boston/Makefile
>  create mode 100644 arch/mips/boston/Platform
>  create mode 100644 arch/mips/boston/init.c
>  create mode 100644 arch/mips/boston/int.c
>  create mode 100644 arch/mips/boston/time.c
>  create mode 100644 arch/mips/boston/vmlinux.its
>  create mode 100644 arch/mips/configs/boston_defconfig
>  create mode 100644 arch/mips/include/asm/mach-boston/cpu-feature-overrides.h
>  create mode 100644 arch/mips/include/asm/mach-boston/irq.h
>  create mode 100644 arch/mips/include/asm/mach-boston/spaces.h
>  create mode 100644 arch/mips/pci/pci-generic.c
>  create mode 100644 arch/mips/pci/pci-legacy.c
>  create mode 100644 drivers/auxdisplay/ascii-lcd.c
> 

These patches are targeting different subsystems and should go to the
tree via different maintainers that's why please split them to sensible
pieces and send them separately.
For pcie-xilinx.c changes please add to CC Bharat Kumar Gogada
<bharatku@xilinx.com> and Ravikiran Gummaluri <rgummal@xilinx.com>.
They have patches for pcie-xilinx and I expect there will be some sort
of collision.

Thanks,
Michal
