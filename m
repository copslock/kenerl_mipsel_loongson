Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Sep 2015 11:33:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3374 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007166AbbIBJdLrZPnW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Sep 2015 11:33:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 45CF470A58735;
        Wed,  2 Sep 2015 10:33:03 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 2 Sep 2015 10:33:05 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 2 Sep
 2015 10:33:04 +0100
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
 <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com>
 <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com>
 <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com>
 <alpine.DEB.2.11.1508261701430.15006@nanos> <55DDDE3C.8030609@imgtec.com>
 <alpine.DEB.2.11.1508262101450.15006@nanos> <55E03A2B.3070805@imgtec.com>
 <alpine.DEB.2.11.1508281619311.15006@nanos>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Lisa Parratt <Lisa.Parratt@imgtec.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <55E6C250.50100@imgtec.com>
Date:   Wed, 2 Sep 2015 10:33:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1508281619311.15006@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

On 08/28/2015 03:22 PM, Thomas Gleixner wrote:
> On Fri, 28 Aug 2015, Qais Yousef wrote:
>> Thanks a lot for the detailed explanation. I wasn't looking for a quick and
>> dirty solution but my view of the problem is much simpler than yours so my
>> idea of a solution would look quick and dirty. I have a better appreciation of
>> the problem now and a way to approach it :-)
>>
>>  From DT point of view are we OK with this form then
>>
>>      coprocessor {
>>              interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
>>              interrupt-sink = <&intc INT_SPEC CPU_HWAFFINITY>;
>>      }
>>
>> and if the root controller sends normal IPI as it sends normal device
>> interrupts then interrupt-sink can be a standard interrupts property (like in
>> my case)
>>
>>      coprocessor {
>>              interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
>>              interrupts = <INT_SPEC>;
>>      }
>>
>> Does this look right to you? Is there something else that needs to be covered
>> still?
> I'm not an DT wizard. I leave that to the DT experts.
>   

Hi Marc Zyngier, Mark Rutland,

Any comments about the DT binding for the IPIs?

To recap, the proposal which is based on Marc Zyngier's is to use 
interrupt-source to represent an IPI from Linux CPU to a coprocessor and 
interrupt-sink to receive an IPI from coprocessor to Linux CPU. 
Hopefully the description above is self explanatory. Please let me know 
if you need more info. Thomas covered the routing, synthesising, and 
requesting parts in the core code. The remaining (high level) issue is 
how to describe the IPIs in DT.

Thanks,
Qais
