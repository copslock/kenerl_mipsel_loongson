Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2010 19:10:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4926 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491085Ab0IIRKE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Sep 2010 19:10:04 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c89150b0000>; Thu, 09 Sep 2010 10:10:35 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 9 Sep 2010 10:10:00 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 9 Sep 2010 10:10:00 -0700
Message-ID: <4C8914E8.5030002@caviumnetworks.com>
Date:   Thu, 09 Sep 2010 10:10:00 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: DMA: Add plat_extra_sync_for_cpu()
References: <064bb0722da5d8c271c2bd9fe0a521cc@localhost> <99a0868bdbcfa8785a92b4af4f6d9b99@localhost>
In-Reply-To: <99a0868bdbcfa8785a92b4af4f6d9b99@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2010 17:10:00.0893 (UTC) FILETIME=[D65126D0:01CB5041]
X-archive-position: 27738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7428

On 09/08/2010 04:02 PM, Kevin Cernekee wrote:
> On noncoherent processors with a readahead cache, an extra platform-
> specific invalidation is required during the dma_sync_*_for_cpu()
> operations to keep drivers from seeing stale prefetched data.
>
> Signed-off-by: Kevin Cernekee<cernekee@gmail.com>
> ---
>   .../include/asm/mach-cavium-octeon/dma-coherence.h |   13 +++++++++++++
>   arch/mips/include/asm/mach-generic/dma-coherence.h |   13 +++++++++++++
>   arch/mips/include/asm/mach-ip27/dma-coherence.h    |   13 +++++++++++++
>   arch/mips/include/asm/mach-ip32/dma-coherence.h    |   13 +++++++++++++
>   arch/mips/include/asm/mach-jazz/dma-coherence.h    |   13 +++++++++++++
>   .../mips/include/asm/mach-loongson/dma-coherence.h |   13 +++++++++++++
>   arch/mips/include/asm/mach-powertv/dma-coherence.h |   13 +++++++++++++
>   arch/mips/mm/dma-default.c                         |    3 +++
>   8 files changed, 94 insertions(+), 0 deletions(-)
>
[...]

But as far as I can see, none of your plat_extra_sync_for_cpu() do anything.

Perhaps adding this hook should be deferred until there is actually a user.

David Daney
