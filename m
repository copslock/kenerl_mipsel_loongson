Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 16:59:19 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:59461 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011906AbcBYP7Q26HpV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 16:59:16 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 8B3292034C;
        Thu, 25 Feb 2016 15:59:13 +0000 (UTC)
Received: from localhost (unknown [150.199.177.227])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD66C20253;
        Thu, 25 Feb 2016 15:59:12 +0000 (UTC)
Date:   Thu, 25 Feb 2016 09:59:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Ley Foon Tan <lftan@altera.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        Scott Branden <sbranden@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Duc Dang <dhdang@apm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 0/6] Xilinx AXI PCIe Host Bridge driver fixes
Message-ID: <20160225155911.GF8120@localhost>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helgaas@kernel.org
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

Hi Paul,

On Thu, Feb 04, 2016 at 04:10:07PM +0000, Paul Burton wrote:
> This series fixes a number of issues found using the Xilinx AXI PCIe
> Host Bridge IP on the Imagination Technologies MIPS Boston development
> board. It has been split out of the larger Boston board support series
> at Michal's request.
> 
> Applies atop v4.5-rc2.
> 
> Paul Burton (6):
>   PCI: xilinx: Keep references to both IRQ domains
>   PCI: xilinx: Unify INTx & MSI interrupt FIFO decode
>   PCI: xilinx: Always clear interrupt decode register
>   PCI: xilinx: Clear interrupt FIFO during probe
>   PCI: xilinx: Fix INTX irq dispatch
>   PCI: xilinx: Allow build on MIPS platforms
> 
>  drivers/pci/host/Kconfig       |   2 +-
>  drivers/pci/host/pcie-xilinx.c | 125 +++++++++++++++++++----------------------

Looks like Bharat has some IRQ concerns, so I'm guessing you'll be
posting a v4?

Bjorn
