Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 17:30:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55240 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992213AbcIAPaqCXmGA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 17:30:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 183A1A7969085;
        Thu,  1 Sep 2016 16:30:26 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 16:30:29 +0100
Subject: Re: [Patch v3 08/11] net: ethernet: xilinx: Generate random mac if
 none found
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472661352-11983-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472661352-11983-9-git-send-email-Zubair.Kakakhel@imgtec.com>
 <3e2dea83-ee59-2980-3a9d-50da04271158@cogentembedded.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <netdev@vger.kernel.org>
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <d7b5d5b9-e87e-73da-6bfe-7516703298c3@imgtec.com>
Date:   Thu, 1 Sep 2016 16:30:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <3e2dea83-ee59-2980-3a9d-50da04271158@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54927
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



On 09/01/2016 11:52 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 8/31/2016 7:35 PM, Zubair Lutfullah Kakakhel wrote:
>
>> At the moment, if the emaclite device doesn't find a mac address
>> from any source, it simply uses 0x0 with a warning printed.
>>
>> Instead of using a 0x0 mac address, use a randomly generated one.
>>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> [...]
>
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
>> index 3cee84a..22e5a5a 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
>> @@ -1134,8 +1134,10 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
>>      if (mac_address)
>>          /* Set the MAC address. */
>>          memcpy(ndev->dev_addr, mac_address, ETH_ALEN);
>> -    else
>> -        dev_warn(dev, "No MAC address found\n");
>> +    else {
>> +        dev_warn(dev, "No MAC address found. Generating Random one\n");
>> +        eth_hw_addr_random(ndev);
>> +    }
>
>    All branches of the *if* statement should have {} if at least one has them, see Documentation/CodingStyle, chaoter 3.

Спасибо

ZubairLK

>
> [...]
>
> MBR, Sergei
>
