Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2011 11:13:26 +0200 (CEST)
Received: from mprc.pku.edu.cn ([162.105.203.9]:52881 "EHLO mprc.pku.edu.cn"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491068Ab1FMJNU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jun 2011 11:13:20 +0200
Received: from [192.168.0.106] ([162.105.80.111])
        (authenticated bits=0)
        by mprc.pku.edu.cn (8.13.8/8.13.8) with ESMTP id p5D995YN010394;
        Mon, 13 Jun 2011 17:09:08 +0800
Subject: Re: [PATCH] PCI: Make the struct pci_dev * argument of
 pci_fixup_irqs const.
From:   Guan Xuetao <gxt@mprc.pku.edu.cn>
Reply-To: gxt@mprc.pku.edu.cn
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
        Anton Vorontsov <avorontsov@mvista.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Colin Cross <ccross@android.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Miao <eric.y.miao@gmail.com>,
        Erik Gilling <konkers@android.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Imre Kaloz <kaloz@openwrt.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Krzysztof Halasa <khc@pm.waw.pl>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Matt Turner <mattst88@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Olof Johansson <olof@lixom.net>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
In-Reply-To: <20110610143021.GA26043@linux-mips.org>
References: <20110610143021.GA26043@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: MPRC, PKU
Date:   Mon, 13 Jun 2011 17:00:44 +0800
Message-ID: <1307955644.1878.5.camel@epip-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gxt@mprc.pku.edu.cn
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10464

On Fri, 2011-06-10 at 15:30 +0100, Ralf Baechle wrote:
> Aside of the usual motivation for constification,  this function has a
> history of being abused a hook for interrupt and other fixups so I turned
> this function const ages ago in the MIPS code but it should be done
> treewide.
> 
> Due to function pointer passing in varous places a few other functions
> had to be constified as well.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> To: Anton Vorontsov <avorontsov@mvista.com>
> To: Chris Metcalf <cmetcalf@tilera.com>
> To: Colin Cross <ccross@android.com>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Miao <eric.y.miao@gmail.com>
> To: Erik Gilling <konkers@android.com>
> To: Guan Xuetao <gxt@mprc.pku.edu.cn>
> To: "H. Peter Anvin" <hpa@zytor.com>
> To: Imre Kaloz <kaloz@openwrt.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> To: Jesse Barnes <jbarnes@virtuousgeek.org>
> To: Krzysztof Halasa <khc@pm.waw.pl>
> To: Lennert Buytenhek <kernel@wantstofly.org>
> To: Matt Turner <mattst88@gmail.com>
> To: Nicolas Pitre <nico@fluxnic.net>
> To: Olof Johansson <olof@lixom.net>
> To: Paul Mundt <lethal@linux-sh.org>
> To: Richard Henderson <rth@twiddle.net>
> To: Russell King <linux@arm.linux.org.uk>
> To: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: x86@kernel.org
> ---
For UniCore32 related codes:
Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
