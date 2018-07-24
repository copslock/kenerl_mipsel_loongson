Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 13:09:49 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:36804 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993964AbeGXLJpihDsy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2018 13:09:45 +0200
Date:   Tue, 24 Jul 2018 13:09:34 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 00/18] JZ4780 DMA patchset v3
To:     Paul Burton <paul.burton@mips.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Message-Id: <1532430574.2610.0@smtp.crapouillou.net>
In-Reply-To: <20180723175846.udmjtkx7fsaf52wa@pburton-laptop>
References: <20180721110643.19624-1-paul@crapouillou.net>
        <20180723175846.udmjtkx7fsaf52wa@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532430583; bh=PBGj1BpZp0feTqBaomdzuC/a/PGMi+7d+A74Qs+Cg+0=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ejIs0s25ReYtzT1ysv+Oh/m0zFJ8MPJSXHEAibT/gnX92MVNH2jhOLPbIxRHu3R/w2Zn3Pcw9EXxZS5LmuKfmJP1rS/paQiPyfMj+0zeJnDxwJjM2yE8gkRVHJRUAm5NCe/T1+oQnkySXdAzeO96iDhIGi/X13I22PuHt5srXK8=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi,

Le lun. 23 juil. 2018 à 19:58, Paul Burton <paul.burton@mips.com> a 
écrit :
> Hi Paul & Vinod,
> 
> On Sat, Jul 21, 2018 at 01:06:25PM +0200, Paul Cercueil wrote:
>>  This is the version 3 of my jz4780-dma driver update patchset.
>> 
>>  Apologies to the DMA people, the v2 of this patchset did not make 
>> it to
>>  their mailing-list; see the bottom of this email for a description 
>> of
>>  what happened in v2.
>> 
>>  Changelog from v2 to v3:
>> 
>>  - Modified the devicetree bindings to comply with the specification
>> 
>>  - New patch [06/18] allows the JZ4780 DMA driver to be compiled 
>> within a
>>    generic MIPS kernel.
> 
> Would you prefer to take the MIPS .dts changes in patches 16-18 
> through
> the DMA tree with the rest of the series?

I think it would make sense yes.

> If so then for patches 16-18:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>
> 
> Thanks,
>     Paul
