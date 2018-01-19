Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2018 09:02:38 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:58247 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990393AbeASIC0ruK0c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jan 2018 09:02:26 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 19 Jan 2018 08:00:41 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 18 Jan
 2018 23:59:48 -0800
Subject: Re: [PATCH 11/14] MIPS: memblock: Print out kernel virtual mem layout
To:     Serge Semin <fancer.lancer@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     <ralf@linux-mips.org>, <miodrag.dinic@mips.com>,
        <jhogan@kernel.org>, <goran.ferenc@mips.com>,
        <david.daney@cavium.com>, <paul.gortmaker@windriver.com>,
        <paul.burton@mips.com>, <alex.belits@cavium.com>,
        <Steven.Hill@cavium.com>, <alexander.sverdlin@nokia.com>,
        <kumba@gentoo.org>, <marcin.nowakowski@mips.com>,
        <James.hogan@mips.com>, <Peter.Wotton@mips.com>,
        <Sergey.Semin@t-platforms.ru>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-12-fancer.lancer@gmail.com>
 <cce36f73-4381-f830-3422-1cef8ad9e622@gmail.com>
 <20180118201856.GA996@mobilestation>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <b2797958-d217-9c8d-10ca-b9bc43ae585b@mips.com>
Date:   Fri, 19 Jan 2018 07:59:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180118201856.GA996@mobilestation>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1516348840-298554-31495-40455-1
X-BESS-VER: 2017.17-r1801171719
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189139
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Hi Serge,



On 18/01/18 20:18, Serge Semin wrote:
> On Thu, Jan 18, 2018 at 12:03:03PM -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 01/17/2018 02:23 PM, Serge Semin wrote:
>>> It is useful to have the kernel virtual memory layout printed
>>> at boot time so to have the full information about the booted
>>> kernel. In some cases it might be unsafe to have virtual
>>> addresses freely visible in logs, so the %pK format is used if
>>> one want to hide them.
>>>
>>> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
>>
>> I personally like having that information because that helps debug and
>> have a quick reference, but there appears to be a trend to remove this
>> in the name of security:
>>
>> https://patchwork.kernel.org/patch/10124007/
>>
>> maybe hide this behind a configuration option?
> 
> Yeah, arm code was the place I picked the function up.) But in my case
> I've used %pK so the pointers would disappear from logging when
> kptr_restrict sysctl is 1 or 2.
> I agree, that we might need to make the printouts optional. If there is
> any kernel config, which for instance increases the kernel security we
> could also use it or anything else to discard the printouts at compile
> time.


Certainly, when KASLR is active it would be preferable to hide this 
information, so you could use CONFIG_RELOCATABLE. The existing KASLR 
stuff additionally hides this kind of information behind 
CONFIG_DEBUG_KERNEL, so that only people actively debugging the kernel 
see it:

http://elixir.free-electrons.com/linux/v4.15-rc8/source/arch/mips/kernel/setup.c#L604

Thanks,
Matt

> 
>> -- 
>> Florian
