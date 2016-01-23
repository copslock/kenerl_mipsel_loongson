Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 16:02:19 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:41609 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009236AbcAWPCRrbMl5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2016 16:02:17 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50C4649;
        Sat, 23 Jan 2016 07:01:30 -0800 (PST)
Received: from localhost (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 126CB3F21A;
        Sat, 23 Jan 2016 07:02:07 -0800 (PST)
Date:   Sat, 23 Jan 2016 15:02:00 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Alban Bedel <albeu@free.fr>
Cc:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] MIPS: ath79: irq: Move the MISC driver to
 drivers/irqchip
Message-ID: <20160123150200.5bc027a6@arm.com>
In-Reply-To: <1453553867-27003-1-git-send-email-albeu@free.fr>
References: <1453553867-27003-1-git-send-email-albeu@free.fr>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On Sat, 23 Jan 2016 13:57:46 +0100
Alban Bedel <albeu@free.fr> wrote:

> The driver stays the same but the initialization changes a bit.
> For OF boards we now get the memory map from the OF node and use
> a linear mapping instead of the legacy mapping. For legacy boards
> we still use a legacy mapping and just pass down all the parameters
> from the board init code.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
