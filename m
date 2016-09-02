Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 15:31:25 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:55472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990522AbcIBNbSEqhV4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 15:31:18 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CC84A5E;
        Fri,  2 Sep 2016 06:31:11 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7798E3F21A;
        Fri,  2 Sep 2016 06:31:09 -0700 (PDT)
Subject: Re: [Patch v4 01/12] microblaze: irqchip: Move intc driver to irqchip
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Michal Simek <michal.simek@xilinx.com>, monstr@monstr.eu,
        ralf@linux-mips.org, tglx@linutronix.de, jason@lakedaemon.net
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-2-git-send-email-Zubair.Kakakhel@imgtec.com>
 <772f883f-79fe-9197-f27c-3ffe91019aaf@xilinx.com>
 <5d98fd3b-4722-cdd3-4540-c1d1fec1c98c@imgtec.com>
Cc:     soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, netdev@vger.kernel.org
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <57C97F1C.5000300@arm.com>
Date:   Fri, 2 Sep 2016 14:31:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
MIME-Version: 1.0
In-Reply-To: <5d98fd3b-4722-cdd3-4540-c1d1fec1c98c@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54995
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

On 02/09/16 11:06, Zubair Lutfullah Kakakhel wrote:
> Hi,
> 
> On 09/02/2016 07:25 AM, Michal Simek wrote:
>> On 1.9.2016 18:50, Zubair Lutfullah Kakakhel wrote:
>>> The Xilinx AXI Interrupt Controller IP block is used by the MIPS
>>> based xilfpga platform.
>>>
>>> Move the interrupt controller code out of arch/microblaze so that
>>> it can be used by everyone
>>>
>>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>>>
>>> ---
>>> V3 -> V4
>>> No change
>>>
>>> V2 -> V3
>>> No change here. Cleanup patches follow after this patch.
>>> Its debatable to cleanup before/after move. Decided to place cleanup
>>> after move to put history in new place.
>>>
>>> V1 -> V2
>>>
>>> Renamed irq-xilinx to irq-axi-intc
>>> Renamed CONFIG_XILINX_INTC to CONFIG_XILINX_AXI_INTC
>>
>>
>> I see that this was suggested by Jason Cooper but using axi name here is
>> not correct.
>> There is xps-intc name which is the name used on old OPB hardware
>> designs. It means this driver can be still used only on system which
>> uses it.
> 
> Wouldn't axi-intc be more suitable moving forwards?
> The IP block is now known as axi intc for 5 years as far as I can tell.
> 
> Searching "axi intc" online results in the right docs for current and
> future platforms.
> 
> The binding is still xps-intc as that won't change. So older systems
> should still be able to find their way.
> 
>> Also there is another copy of this driver in the tree which was using
>> old ppc405 and ppc440 xilinx platforms.
>>
>> arch/powerpc/include/asm/xilinx_intc.h
>> arch/powerpc/sysdev/xilinx_intc.c
>>
>> These should be also removed by moving this driver to generic folder.
> 
> I didn't know about that drivers existence.
> 
> This patch series already touches microblaze, mips and irqchip.
> Both microblaze and mips platforms using this driver are little-endian.
> 
> Adding a big-endian powerpc driver + platform to the mix is going to complicate
> the series further and make it super hard to synchronize various subsystems,
> test stuff, and then move the drivers without breakage.
> 
> I'd highly recommend letting this move happen. And then the powerpc driver can
> transition over time to this driver.

In my experience, doing something later means not doing it. Since you're
motivated enough to make this driver common to two architectures, doing
it for 3 shouldn't be that hard.

This will force you to have separate series, but that's hardly an issue.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
