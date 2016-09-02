Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 15:59:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16933 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991344AbcIBN7hOQ7x4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 15:59:37 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B2178F5650F13;
        Fri,  2 Sep 2016 14:59:17 +0100 (IST)
Received: from [127.0.0.1] (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 14:59:20 +0100
Subject: Re: [PATCH 11/26] dt-bindings: Document mti,mips-cpc binding
To:     Rob Herring <robh@kernel.org>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
 <20160826153725.11629-12-paul.burton@imgtec.com>
 <20160902123419.GA31627@rob-hp-laptop>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <f827cd3c-9547-ae44-51bf-ea574a7fa136@imgtec.com>
Date:   Fri, 2 Sep 2016 14:59:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160902123419.GA31627@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On 02/09/16 13:34, Rob Herring wrote:
> On Fri, Aug 26, 2016 at 04:37:10PM +0100, Paul Burton wrote:
>> Document a binding for the MIPS Cluster Power Controller (CPC) which
>> simply allows the device tree to specify where the CPC registers should
>> be mapped.
>>
>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>> ---
>>
>>  Documentation/devicetree/bindings/misc/mti,mips-cpc.txt | 8 ++++++++
> 
> This is for power domains, right? Move to bindings/power.

Hi Rob,

Well, sort of. The CPC controls the power domains for CPU cores & the
MIPS Coherency Manager within a CPU cluster. That is, it's the block of
hardware that we send commands to power up or down CPUs to. It's not
something that makes use of the kernel's power domain infrastructure,
it's essentially only involved in SMP startup, hotplug or cpuidle low
power states.

This binding is purely about assigning some address space for the CPC
register interface, which can be mapped anywhere at runtime. Besides
knowing where to place the registers there's currently nothing else we'd
need to describe in DT.

If you still think bindings/power/ is the best place for it given that,
I'll move it.

> 
>>  1 file changed, 8 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/misc/mti,mips-cpc.txt b/Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
>> new file mode 100644
>> index 0000000..92eb08f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
>> @@ -0,0 +1,8 @@
>> +Binding for MIPS Cluster Power Controller (CPC).
>> +
>> +This binding allows a system to specify where the CPC registers should be
>> +mapped using device tree.
>> +
>> +Required properties:
>> +compatible : Should be "mti,mips-cpc".
>> +regs: Should describe the address & size of the CPC register region.
> 
> Also needs #power-domain-cells property.

As above, this doesn't make use of power domain infrastructure or
anything like it so I don't think that's correct.

Thanks,
    Paul

> 
>> -- 
>> 2.9.3
>>
