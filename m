Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 12:45:46 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:33853 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013019AbbKVLpohtzcw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 12:45:44 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81C0049;
        Sun, 22 Nov 2015 03:45:20 -0800 (PST)
Received: from localhost (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B61A83F2E5;
        Sun, 22 Nov 2015 03:45:35 -0800 (PST)
Date:   Sun, 22 Nov 2015 11:45:30 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 02/14] irqchip: irq-pic32-evic: Add support for PIC32
 interrupt controller
Message-ID: <20151122114530.10bca210@arm.com>
In-Reply-To: <1448065205-15762-3-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
        <1448065205-15762-3-git-send-email-joshua.henderson@microchip.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50037
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

On Fri, 20 Nov 2015 17:17:14 -0700
Joshua Henderson <joshua.henderson@microchip.com> wrote:

Joshua, Cristian,

> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> This adds support for the EVIC present on a PIC32MZDA.
> 
> The following features are supported:
>  - DT properties for EVIC and for devices that use interrupt lines
>  - persistent and non-persistent interrupt handling
>  - Priority, sub-priority and polariy settings for each interrupt line
>  - irqdomain support
> 

I haven't reviewed the code yet, but the fact that you allow (and
actually request) the interrupt priorities to be encoded in the DT
raises some concerns:

- Aren't priorities entirely under software control (and hence don't
  belong in DT)?
- More crucially, how do you deal with nested interrupts when you have
  interrupts running at different priorities? Most parts of Linux
  cannot cope with that without additional support.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
