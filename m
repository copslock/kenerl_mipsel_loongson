Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2017 19:34:15 +0100 (CET)
Received: from smtprelay.synopsys.com ([198.182.47.9]:42364 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992380AbdAESeIdkHxa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jan 2017 19:34:08 +0100
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0E51824E1415;
        Thu,  5 Jan 2017 10:33:58 -0800 (PST)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id F011428A;
        Thu,  5 Jan 2017 10:33:57 -0800 (PST)
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id A8E79289;
        Thu,  5 Jan 2017 10:33:57 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Thu, 5 Jan 2017 10:33:56 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Thu, 5 Jan 2017 19:33:54 +0100
Received: from [10.107.19.116] (10.107.19.116) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Thu, 5 Jan 2017 19:33:54 +0100
Subject: Re: [PATCH] MIPS: NI 169445 board support
To:     Niklas Cassel <niklas.cassel@axis.com>,
        Nathan Sullivan <nathan.sullivan@ni.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <1480693329-22265-1-git-send-email-nathan.sullivan@ni.com>
 <20161220163434.GA15962@linux-mips.org>
 <20170104163836.GA18069@nathan3500-linux-VM>
 <5d5a087f-68ec-e633-0232-0248edf11ee0@axis.com>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Lars Persson <larper@axis.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
From:   Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <8fd70ecb-36fc-7cc7-7795-cd4dccabf8b9@synopsys.com>
Date:   Thu, 5 Jan 2017 18:33:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <5d5a087f-68ec-e633-0232-0248edf11ee0@axis.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.19.116]
Return-Path: <Joao.Pinto@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Joao.Pinto@synopsys.com
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

Às 6:28 PM de 1/5/2017, Niklas Cassel escreveu:
> On 01/04/2017 05:38 PM, Nathan Sullivan wrote:
>> On Tue, Dec 20, 2016 at 05:34:34PM +0100, Ralf Baechle wrote:
>>> On Fri, Dec 02, 2016 at 09:42:09AM -0600, Nathan Sullivan wrote:
>>>> Date:   Fri, 2 Dec 2016 09:42:09 -0600
>>>> From: Nathan Sullivan <nathan.sullivan@ni.com>
>>>> To: ralf@linux-mips.org, mark.rutland@arm.com, robh+dt@kernel.org
>>>> CC: linux-mips@linux-mips.org, devicetree@vger.kernel.org,
>>>>  linux-kernel@vger.kernel.org, Nathan Sullivan <nathan.sullivan@ni.com>
>>>> Subject: [PATCH] MIPS: NI 169445 board support
>>>> Content-Type: text/plain
>>>>
>>>> Support the National Instruments 169445 board.
>>> Nathan,
>>>
>>> I assume you're going to repost the changes Rob asked for in
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.linux-2Dmips.org_patch_14641_-2326924&d=DgICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=5p7f9dIkvVVK4UFHimMpezq5NwIJfUpd08c-Zk4_c6c&s=_JwSwe4VFYtxV1tcYt6Z8r4hJX0xfoGhCixygUxlg5s&e=  and resubmit?
>>>
>>> Thanks,
>>>
>>>   Ralf
>> Hmm, I found the issue with the generic MIPS config and dwc_eth_qos.  The NIC
>> driver attempts to cache align a descriptor ring using the ___cacheline_aligned
>> attribute on the descriptor struct, in combination with a "skip" feature in
>> hardware.  However, the skip feature only has a three bit field, and the generic
>> MIPS config selects MIPS_L1_CACHE_SHIFT_7.  So, the line size is 128, and with a
>> 64-bit bus, that means the NIC descriptor skip field would need to be set to
>> 14 to align the 16-byte descriptors...
>>
>> I guess it makes sense for a generic MIPS kernel to align everything for 128 byte
>> cache lines, and for me to fix the dwc_eth_qos driver to handle cases where the
>> line size is too big for the hardware skip feature, right?
> 
> I don't know if you've been following the discussion regarding
> dwc_eth_qos on netdev, but Joao Pinto from Synopsys is
> planning on removing the driver (since the stmmac driver
> now supports the same version of the IP, together with older
> versions of the IP).
> 
> Since device tree bindings are treated as an ABI,
> Joao has implemented a glue layer for stmmac that parses
> the dwc_eth_qos binding, but uses stmmac under the hood.
> 
> You can use any of the bindings, but since the dwc_eth_qos
> binding will be marked as deprecated, you might want to
> consider moving to the stmmac binding.

A patch set to port dwc_eth_qos to stmmac is at this moment under review:

http://patchwork.ozlabs.org/patch/711428/
http://patchwork.ozlabs.org/patch/711438/
http://patchwork.ozlabs.org/patch/711439/

Niklas has tested it and it works well, so after the patches are upstreamed the
dwc_eth_qos will be removed as agreed with Lars.

Thanks.

> 
>>
>> Thanks,
>>
>>    Nathan
>>
>>
> 
