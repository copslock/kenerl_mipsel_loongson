Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 17:37:13 +0200 (CEST)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:60684
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993072AbeGaPhJiqVqX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2018 17:37:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bjN1alPUQNsU2X5kbQx8rQ0MJm+fR+j1oqWFWHBd+hs=; b=DfJYQtH6O8ZO5DrByYHyXYx7m
        d0dZ2yBuziitTY5Otn9Tpq2Kx/DuAKWMTURtfFCvzXisrHQRKSeQBj7OzPHcMUf251w1/zClKW78c
        6q166r166r7dcFQZcgJA/MICA3fRHqEBohey+skmHPUoXAXg6tn6YhwSdPPmXT9tD+nmQ=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:60992)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fkWhn-0006wL-NY; Tue, 31 Jul 2018 16:36:59 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fkWhl-0007Qh-6y; Tue, 31 Jul 2018 16:36:57 +0100
Date:   Tue, 31 Jul 2018 16:36:55 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Alexei Colin <acolin@isi.edu>
Cc:     Alexandre Bounine <alex.bou9@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 5/6] arm: enable RapidIO menu in Kconfig
Message-ID: <20180731153655.GM17271@n2100.armlinux.org.uk>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-6-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731142954.30345-6-acolin@isi.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65330
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

On Tue, Jul 31, 2018 at 10:29:53AM -0400, Alexei Colin wrote:
> Platforms with a PCI bus will be offered the RapidIO menu since they may
> be want support for a RapidIO PCI device. Platforms without a PCI bus
> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> 
> Tested that kernel builds for ARM with the RapidIO subsystem and switch
> drivers enabled.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: John Paul Walters <jwalters@isi.edu>
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Alexei Colin <acolin@isi.edu>
> ---
>  arch/arm/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index afe350e5e3d9..602a61324890 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1278,6 +1278,8 @@ config PCI_HOST_ITE8152
>  
>  source "drivers/pci/Kconfig"
>  
> +source "drivers/rapidio/Kconfig"
> +
>  source "drivers/pcmcia/Kconfig"

Why not place the new Kconfig file after pcmcia?  That way, it is in
a consistent position wrt architectures such as powerpc, and it is
also in alphabetical order.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
