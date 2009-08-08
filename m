Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2009 13:10:00 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35056 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492914AbZHHLJx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Aug 2009 13:09:53 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n78BAUKZ021563;
	Sat, 8 Aug 2009 12:10:30 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n78BATIq021560;
	Sat, 8 Aug 2009 12:10:29 +0100
Date:	Sat, 8 Aug 2009 12:10:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH] bcm63xx: fix build failures when CONFIG_PCI is disabled
Message-ID: <20090808111029.GA14596@linux-mips.org>
References: <200908042214.39866.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908042214.39866.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 04, 2009 at 10:14:39PM +0200, Florian Fainelli wrote:

> This patch fixes multiple build failures when CONFIG_PCI
> is disabled. Since bcm63xx_sprom depends on CONFIG_SSB_PCIHOST
> to be set, which depends on CONFIG_PCI, bcm63xx_sprom
> would be unused thus causing this direct warning treated
> as an error:
> 
> cc1: warnings being treated as errors
> arch/mips/bcm63xx/boards/board_bcm963xx.c:466: warning: 'bcm63xx_sprom' defined but not used
> 
> Then bcm63xx_pci_enabled would not be resolved since it
> is declared in arch/mips/pci/pci-bcm63xx.c which is not
> compiled due to CONFIG_PCI being disabled. Finally,
> ssb_set_arch_fallback would not be resolved too, since
> CONFIG_SSB_PCIHOST is disabled.

Thanks.  Folded into "MIPS: BCM63XX: Add board support code."

  Ralf
