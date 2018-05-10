Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:20:27 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990404AbeENGURtQn-O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 08:20:17 +0200
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com [209.85.220.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DE84217C6;
        Thu, 10 May 2018 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525956946;
        bh=OmsVtZ4SDuKoPyBgahj2ZpN9Igaypgm9SDjKOYQho/Y=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GOJZGXUDxe9iQXrKDDqpBQldD99NdMmOat+4/R5KoNoOO3t5EYg0Jd0/b7gNNOHK7
         PjqgtCA8MeaUkIvK05iRs8z9kMa+nLRTl+nRqSiez8Eg26M4qjSwdAzIVVtgDaF1Bd
         EiFfULRG0sXrY4fwBQYHOqE+1MTwuSWZQvuJ02EY=
Received: by mail-qk0-f182.google.com with SMTP id p186-v6so1447729qkd.1;
        Thu, 10 May 2018 05:55:46 -0700 (PDT)
X-Gm-Message-State: ALKqPwfGNFvHbH88UdMU41dgkB2fYiGbxq2k636p4ueowC0bD8XlSTGy
        ohUAIsxdcTYbwLmNquKS72YOVGijvuSLlAEfgA==
X-Google-Smtp-Source: AB8JxZo9xQhcUj0eV3yHsSzC8ohG53OusWtwvmoJkbbS3qvOhk2H96dvVY7f4KokBkX3Co6T6pAP6Tm+VJzAvgtciWI=
X-Received: by 2002:a37:4050:: with SMTP id n77-v6mr1046020qka.213.1525956945811;
 Thu, 10 May 2018 05:55:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.155.2 with HTTP; Thu, 10 May 2018 05:55:25 -0700 (PDT)
In-Reply-To: <20180508233758.GE14903@jamesdev>
References: <20180328011435.29776-1-robh@kernel.org> <20180508233758.GE14903@jamesdev>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 May 2018 07:55:25 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+MP5+z7BqRSrOkB2XBFgo9r-E5roUKwZoTaV54SiVP8A@mail.gmail.com>
Message-ID: <CAL_Jsq+MP5+z7BqRSrOkB2XBFgo9r-E5roUKwZoTaV54SiVP8A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: use memblock instead of rescanning the FDT
To:     James Hogan <jhogan@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Tue, May 8, 2018 at 6:38 PM, James Hogan <jhogan@kernel.org> wrote:
> On Tue, Mar 27, 2018 at 08:14:35PM -0500, Rob Herring wrote:
>> There's no need to scan /memory nodes twice. The DT core code scans
>> nodes and adds memblocks already, so we can just use
>> memblock_phys_mem_size() to see if we have any memory already setup.
>
> Hmm, on MIPS, early_init_dt_add_memory_arch() calls add_memory_region(),
> which just modifies boot_mem_map. memblock isn't notified until after
> plat_mem_setup() returns, in bootmem_init().

Yes, you're right. I guess first boot_mem_map needs to be converted to memblock.

Rob
