Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 19:22:59 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:52358 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011072AbbKYSWwnqLCC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 19:22:52 +0100
Received: from [127.0.0.1] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Wed, 25 Nov 2015
 11:22:45 -0700
Subject: Re: [PATCH 02/14] irqchip: irq-pic32-evic: Add support for PIC32
 interrupt controller
To:     Marc Zyngier <marc.zyngier@arm.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-3-git-send-email-joshua.henderson@microchip.com>
 <20151122114530.10bca210@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <5655FC74.9090204@microchip.com>
Date:   Wed, 25 Nov 2015 11:22:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151122114530.10bca210@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

On 11/22/2015 4:45 AM, Marc Zyngier wrote:
> On Fri, 20 Nov 2015 17:17:14 -0700
> Joshua Henderson <joshua.henderson@microchip.com> wrote:
> 
> Joshua, Cristian,
> 
>> From: Cristian Birsan <cristian.birsan@microchip.com>
>>
>> This adds support for the EVIC present on a PIC32MZDA.
>>
>> The following features are supported:
>>  - DT properties for EVIC and for devices that use interrupt lines
>>  - persistent and non-persistent interrupt handling
>>  - Priority, sub-priority and polariy settings for each interrupt line
>>  - irqdomain support
>>
> 
> I haven't reviewed the code yet, but the fact that you allow (and
> actually request) the interrupt priorities to be encoded in the DT
> raises some concerns:
> 
> - Aren't priorities entirely under software control (and hence don't
>   belong in DT)?

These are hardware priorities configured by software.  They arbitrate pending hardware interrupts to the CPU.  We can agree that DT is probably not the best place for this configuration.  They will be removed from the binding.

> - More crucially, how do you deal with nested interrupts when you have
>   interrupts running at different priorities? Most parts of Linux
>   cannot cope with that without additional support.
> 

We do not support nested interrupts.

> Thanks,
> 
> 	M.
> 
