Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2012 19:47:40 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:61459 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903340Ab2ILRre (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2012 19:47:34 +0200
Received: by pbbrq8 with SMTP id rq8so2801931pbb.36
        for <multiple recipients>; Wed, 12 Sep 2012 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qkCcQGO3p2TVTvWfJKYhqNdRHh8A4tx7QyEIYSBv6wI=;
        b=d+puFmdSpQ8qCxMGg3AG+WlUPwCzhJPnBKzQ7MjXDpjkxT7EBuk6LHcp+o+1M3fQEZ
         9w1i4X30JMhPzV93EhQ7jclJd1wzZdzYj66U7IgvLTNLqgKuzFofsJ0h0aCN/lGtn8FQ
         JUSMWcc+9/TT9HnWZbDNEw5hhO+2DdWK7LxA4z/ZXYhe81kSDPfXjtZ7hq5yveQ3utjL
         d5X721R1lsfeX03lnxZTo/9NZtwJJZN1mH+8IZ6qzaCNtHOaSKU6nEorwyBVYPDYlshs
         ScQkDPUDMtdtuFcFQefOX+HjMUOn71TfSvy5ZwNaVA4R1tIKn9NlOSXABFoGp+0TkzHX
         GTWw==
Received: by 10.66.76.165 with SMTP id l5mr32535439paw.79.1347472047910;
        Wed, 12 Sep 2012 10:47:27 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ka4sm11714859pbc.61.2012.09.12.10.47.25
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 10:47:26 -0700 (PDT)
Message-ID: <5050CAAC.1090600@gmail.com>
Date:   Wed, 12 Sep 2012 10:47:24 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Add RI and XI bits to MIPS base architecture.
References: <1347469309-11468-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1347469309-11468-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 09/12/2012 10:01 AM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Add MIPSr3(TM) base architecture TLB support for Read Inhibit (RI)
> and Execute Inhibit (XI) page protection. SmartMIPS cores will not
> notice any change in functionality.
>
> This patchset obsoletes the previous patchset with four commits.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

FWIW:  I haven't tested it, but the entire set ...

Acked-by: David Daney <david.daney@cavium.com>


>
> Steven J. Hill (2):
>    MIPS: Add base architecture support for RI and XI.
>    MIPS: Replace 'kernel_uses_smartmips_rixi' with 'cpu_has_rixi'.
>
>   arch/mips/include/asm/cpu-features.h               |    4 ++--
>   arch/mips/include/asm/cpu.h                        |    1 +
>   .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    2 +-
>   arch/mips/include/asm/mipsregs.h                   |    1 +
>   arch/mips/include/asm/pgtable-bits.h               |   18 +++++++++---------
>   arch/mips/include/asm/pgtable.h                    |   12 ++++++------
>   arch/mips/kernel/cpu-probe.c                       |    6 +++++-
>   arch/mips/mm/cache.c                               |    2 +-
>   arch/mips/mm/fault.c                               |    2 +-
>   arch/mips/mm/tlb-r4k.c                             |    2 +-
>   arch/mips/mm/tlbex.c                               |   14 +++++++-------
>   11 files changed, 35 insertions(+), 29 deletions(-)
>
