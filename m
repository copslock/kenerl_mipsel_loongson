Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Aug 2013 19:23:27 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:49952 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826530Ab3HLRW5xiz0l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Aug 2013 19:22:57 +0200
Message-ID: <520919F0.5090209@openwrt.org>
Date:   Mon, 12 Aug 2013 19:22:56 +0200
From:   Felix Fietkau <nbd@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: partially inline dma ops
References: <1376306569-83278-1-git-send-email-nbd@openwrt.org> <1376306569-83278-2-git-send-email-nbd@openwrt.org> <5209169F.5070709@gmail.com>
In-Reply-To: <5209169F.5070709@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <nbd@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
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

On 2013-08-12 7:08 PM, David Daney wrote:
> On 08/12/2013 04:22 AM, Felix Fietkau wrote:
>> Several DMA ops are no-op on many platforms, and the indirection through
>> the mips_dma_map_ops function table is causing the compiler to emit
>> unnecessary code.
>>
>> Inlining visibly improves network performance in my tests (on a 24Kc
>> based system), and also slightly reduces code size of a few drivers.
>>
>> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
>> ---
>>   arch/mips/Kconfig                   |   4 +
>>   arch/mips/include/asm/dma-mapping.h | 360 +++++++++++++++++++++++++++++++++++-
>>   arch/mips/mm/dma-default.c          | 161 ++--------------
>>   3 files changed, 372 insertions(+), 153 deletions(-)
> That is not a very pleasing diffstat.
I know. But altering the generic include (of which I duplicated the
inlined code here) would make things even worse. I believe the
improvement in the generated code is worth it though.
I just did some fresh performance tests with an 400 MHz AR7242 system
(MIPS 24Kc), bridging packets from one Ethernet port to another. I'm
running TCP iperf through this device.
Without this patch, I get 710-760 MBit/s with heavy fluctuation.
With this patch, I get 780-790 MBit/s with little fluctuation.
Most other MIPS systems will probably see similar improvements in DMA
heavy drivers.
For Octeon, I don't expect any visible performance change, and the
change shouldn't make it any worse either.

- Felix
