Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Sep 2015 16:15:11 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:47004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008205AbbIBOPKBm9hX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Sep 2015 16:15:10 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B7A075;
        Wed,  2 Sep 2015 07:15:07 -0700 (PDT)
Received: from [10.1.209.148] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83D033F23A;
        Wed,  2 Sep 2015 07:15:00 -0700 (PDT)
Message-ID: <55E70463.10304@arm.com>
Date:   Wed, 02 Sep 2015 15:14:59 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Qais Yousef <qais.yousef@imgtec.com>,
        Mark Rutland <Mark.Rutland@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Lisa Parratt <Lisa.Parratt@imgtec.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com> <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com> <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com> <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com> <alpine.DEB.2.11.1508261701430.15006@nanos> <55DDDE3C.8030609@imgtec.com> <alpine.DEB.2.11.1508262101450.15006@nanos> <55E03A2B.3070805@imgtec.com> <alpine.DEB.2.11.1508281619311.15006@nanos> <55E6C250.50100@imgtec.com> <55E6C788.2000405@arm.com> <55E6D40C.5060708@imgtec.com> <55E6E349.3020907@arm.com> <55E6F8DE.7040308@imgtec.com>
In-Reply-To: <55E6F8DE.7040308@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49086
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

On 02/09/15 14:25, Qais Yousef wrote:
> On 09/02/2015 12:53 PM, Marc Zyngier wrote:
>> On 02/09/15 11:48, Qais Yousef wrote:
>>> It's worth noting in the light of this that INT_SPEC should be optional
>>> since for hardware similar to mine there's not much to tell the
>>> controller if it's all dynamic except where we want the IPI to be routed
>>> to - the INT_SPEC is implicitly defined by the notion it's an IPI.
>> Well, I'd think that the INT_SPEC should say that it is an IPI, and I
>> don't believe we should omit it. On the ARM GIC side, our interrupts are
>> typed (type 0 is a normal wired interrupt, type 1 a per-cpu interrupt,
>> and we could allocate type 2 to identify an IPI).
> 
> I didn't mean to omit it completely, but just being optional so it's 
> specified if the intc needs this info only. I'm assuming that INT_SPEC 
> is interrupt controller specific. If not, then ignore me :-)

It is, but I don't think it can really be made optional.

>>
>> But we do need to identify it properly, as we should be able to cover
>> both IPIs and normal wired interrupts.
> 
> I'm a bit confused here. What do you mean by normal wired interrupts? I 
> thought this DT binding is only to describe IPIs that needs reserving 
> and routing. What am I missing?

Look at my initial proposal, and the way I was describing a device
having an interrupt source, and two possible interrupt sinks, one being
a CPU and the other being another device.

I'm looking at solving that case as well, possibly with the same
infrastructure (the routing bit should be the same).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
