Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 17:23:20 +0200 (CEST)
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:47415 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992043AbcHOPXBkL0Rf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 17:23:01 +0200
X-MHO-User: 2bb2f200-62fc-11e6-ac92-3142cfe117f2
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.99.77.15
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.99.77.15])
        by outbound1.eu.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Mon, 15 Aug 2016 15:23:08 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 50B7580064;
        Mon, 15 Aug 2016 15:22:50 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 50B7580064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1471274570;
        bh=OQ8kcq+tyh4gLQHetgt2ouIi3FZAPj1XUaL4I65/tWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EJ0N2sx1UbZLXzvs1HZZcRU4QV5gy0A9RIa/GaCUAePVdWEGO7M7Al41JjkdC5WZD
         46N7v9HKXMk6hSfBlGeTyX6GwM0ESmolROVzVfdTRDdTXVVRS2V0NNdrxfwEUJ4OKl
         WuxQZJZR91SdWkGW6mKz2JEhwJPl435Aotx/angPfPknoov03aJmfeh3N8Nv7dJIvR
         FghkYWbnMe8dHrITir8TZpo8opRfC3kFfhl8PAcmTlS4A+KfhlLIQKH8ORak0gHMwy
         Y9pXdrZnNkl5kmBOz2LPQyA7F8lRFKuzH5Y+b3639FhOSbXnWyqcFYk8acBXp6FDxx
         q+3NJ1kyRCn9g==
Date:   Mon, 15 Aug 2016 15:22:50 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        marc.zyngier@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/9] microblaze: irqchip: Move intc driver to irqchip
Message-ID: <20160815152250.GE3353@io.lakedaemon.net>
References: <1471269335-58747-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1471269335-58747-2-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471269335-58747-2-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Hi Zubair,

On Mon, Aug 15, 2016 at 02:55:27PM +0100, Zubair Lutfullah Kakakhel wrote:
> The Xilinx AXI Interrupt Controller IP block is used by the MIPS
> based xilfpga platform.
> 
> Move the interrupt controller code out of arch/microblaze so that
> it can be used by everyone
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> ---
>  arch/microblaze/Kconfig                                       | 1 +
>  arch/microblaze/kernel/Makefile                               | 2 +-
>  drivers/irqchip/Kconfig                                       | 4 ++++
>  drivers/irqchip/Makefile                                      | 1 +
>  arch/microblaze/kernel/intc.c => drivers/irqchip/irq-xilinx.c | 0
>  5 files changed, 7 insertions(+), 1 deletion(-)
>  rename arch/microblaze/kernel/intc.c => drivers/irqchip/irq-xilinx.c (100%)

When you send the next version, please disable rename detection.  The
driver looks pretty straight forward, but I'd like to take the
opportunity to clean up the abstraction around read and write.  As well
as making it easier for everyone to review on-list.

thx,

Jason.
