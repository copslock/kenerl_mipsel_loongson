Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 16:43:34 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011906AbcBYPncmMvEV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 16:43:32 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 4F3D12026C;
        Thu, 25 Feb 2016 15:43:29 +0000 (UTC)
Received: from localhost (173-27-161-33.client.mchsi.com [173.27.161.33])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA13720222;
        Thu, 25 Feb 2016 15:43:27 +0000 (UTC)
Date:   Thu, 25 Feb 2016 09:43:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Rob Herring <robh@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Ley Foon Tan <lftan@altera.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Duc Dang <dhdang@apm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH v3 6/6] PCI: xilinx: Allow build on MIPS platforms
Message-ID: <20160225154326.GE8120@localhost>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
 <1454602213-967-7-git-send-email-paul.burton@imgtec.com>
 <CAL_JsqLRMiJ-0j_PrXSKqf6MrRfyqbDGaiaiEn4rAoFaCNgtKQ@mail.gmail.com>
 <20160204175325.GB31145@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160204175325.GB31145@NP-P-BURTON>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52261
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

On Thu, Feb 04, 2016 at 05:53:25PM +0000, Paul Burton wrote:
> On Thu, Feb 04, 2016 at 11:46:28AM -0600, Rob Herring wrote:
> > On Thu, Feb 4, 2016 at 10:10 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> > > Allow the xilinx-pcie driver to be built on MIPS platforms. This will be
> > > used on the MIPS Boston board.
> > >
> > > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > >
> > > ---
> > >
> > > Changes in v3:
> > > - Split out from Boston patchset.
> > >
> > > Changes in v2: None
> > >
> > >  drivers/pci/host/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > > index 75a6054..0aee193 100644
> > > --- a/drivers/pci/host/Kconfig
> > > +++ b/drivers/pci/host/Kconfig
> > > @@ -81,7 +81,7 @@ config PCI_KEYSTONE
> > >
> > >  config PCIE_XILINX
> > >         bool "Xilinx AXI PCIe host bridge support"
> > > -       depends on ARCH_ZYNQ
> > > +       depends on ARCH_ZYNQ || MIPS
> > 
> > Why don't you just remove the dependency? Then it gets better build coverage.
> > 
> > Rob
> 
> That seems like a call best made by whomever has to maintain this - if
> that's the preferred way to go I'm fine with it.

I'm in favor of removing the dependency if possible.  I guess Michal
would be the person to ack that.

Right now (in my current "next" branch),
drivers/pci/host/pcie-xilinx.c uses struct hw_pci, which is only
defined by arm.

Bjorn
