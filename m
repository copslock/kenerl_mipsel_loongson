Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 12:35:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15691 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991344AbcITKe4qRVGp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 12:34:56 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E64975037E848;
        Tue, 20 Sep 2016 11:34:37 +0100 (IST)
Received: from [127.0.0.1] (10.100.200.248) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 20 Sep
 2016 11:34:40 +0100
Subject: Re: [PATCH v2 09/14] MIPS: Malta: Probe RTC via DT
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
References: <20160919212132.28893-1-paul.burton@imgtec.com>
 <20160919212132.28893-10-paul.burton@imgtec.com>
 <55c977d1-21dd-4cf8-d0f9-10d96b452573@cogentembedded.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <762c9f70-911c-0e48-ef8e-8f8b9e006592@imgtec.com>
Date:   Tue, 20 Sep 2016 11:34:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <55c977d1-21dd-4cf8-d0f9-10d96b452573@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.100.200.248]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55204
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

On 20/09/16 11:21, Sergei Shtylyov wrote:
> Hello.
> 
> On 9/20/2016 12:21 AM, Paul Burton wrote:
> 
>> Add the DT node required to probe the RTC, and remove the platform code
>> that was previously doing it.
>>
>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>
>> ---
>>
>> Changes in v2:
>> - Remove rtc DT node label
> 
>    Haven't you also renamed the node?

Hi Sergei,

Yes, strictly speaking I could have been more verbose & elaborated in
the changelog on every aspect of the simple change from "rtc:
mc146818@70" to "rtc@70". I didn't, but as it's obviously clear to you
what changed and it has no effect on either the code or the commit that
would end up in git I don't really see the point of your bringing it up.

Thanks,
    Paul

>>  arch/mips/boot/dts/mti/malta.dts     | 15 +++++++++++++++
>>  arch/mips/mti-malta/malta-platform.c | 21 ---------------------
>>  2 files changed, 15 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/mips/boot/dts/mti/malta.dts
>> b/arch/mips/boot/dts/mti/malta.dts
>> index af765af..fecbca8 100644
>> --- a/arch/mips/boot/dts/mti/malta.dts
>> +++ b/arch/mips/boot/dts/mti/malta.dts
>> @@ -49,4 +49,19 @@
>>          interrupt-parent = <&gic>;
>>          interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
>>      };
>> +
>> +    isa {
>> +        compatible = "isa";
>> +        #address-cells = <2>;
>> +        #size-cells = <1>;
>> +        ranges = <1 0 0 0x1000>;
>> +
>> +        rtc@70 {
>> +            compatible = "motorola,mc146818";
>> +            reg = <1 0x70 0x8>;
>> +
>> +            interrupt-parent = <&i8259>;
>> +            interrupts = <8>;
>> +        };
>> +    };
>>  };
> [...]
> 
> MBR, Sergei
> 
