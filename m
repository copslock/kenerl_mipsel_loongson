Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 18:26:56 +0200 (CEST)
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:26174
        "EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903536Ab2HNQ0w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2012 18:26:52 +0200
Received: from mail52-va3-R.bigfish.com (10.7.14.254) by
 VA3EHSOBE009.bigfish.com (10.7.40.29) with Microsoft SMTP Server id
 14.1.225.23; Tue, 14 Aug 2012 16:26:43 +0000
Received: from mail52-va3 (localhost [127.0.0.1])       by mail52-va3-R.bigfish.com
 (Postfix) with ESMTP id 1B7DC1204E3;   Tue, 14 Aug 2012 16:26:43 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.236.133;KIP:(null);UIP:(null);IPV:NLI;H:BY2PRD0710HT004.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -4
X-BigFish: PS-4(zzbb2dI98dI9371I1432Izz1202hzz8275bhz2dh2a8h668h839hd25he5bhf0ah107ah)
Received: from mail52-va3 (localhost.localdomain [127.0.0.1]) by mail52-va3
 (MessageSwitch) id 1344961600674835_13358; Tue, 14 Aug 2012 16:26:40 +0000
 (UTC)
Received: from VA3EHSMHS017.bigfish.com (unknown [10.7.14.248]) by
 mail52-va3.bigfish.com (Postfix) with ESMTP id 9FCBE180435;    Tue, 14 Aug 2012
 16:26:40 +0000 (UTC)
Received: from BY2PRD0710HT004.namprd07.prod.outlook.com (157.56.236.133) by
 VA3EHSMHS017.bigfish.com (10.7.99.27) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Tue, 14 Aug 2012 16:26:39 +0000
Received: from dd1.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.86.39) with Microsoft SMTP Server (TLS) id 14.16.175.8; Tue, 14 Aug
 2012 16:26:38 +0000
Message-ID: <502A7C3C.6080907@caviumnetworks.com>
Date:   Tue, 14 Aug 2012 09:26:36 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Huacai Chen <chenhuacai@gmail.com>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V5 09/18] MIPS: Loongson: Add swiotlb to support big memory
 (>4GB).
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>       <1344677543-22591-10-git-send-email-chenhc@lemote.com>  <20120813175447.GB26088@phenom.dumpdata.com> <CAAhV-H7mJUC9njF_wHda8ymUBkUom5AZ+u8OFXtA42uyA-hFxg@mail.gmail.com>
In-Reply-To: <CAAhV-H7mJUC9njF_wHda8ymUBkUom5AZ+u8OFXtA42uyA-hFxg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
X-archive-position: 34162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 08/13/2012 10:57 PM, Huacai Chen wrote:
> Hi, David,
>
> Seems like you are the original author of code in
> arch/mips/cavium-octeon/dma-octeon.c. Could you please tell me why we
> need mb() in alloc_coherent(), map_page(), map_sg()? It seems like
> because of cache coherency (CPU write some data, then map the page for
> a device, if without mb(), then device may read wrong data.) but I'm
> not sure.
>

That is essentially correct.

The DMA API requires certain memory barrier semantics.  These are 
achieved with the mb() in the OCTEON code.

> On Tue, Aug 14, 2012 at 1:54 AM, Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com>  wrote:
>>> +static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
>>> +                             dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)

I know nothing about Loongson, so I cannot comment on what is required 
for it.

David Daney
