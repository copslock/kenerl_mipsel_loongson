Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2011 06:28:00 +0200 (CEST)
Received: from linux-sh.org ([111.68.239.195]:45657 "EHLO linux-sh.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490946Ab1FME1y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jun 2011 06:27:54 +0200
Received: from linux-sh.org (localhost.localdomain [127.0.0.1])
        by linux-sh.org (8.14.4/8.14.4) with ESMTP id p5D4Oah7016184;
        Mon, 13 Jun 2011 13:24:36 +0900
Received: (from pmundt@localhost)
        by linux-sh.org (8.14.4/8.14.4/Submit) id p5D4OAHE009396;
        Mon, 13 Jun 2011 13:24:10 +0900
X-Authentication-Warning: linux-sh.org: pmundt set sender to lethal@linux-sh.org using -f
Date:   Mon, 13 Jun 2011 13:24:10 +0900
From:   Paul Mundt <lethal@linux-sh.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
        Anton Vorontsov <avorontsov@mvista.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Colin Cross <ccross@android.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Miao <eric.y.miao@gmail.com>,
        Erik Gilling <konkers@android.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "H. Peter Anvin" <hpa@zytor.com>, Imre Kaloz <kaloz@openwrt.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Krzysztof Halasa <khc@pm.waw.pl>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Matt Turner <mattst88@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Olof Johansson <olof@lixom.net>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] PCI: Make the struct pci_dev * argument of pci_fixup_irqs const.
Message-ID: <20110613042410.GB29731@linux-sh.org>
References: <20110610143021.GA26043@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110610143021.GA26043@linux-mips.org>
User-Agent: Mutt/1.4.1i
X-archive-position: 30362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10382

On Fri, Jun 10, 2011 at 03:30:21PM +0100, Ralf Baechle wrote:
> Aside of the usual motivation for constification,  this function has a
> history of being abused a hook for interrupt and other fixups so I turned
> this function const ages ago in the MIPS code but it should be done
> treewide.
> 
> Due to function pointer passing in varous places a few other functions
> had to be constified as well.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Paul Mundt <lethal@linux-sh.org>
