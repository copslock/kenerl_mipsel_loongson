Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 15:53:38 +0100 (CET)
Received: from ns.iliad.fr ([212.27.33.1]:57116 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008429AbbCPOxg0jNbK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Mar 2015 15:53:36 +0100
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id C179220403;
        Mon, 16 Mar 2015 15:53:36 +0100 (CET)
Received: from [192.168.108.17] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id B65B720096;
        Mon, 16 Mar 2015 15:53:36 +0100 (CET)
Message-ID: <1426517616.25162.24.camel@sakura.staff.proxad.net>
Subject: Re: [PATCH] MIPS: bcm63xx: move bcm63xx_gpio_init() to
 bcm63xx_register_devices().
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Nicolas Schichan <nschichan@freebox.fr>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>
Date:   Mon, 16 Mar 2015 15:53:36 +0100
In-Reply-To: <1426176058-26114-1-git-send-email-nschichan@freebox.fr>
References: <1426176058-26114-1-git-send-email-nschichan@freebox.fr>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Mar 16 15:53:36 2015 +0100 (CET)
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
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


On Thu, 2015-03-12 at 17:00 +0100, Nicolas Schichan wrote:

> When called from prom init code, bcm63xx_gpio_init() will fail as it
> will call gpiochip_add() which relies on a working kmalloc() to alloc
> the gpio_desc array and kmalloc is not useable yet at prom init time.
> 
> Move bcm63xx_gpio_init() to bcm63xx_register_devices() (an
> arch_initcall) where kmalloc works.

no that patch is completely bogus:

1) bcm63xx_gpio_init() does more than registering the gpio_chip: look at
bcm63xx_gpio_out_low_reg_init().

We want at least the low lever helpers bcm_gpio_readl()/writel() to work
early.

2) look at board_register_devices() in board_bcm963xx.c, it uses the
gpio API, but is called during arch_initcall() (there was an attempt to
move it later, but it has been reverted)

so you cannot move that gpiochip registration later as-is, more
refactoring and *testing* is required.

-- 
Maxime
