Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 19:38:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59141 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012328AbaJ3SiYOXsLW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 19:38:24 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6EBA07342480C;
        Thu, 30 Oct 2014 18:38:13 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 30 Oct
 2014 18:38:17 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 30 Oct
 2014 18:38:16 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 30 Oct
 2014 11:38:13 -0700
Message-ID: <54528595.8070009@imgtec.com>
Date:   Thu, 30 Oct 2014 11:38:13 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <nbd@openwrt.org>, <yanh@lemote.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <alex.smith@imgtec.com>, <taohl@lemote.com>, <chenhc@lemote.com>,
        <blogic@openwrt.org>
Subject: Re: [PATCH] MIPS: DMA: fix coherent alloc in non-coherent systems
References: <20141030014753.13189.48344.stgit@linux-yegoshin> <54520DE4.9090008@imgtec.com>
In-Reply-To: <54520DE4.9090008@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 10/30/2014 03:07 AM, James Hogan wrote:
> Hi Leonid,
>
> On 30/10/14 01:48, Leonid Yegoshin wrote:
>> A default dma_alloc_coherent() fails to alloc a coherent memory on non-coherent
>> systems in case of device->coherent_dma_mask covering the whole memory space.
>>
>> In case of non-coherent systems the coherent memory on MIPS is restricted by
>> size of un-cachable segment and should be located in ZONE_DMA.
> Has this pretty much always been broken?
>
>
Yes, but it can be seen on MIPS32 EVA-based CPUs.
