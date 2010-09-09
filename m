Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2010 20:58:33 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8676 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491101Ab0IIS6a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Sep 2010 20:58:30 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c892e740001>; Thu, 09 Sep 2010 11:59:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 9 Sep 2010 11:58:26 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 9 Sep 2010 11:58:26 -0700
Message-ID: <4C892E51.9050901@caviumnetworks.com>
Date:   Thu, 09 Sep 2010 11:58:25 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: DMA: Add plat_extra_sync_for_cpu()
References: <064bb0722da5d8c271c2bd9fe0a521cc@localhost>        <99a0868bdbcfa8785a92b4af4f6d9b99@localhost>    <4C8914E8.5030002@caviumnetworks.com>   <20100909173426.GA14371@alpha.franken.de> <AANLkTikXd9Hf6nX2X0CSi__t5nm60XFcWLAgFtJ+sZZh@mail.gmail.com>
In-Reply-To: <AANLkTikXd9Hf6nX2X0CSi__t5nm60XFcWLAgFtJ+sZZh@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2010 18:58:26.0216 (UTC) FILETIME=[FBCAAA80:01CB5050]
X-archive-position: 27742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7486

On 09/09/2010 11:35 AM, Kevin Cernekee wrote:
> On Thu, Sep 9, 2010 at 10:34 AM, Thomas Bogendoerfer
> <tsbogend@alpha.franken.de>  wrote:
>> looks like this is doing what the non_coherent_r10000 case does. So IMHO
>
> My code is not currently in the tree, but I have 3 different hooks for
> 3 different processor types.  The generic __dma_sync() workaround used
> on R10K is not sufficient.
>
>> either which make non_coheren check more generic or could use the new
>> plat_sync thingie for IP28 and other non coherent r10k boxes.
>
> That is a good idea.  One thing I'd like to do is continue sharing the
> same R10K code for IP27 / IP28 / IP32 / SNI_RM, and move all of it out
> of dma-default.c .  Do you have any suggestions on how to define the
> plat_* handlers on a per-cpu-type basis instead of making 4 identical
> copies of the R10K workaround?
>

I am working on patches that use asm-generic/dma-mapping-common.h.  This 
dispatches all DMA operations via a dma_map_ops vector.

It adds some function call overhead, but makes it easy to mix and match 
different implementations.

My main motivation is to integrate the swiotlb.c bounce buffer 
management for devices that have small dma_masks.

It is still a work in progress, and is not ready to publish yet.

I foresee a lot of churn in this area in the near future.

David Daney
