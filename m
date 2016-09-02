Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 11:55:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11338 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990522AbcIBJzSpOI0z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 11:55:18 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 40D5095B528A6;
        Fri,  2 Sep 2016 10:55:00 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Sep 2016 10:55:02 +0100
Subject: Re: [Patch v4 01/12] microblaze: irqchip: Move intc driver to irqchip
To:     Michal Simek <michal.simek@xilinx.com>, <monstr@monstr.eu>,
        <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-2-git-send-email-Zubair.Kakakhel@imgtec.com>
 <33b0c20d-a939-0e26-4443-dc41ba06f250@xilinx.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <netdev@vger.kernel.org>
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <025ed01a-9a56-78cc-02cc-39b8c42f8f63@imgtec.com>
Date:   Fri, 2 Sep 2016 10:55:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <33b0c20d-a939-0e26-4443-dc41ba06f250@xilinx.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Hi,

On 09/02/2016 06:56 AM, Michal Simek wrote:
> On 1.9.2016 18:50, Zubair Lutfullah Kakakhel wrote:
>> The Xilinx AXI Interrupt Controller IP block is used by the MIPS
>> based xilfpga platform.
>>
>> Move the interrupt controller code out of arch/microblaze so that
>> it can be used by everyone
>
> if this is just move that you should setup your git right that it won't
> be remove on one side and add on other side.
>
> It should look like this when git mv is used and git setup is right.

That was how I structured it in the first patch.
However irqchip maintainers requested to not do that and show the entire diff
for cleanup/review.

Regards,
ZubairLK

>
> diff --git a/Makefile b/Makefile2
> similarity index 100%
> rename from Makefile
> rename to Makefile2
>
> Thanks,
> Michal
>
