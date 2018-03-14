Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 16:54:07 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58882 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991128AbeCNPx7kt6lD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2018 16:53:59 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5092F1596;
        Wed, 14 Mar 2018 08:53:52 -0700 (PDT)
Received: from [10.1.207.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9F3F3F53D;
        Wed, 14 Mar 2018 08:53:47 -0700 (PDT)
Subject: Re: [PATCH 0/6] irqchip/mips-gic: Enable & use VEIC mode if available
To:     James Hogan <jhogan@kernel.org>
Cc:     Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
 <c9b5d20c-7adf-5308-1a45-21471d206d10@arm.com>
 <20180314154641.GA8976@saruman>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <bf5ab15a-1151-1163-e139-a3657614d0fd@arm.com>
Date:   Wed, 14 Mar 2018 15:53:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314154641.GA8976@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62976
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

On 14/03/18 15:46, James Hogan wrote:
> On Wed, Mar 14, 2018 at 11:15:47AM +0000, Marc Zyngier wrote:
>> Hi Matt,
>> 
>> On 05/01/18 10:31, Matt Redfearn wrote:
>>> 
>>> This series enables the MIPS GIC driver to make use of the EIC
>>> mode supported in some MIPS cores. In this mode, the cores 6
>>> interrupt lines are switched to represent a vector number,
>>> 0..63. Currently all GIC interrupts are routed to a single CPU
>>> interrupt pin, but this is inefficient since we end up checking
>>> both local and shared interrupt flag registers for both local
>>> and shared interrupts. This introduces additional latency into
>>> the interrupt paths. With EIC mode this can be improved by
>>> using separate vectors for local and shared interrupts.
>>> 
>>> This series is based on 4.15-rc6 and has been tested on Boston,
>>> Malta & SEAD3 MIPS platforms implementing a GIC with and
>>> without EIC mode supported in hardware.
>> 
>> What the status of this series?
> 
> FYI I've been meaning to test it with KVM, since host EIC I think
> will affect KVM & guest stuff.

OK. I'll park that until I hear from you guys.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
