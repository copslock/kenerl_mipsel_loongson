Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 23:08:22 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15774 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab0JNVIT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Oct 2010 23:08:19 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb771640000>; Thu, 14 Oct 2010 14:08:52 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 14:08:32 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 14:08:32 -0700
Message-ID: <4CB7713C.9040303@caviumnetworks.com>
Date:   Thu, 14 Oct 2010 14:08:12 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>, ralf@linux-mips.org
CC:     benh@kernel.crashing.org, dediao@cisco.com,
        linux-mips@linux-mips.org, monstr@monstr.eu, dvomlehn@cisco.com,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 1/2] of/flattree: Eliminate need to provide early_init_dt_scan_chosen_arch
References: <20101013064352.2743.80378.stgit@localhost6.localdomain6>
In-Reply-To: <20101013064352.2743.80378.stgit@localhost6.localdomain6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2010 21:08:32.0629 (UTC) FILETIME=[F53C0250:01CB6BE3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/12/2010 11:44 PM, Grant Likely wrote:
> This patch refactors the early init parsing of the chosen node so that
> architectures aren't forced to provide an empty implementation of
> early_init_dt_scan_chosen_arch.  Instead, if an architecture wants to
> do something different, it can either use a wrapper function around
> early_init_dt_scan_chosen(), or it can replace it altogether.
>
> This patch was written in preparation to adding device tree support to
> both x86 ad MIPS.
>
> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>

In conjunction with my 'MIPS: Add some irq definitins required by OF' 
and the '2/2 of/mips: Add device tree support to MIPS' patches, I can 
enable CONFIG_USE_OF, and build and run a kernel on my Octeon.  I 
haven't started using the device tree yet, but this is a good start.

You can add my...

Tested-by: David Daney <ddaney@caviumnetworks.com>


> ---
>   arch/microblaze/kernel/prom.c |    5 -----
>   arch/powerpc/kernel/prom.c    |   12 ++++++++++--
>   drivers/of/fdt.c              |    2 --
>   include/linux/of_fdt.h        |    2 +-
>   4 files changed, 11 insertions(+), 10 deletions(-)
[...]
