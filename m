Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 18:53:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17101 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012801AbcBDRxceWLbt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 18:53:32 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id BC2D37F0A6811;
        Thu,  4 Feb 2016 17:53:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 4 Feb 2016 17:53:26 +0000
Received: from localhost (10.100.200.26) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Feb
 2016 17:53:25 +0000
Date:   Thu, 4 Feb 2016 17:53:25 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Rob Herring <robh@kernel.org>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Ravikiran Gummaluri" <rgummal@xilinx.com>,
        Ley Foon Tan <lftan@altera.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Scott Branden <sbranden@broadcom.com>,
        "Stanimir Varbanov" <svarbanov@mm-sol.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Duc Dang <dhdang@apm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>,
        "Hauke Mehrtens" <hauke@hauke-m.de>
Subject: Re: [PATCH v3 6/6] PCI: xilinx: Allow build on MIPS platforms
Message-ID: <20160204175325.GB31145@NP-P-BURTON>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
 <1454602213-967-7-git-send-email-paul.burton@imgtec.com>
 <CAL_JsqLRMiJ-0j_PrXSKqf6MrRfyqbDGaiaiEn4rAoFaCNgtKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLRMiJ-0j_PrXSKqf6MrRfyqbDGaiaiEn4rAoFaCNgtKQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.26]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51790
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

On Thu, Feb 04, 2016 at 11:46:28AM -0600, Rob Herring wrote:
> On Thu, Feb 4, 2016 at 10:10 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> > Allow the xilinx-pcie driver to be built on MIPS platforms. This will be
> > used on the MIPS Boston board.
> >
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >
> > ---
> >
> > Changes in v3:
> > - Split out from Boston patchset.
> >
> > Changes in v2: None
> >
> >  drivers/pci/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index 75a6054..0aee193 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -81,7 +81,7 @@ config PCI_KEYSTONE
> >
> >  config PCIE_XILINX
> >         bool "Xilinx AXI PCIe host bridge support"
> > -       depends on ARCH_ZYNQ
> > +       depends on ARCH_ZYNQ || MIPS
> 
> Why don't you just remove the dependency? Then it gets better build coverage.
> 
> Rob

That seems like a call best made by whomever has to maintain this - if
that's the preferred way to go I'm fine with it.

Thanks,
    Paul
