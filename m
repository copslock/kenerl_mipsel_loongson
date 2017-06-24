Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 11:14:08 +0200 (CEST)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:46580
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992028AbdFXJN7r0JIa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 11:13:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Al1esOrcKjPDHEgtAr36Ac/JwnBGWKM/t9UwE05yei4=;
        b=cCxZJlf0rFH8a8K/IvTCG3W2wrou4u1Duz2kXXdIHblqkr6go0JJG5TEcWN/vm2oemubLZXAE2NpZd83H0y3GUs8QaxOWWxSuPA+aujzc0WKzKAyXrl4No/tdDOqQ8wlvf38A3pj5EoWEkkRaUblR+JI8Z+MvQnHMHM8SbifmrY=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:47383)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1dOh8H-0007JK-Ft; Sat, 24 Jun 2017 10:13:33 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1dOh8C-0005Ij-RS; Sat, 24 Jun 2017 10:13:28 +0100
Date:   Sat, 24 Jun 2017 10:13:28 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, catalin.marinas@arm.com, will.deacon@arm.com,
        geert@linux-m68k.org, ralf@linux-mips.org,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        cmetcalf@mellanox.com, gxt@mprc.pku.edu.cn, bhelgaas@google.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Message-ID: <20170624091328.GY4902@n2100.armlinux.org.uk>
References: <20170623214538.25967-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170623214538.25967-1-palmer@dabbelt.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

On Fri, Jun 23, 2017 at 02:45:38PM -0700, Palmer Dabbelt wrote:
> We wanted to add RISC-V to the list of architectures that used the
> generic PCI setup-irq.o inside the Makefile and it was suggested that
> instead we define a Kconfig entry and use that.
> 
> I've done very minimal testing on this: I just checked to see that
> an aarch64 defconfig still build setup-irq.o with the patch applied.
> The intention is that this patch doesn't change the behavior of any
> build.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Looks fine from an ARM point of view, thanks.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e0cacb7b8563..658c9f95ab3f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -131,6 +131,9 @@ config PCI_HYPERV
>            The PCI device frontend driver allows the kernel to import arbitrary
>            PCI devices from a PCI backend to support PCI driver domains.
>  
> +config PCI_GENERIC_SETUP
> +	def_bool n

	bool

would be sufficient here - the default is 'n' for all options.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
