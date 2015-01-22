Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 22:04:03 +0100 (CET)
Received: from mail-oi0-f45.google.com ([209.85.218.45]:43866 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011835AbbAVVEBgCNSw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2015 22:04:01 +0100
Received: by mail-oi0-f45.google.com with SMTP id g201so3456501oib.4
        for <linux-mips@linux-mips.org>; Thu, 22 Jan 2015 13:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mCn6001ZYk4DQd1OdFkWv2AofNFhiQybcJZU2uKNupI=;
        b=Z7gyl830XvwcZEai1BkTwsHktehR3dJGNrTdla5mdCQp8I41kDKoRsl9tF7g6Pwc9w
         X0BiK3VXhZECjYRXY+jbCX0qDWkecbSkifSzQ2yNQmaS0Ecut4nsuC4ZGH0U8mw9bQ9B
         c8jwi/FjtrkzRSf/p7HZX50ydcnY58s72E7sgrgvP7AdMy/Io4l73Bkg1gpJsj4iHglt
         QY15DW/DSQJonyP3Us5QLbx3Dzx79F1JXzuK/00mzV0GeAZwf7HVd3h0+UGTnlT5IMEI
         OEgWs5aZ9YaacWG2wvqj1kWuDm2WN+Zl7WJWqvhp+IuxL+6GqEyeTUjkDFkYuMMC/3+S
         Lspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mCn6001ZYk4DQd1OdFkWv2AofNFhiQybcJZU2uKNupI=;
        b=ONBmZpp3knnmkRzeZqICuPr4fZmQxIHUKDAjK+s9blLmLpCWoa3Q/xs7g98feiLxTx
         glMFreBX7ZilgX/RgvKlO5du3O4NxxefaLLZINBJ7gXsgxjzUBVOi5h8PsW53um51UG0
         LEOgVf/XsbFxc1Whcu7ApOFznNbeOE0krD011Ed57h1/es2/zvb1M106cmQB7OKKJeCO
         5HOdBb7h6VDZ6OHVIADTgmGSQhIFTa8TS26i5qP3EdTgHFmGyuN+aMhQ3o31CaxZh5rd
         2m2Y3D+/srHtrk08u/9udqN/KCkbcpGxL/YGB7/kFc6UiZnh9gX0BBGwWvCR3H9KP61i
         L7Vw==
X-Gm-Message-State: ALoCoQl6UXynLnFuAY8IyCzRzkBWPrgr+IV0NNbwIYhsu9ykBibT/gFjIB8mNMHyB7GEp36k8fOz
X-Received: by 10.202.59.136 with SMTP id i130mr2090559oia.114.1421960635600;
        Thu, 22 Jan 2015 13:03:55 -0800 (PST)
Received: from google.com ([69.71.1.1])
        by mx.google.com with ESMTPSA id t8sm7489840obv.22.2015.01.22.13.03.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 Jan 2015 13:03:54 -0800 (PST)
Date:   Thu, 22 Jan 2015 15:03:44 -0600
From:   Bjorn Helgaas <bhelgaas@google.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Howells <dhowells@redhat.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        Simon Horman <horms@verge.net.au>,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        cbe-oss-dev@lists.ozlabs.org, linux-am33-list@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 00/16] PCI generic configuration space accessors
Message-ID: <20150122210344.GE13072@google.com>
References: <1420857290-8373-1-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1420857290-8373-1-git-send-email-robh@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Fri, Jan 09, 2015 at 08:34:34PM -0600, Rob Herring wrote:
> This series adds common accessor functions for PCI configuration space
> accesses. This supports most PCI hosts with memory mapped configuration
> space like ECAM or hosts with memory mapped address/data registers. ECAM
> is not generically supported by this series, but could be added on top
> of this. While some hosts have standard address decoding which could be 
> common as well, the various checks on bus numbers and device numbers are 
> quite varied. It is unclear how much of that is really necessary or 
> could be common. 
> 
> The first 4 patches are preparatory cleanup. Patch 5 introduces the
> common accessors. The remaining patches convert several PCI host
> controllers. This is in no way a complete list of host controllers. The
> conversion of more hosts should be possible. The Designware controller
> in particular should be able to be converted, but its config space
> accessors are a mess of override-able functions that I've not gotten my
> head around.
> 
> This series is available here [1].
> 
> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-config-access
> 
> Rob Herring (16):
>   frv: add struct pci_ops member names to initialization
>   mips: add struct pci_ops member names to initialization
>   mn10300: add struct pci_ops member names to initialization
>   powerpc: add struct pci_ops member names to initialization
>   pci: introduce common pci config space accessors
>   ARM: cns3xxx: convert PCI to use generic config accesses
>   ARM: integrator: convert PCI to use generic config accesses
>   ARM: sa1100: convert PCI to use generic config accesses
>   ARM: ks8695: convert PCI to use generic config accesses
>   powerpc: fsl_pci: convert PCI to use generic config accesses
>   powerpc: powermac: convert PCI to use generic config accesses
>   pci/host: generic: convert to use generic config accesses
>   pci/host: rcar-gen2: convert to use generic config accesses
>   pci/host: tegra: convert to use generic config accesses
>   pci/host: xgene: convert to use generic config accesses
>   pci/host: xilinx: convert to use generic config accesses
> 
>  arch/arm/mach-cns3xxx/pcie.c                   |  52 ++----
>  arch/arm/mach-integrator/pci_v3.c              |  61 +-------
>  arch/arm/mach-ks8695/pci.c                     |  77 +--------
>  arch/arm/mach-sa1100/pci-nanoengine.c          |  94 +----------
>  arch/frv/mb93090-mb00/pci-vdk.c                |   4 +-
>  arch/mips/pci/pci-bcm1480.c                    |   4 +-
>  arch/mips/pci/pci-octeon.c                     |   4 +-
>  arch/mips/pci/pcie-octeon.c                    |  12 +-
>  arch/mn10300/unit-asb2305/pci.c                |   4 +-
>  arch/powerpc/platforms/cell/celleb_scc_pciex.c |   4 +-
>  arch/powerpc/platforms/powermac/pci.c          | 209 +++++--------------------
>  arch/powerpc/sysdev/fsl_pci.c                  |  46 +-----
>  drivers/pci/access.c                           |  87 ++++++++++
>  drivers/pci/host/pci-host-generic.c            |  51 +-----
>  drivers/pci/host/pci-rcar-gen2.c               |  51 +-----
>  drivers/pci/host/pci-tegra.c                   |  55 +------
>  drivers/pci/host/pci-xgene.c                   | 150 ++----------------
>  drivers/pci/host/pcie-xilinx.c                 |  88 ++---------
>  include/linux/pci.h                            |  11 ++
>  19 files changed, 212 insertions(+), 852 deletions(-)

Really nice cleanups.  I added these with the acks so far to a pci/config
branch for v3.20.  I'll update it with more acks if they trickle in.

You've structured it nicely so I can also just drop individual arch pieces
if necessary.  The pieces that haven't been acked yet (hint, hint):

    arch/arm/mach-cns3xxx/pcie.c
    arch/arm/mach-sa1100/pci-nanoengine.c
    arch/mn10300/unit-asb2305/pci.c
    arch/powerpc

In addition, nobody has acked the frv and mips parts, but they're trivial
(they only add struct member names) that I can apply them without worrying.

Bjorn
