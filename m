Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2017 10:10:00 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:41538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993892AbdCVJJsdNusU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Mar 2017 10:09:48 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCD62B16;
        Wed, 22 Mar 2017 02:09:41 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15F253F575;
        Wed, 22 Mar 2017 02:09:39 -0700 (PDT)
Subject: Re: [PATCH] Add initial SX3000b platform code to MIPS arch
To:     Amit Kama IL <Amit.Kama@satixfy.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
References: <AM4PR0201MB2179B0EE9D0C00461C999697E43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <68b3b5ff-f03d-61ca-ddb9-0f6038360a88@arm.com>
Date:   Wed, 22 Mar 2017 09:09:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <AM4PR0201MB2179B0EE9D0C00461C999697E43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57413
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

Hi Amit,

On 22/03/17 05:38, Amit Kama IL wrote:
> Add initial support for boards based on Satixfy's SX3000b (Catniss) SoC.
> The SoC includes a MIPS interAptiv dual core 4 VPE processor and boots 
> using device-tree.
> 
> Signed-off-by: Amit Kama <amit.kama@staixfy.com>
> 
> The irqchip file (irq-sx3000b.c) is pertinent to the platform. 
> IRQCHIP maintainers - is it possible to merge this through MIPS tree? 

Can you please send something that is the result of "git format-patch"?
You should have a diff-stat before the patch itself...

Also, this file (irq-sx3000b.c) doesn't seem to be in this huge patch,
which doesn't seem to concern the irqchip subsystem (it all looks
platform code to me). Wrong patch?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
