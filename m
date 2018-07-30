Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 23:14:12 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:33958 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993047AbeG3VOGmUTHq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2018 23:14:06 +0200
Date:   Mon, 30 Jul 2018 23:13:45 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 01/18] doc: dt-bindings: jz4780-dma: Update bindings to
 reflect driver changes
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Message-Id: <1532985225.4702.0@smtp.crapouillou.net>
In-Reply-To: <20180724233558.GA30764@rob-hp-laptop>
References: <20180721110643.19624-1-paul@crapouillou.net>
        <20180721110643.19624-2-paul@crapouillou.net>
        <20180724233558.GA30764@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532985245; bh=uYpD3fWWlneHsqhr3HImK00L2GSDPkiA17V2JO0mQUw=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=j0SgNsHMGUYTOoxLnyjcU3hBtpJEjtsF9EvZKSjEnZr5SUSmHkA2hzCaSw9Ez1e/ff1ejh5o53ezpqGUGfVUZczqodfhPhaSZwlMFqnaCwskWiG+MvWYhOvQpR7aaxYn+kioLp8AStp7Lc0pxGLUN7Af2t3Mf/awjbxHgQ7Mnvo=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65262
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

Le mer. 25 juil. 2018 à 1:35, Rob Herring <robh@kernel.org> a écrit :
> On Sat, Jul 21, 2018 at 01:06:26PM +0200, Paul Cercueil wrote:
>>  The driver is now compatible with four SoCs: JZ4780, JZ4770, 
>> JZ4725B and
>>  JZ4740.
> 
> What the driver supports is irrelevant to the binding.

That's just informative. But I can remove it, no problem.

>> 
>>  Besides, it now expects the devicetree to supply a second memory
>>  resource. This resource is mandatory on the newly supported SoCs.
>>  For the JZ4780, new devicetree code must also provide it, although 
>> the
>>  driver is still compatible with older devicetree binaries.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Tested-by: Mathieu Malaterre <malat@debian.org>
>>  ---
>>   Documentation/devicetree/bindings/dma/jz4780-dma.txt | 14 
>> ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>> 
>>   v2: New patch in this series; regroups the changes made to the
>>   jz4780-dma.txt doc file in the previous version of the patchset.
>> 
>>   v3: Updated example to comply with devicetree specification
>> 
>>  diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt 
>> b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
>>  index f25feee62b15..14f33305e194 100644
>>  --- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
>>  +++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
>>  @@ -2,8 +2,13 @@
>> 
>>   Required properties:
>> 
>>  -- compatible: Should be "ingenic,jz4780-dma"
>>  -- reg: Should contain the DMA controller registers location and 
>> length.
>>  +- compatible: Should be one of:
>>  +  * ingenic,jz4740-dma
>>  +  * ingenic,jz4725b-dma
>>  +  * ingenic,jz4770-dma
>>  +  * ingenic,jz4780-dma
> 
> So none of these are compatible with each other? It should be one 
> valid
> combination per line.

That's correct - they are all slightly different.

>>  +- reg: Should contain the DMA channel registers location and 
>> length, followed
>>  +  by the DMA controller registers location and length.
>>   - interrupts: Should contain the interrupt specifier of the DMA 
>> controller.
>>   - interrupt-parent: Should be the phandle of the interrupt 
>> controller that
>>   - clocks: Should contain a clock specifier for the JZ4780 PDMA 
>> clock.
>>  @@ -20,9 +25,10 @@ Optional properties:
>> 
>>   Example:
>> 
>>  -dma: dma@13420000 {
>>  +dma: dma-controller@13420000 {
>>   	compatible = "ingenic,jz4780-dma";
>>  -	reg = <0x13420000 0x10000>;
>>  +	reg = <0x13420000 0x400
>>  +	       0x13421000 0x40>;
>> 
>>   	interrupt-parent = <&intc>;
>>   	interrupts = <10>;
>>  --
>>  2.11.0
>> 
