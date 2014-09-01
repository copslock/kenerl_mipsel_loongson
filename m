Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2014 11:05:10 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:47233 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007766AbaIAJFIB-09o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Sep 2014 11:05:08 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id E9ACF280734
        for <linux-mips@linux-mips.org>; Mon,  1 Sep 2014 11:04:47 +0200 (CEST)
Received: from Dicker-Alter.local (p548C8AB1.dip0.t-ipconnect.de [84.140.138.177])
        by arrakis.dune.hu (Postfix) with ESMTPSA
        for <linux-mips@linux-mips.org>; Mon,  1 Sep 2014 11:04:47 +0200 (CEST)
Message-ID: <540436C1.20805@openwrt.org>
Date:   Mon, 01 Sep 2014 11:05:05 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 04/12] MIPS: GIC: Move MIPS_GIC_IRQ_BASE into platform
 irq.h
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org> <6179185.bNbDBEC6tl@wuerfel> <CAL1qeaEEo6-LZz3Kex7oPUfz=Z56nvKoDnqu051rGhhi3ZFTDQ@mail.gmail.com> <3341001.1Jsp173xyM@wuerfel>
In-Reply-To: <3341001.1Jsp173xyM@wuerfel>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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



On 01/09/2014 10:34, Arnd Bergmann wrote:
> On Sunday 31 August 2014 11:54:04 Andrew Bresticker wrote:
>> On Sat, Aug 30, 2014 at 12:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Friday 29 August 2014 15:14:31 Andrew Bresticker wrote:
>>>> Define a generic MIPS_GIC_IRQ_BASE which is suitable for Malta and
>>>> the upcoming Danube board in <mach-generic/irq.h>.  Since Sead-3 is
>>>> different and uses a MIPS_GIC_IRQ_BASE equal to the CPU IRQ base (0),
>>>> define its MIPS_GIC_IRQ_BASE in <mach-sead3/irq.h>.
>>>>
>>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>>>
>>>
>>> Why do you actually have to hardwire an IRQ base? Can't you move
>>> to the linear irqdomain code for DT based MIPS systems yet?
>>
>> Neither Malta nor SEAD-3 use device-tree for interrupts yet, so they
>> still require a hard-coded IRQ base.  For boards using device-tree, I
>> stuck with a legacy IRQ domain as it allows most of the existing GIC
>> irqchip code to be reused.
> 
> I see. Note that we now have irq_domain_add_simple(), which should
> do the right think in either case: use a legacy domain when a 
> nonzero base is provided for the old boards, but use the simple
> domain when probed from DT without an irq base.
> 
> This makes the latter case more memory efficient (it avoids
> allocating the irq descriptors for every possibly but unused
> IRQ number) and helps ensure that you don't accidentally rely
> on hardcoded IRQ numbers for the DT based machines, which would
> be considered a bug.

Hi,

for the mediatek mt7621/1004k we use the following code to load the gic
https://dev.openwrt.org/browser/trunk/target/linux/ramips/patches-3.14/0012-MIPS-ralink-add-MT7621-support.patch
 (look for  arch/mips/ralink/irq-gic.c)

we ended up using irq_domain_add_legacy()

i am planning to send these patches upstream in the near future.

	John

	John


> 
> 	Arnd
> 
> 
