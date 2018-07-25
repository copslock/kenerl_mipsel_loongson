Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 07:11:54 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:44100 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990393AbeGYFLvkgFWm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 07:11:51 +0200
Subject: Re: [PATCH V2 00/25] MIPS: ath79: convert target to pure OF
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <20180720115842.8406-1-john@phrozen.org>
 <20180725021555.rol2kafsztwqqkgt@pburton-laptop>
From:   John Crispin <john@phrozen.org>
Message-ID: <4cfba352-546e-2300-515d-89626c2e0d46@phrozen.org>
Date:   Wed, 25 Jul 2018 07:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725021555.rol2kafsztwqqkgt@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 25/07/18 04:15, Paul Burton wrote:
> Hi John,
>
> On Fri, Jul 20, 2018 at 01:58:17PM +0200, John Crispin wrote:
>> In the last couple of months we have been conevrting this target to OF
>> inside OpenWrt. This series is an aggragte of all the patches that have
>> been produced in that period. There have been plenty of dts contributions
>> already and we hope to be able to drop the old mach file based target in
>> the not too distant future.
>>
>> Felix Fietkau (9):
>>    MIPS: ath79: fix register address in ath79_ddr_wb_flush()
>>    MIPS: ath79: fix system restart
>>    MIPS: ath79: finetune cpu-overrides
>>    MIPS: ath79: add helpers for setting clocks and expose the ref clock
>>    MIPS: ath79: move legacy "wdt" and "uart" clock aliases out of soc
>>      init
>>    MIPS: ath79: pass PLL base to clock init functions
>>    MIPS: ath79: make specifying the reference clock in DT optional
>>    MIPS: ath79: support setting up clock via DT on all SoC types
>>    MIPS: ath79: export switch MDIO reference clock
>>
>> Gabor Juhos (2):
>>    MIPS: ath79: add lots of missing registers
>>    MIPS: ath79: enable uart during early_prink
>>
>> John Crispin (12):
>>    MIPS: ath79: select the PINCTRL subsystem
>>    dt-bindings: PCI: qcom,ar7100: adds binding doc
>>    MIPS: pci-ar71xx: convert to OF
>>    dt-bindings: PCI: qcom,ar7240: adds binding doc
>>    MIPS: pci-ar724x: convert to OF
>>    MIPS: ath79: drop legacy IRQ code
>>    MIPS: ath79: drop machfiles
>>    MIPS: ath79: drop legacy pci code
>>    MIPS: ath79: drop platform device registration code
>>    MIPS: ath79: drop !OF clock code
>>    MIPS: ath79: sanitize symbols
>>    spi: ath79: drop pdata support
>>
>> Mathias Kresin (1):
>>    MIPS: ath79: get PCIe controller out of reset
>>
>> Matthias Schiffer (1):
>>    MIPS: ath79: add support for QCA953x QCA956x TP9343
> Patch 4 is in for v4.18-rc7.
>
> I've applied patches 1-3,5-8 to mips-next for 4.19 (with a couple of
> tweaks to patch 7 addressing Sergei's comments).
>
> Patches 9-25 need DT binding review.
>
> One general question I have: where is the DT for these systems being
> maintained? It doesn't appear to be in-tree - could it be? Because I
> don't see the DT source it's difficult to see what impact the remaining
> changes will have - for example would they break backwards compatibility
> with any systems?
>
> Thanks,
>      Paul
>

Hi Paul,

thanks ! I was going to prepare V3 today, I'll do so dropping everything 
that you have already merged.
as for dts files, we are currently staging them inside OpenWrt and 
afaict all boards previously supported
by machfiles already have a dts file. My hope is to eventually get all 
of them included upstream, same goes
for the ralink ones.
     John
