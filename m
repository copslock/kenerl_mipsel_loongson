Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 17:22:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24157 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992209AbcIAPWkrYK0g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 17:22:40 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9BE64C9BA5C80;
        Thu,  1 Sep 2016 16:22:21 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 16:22:24 +0100
Subject: Re: [Patch v3 07/11] MIPS: Xilfpga: Add DT node for AXI I2C
To:     Lars-Peter Clausen <lars@metafoo.de>, <monstr@monstr.eu>,
        <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472661352-11983-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472661352-11983-8-git-send-email-Zubair.Kakakhel@imgtec.com>
 <74279d97-beeb-e754-40ad-3bfc8eeba66d@metafoo.de>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <netdev@vger.kernel.org>
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <6257058c-ae15-ff06-1f01-6e89dc23f2fd@imgtec.com>
Date:   Thu, 1 Sep 2016 16:22:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <74279d97-beeb-e754-40ad-3bfc8eeba66d@metafoo.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54925
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



On 09/01/2016 11:57 AM, Lars-Peter Clausen wrote:
> On 08/31/2016 06:35 PM, Zubair Lutfullah Kakakhel wrote:
> [..]
>> +	    ad7420@4B {
>> +		compatible = "adt7420";
>
> "adi,adt7420"

danke schoen

:)
ZubairLK

>
>> +		reg = <0x4B>;
>> +	    };
>> +	} ;
>>  };
