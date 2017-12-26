Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 19:06:25 +0100 (CET)
Received: from mail-lf0-x22f.google.com ([IPv6:2a00:1450:4010:c07::22f]:46993
        "EHLO mail-lf0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbdLZSGSVJNP0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 19:06:18 +0100
Received: by mail-lf0-x22f.google.com with SMTP id a12so3964243lfe.13;
        Tue, 26 Dec 2017 10:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bOeXcUFSPcYL/INDY8K0u6Y3QzO9btbGMfXeg29IN0s=;
        b=QXIxDqlh+5zG4F4V+BwVjyDbzSFiB1NGQmASbxPWdlD6eQas2bF/kPWLwRZcwT+DHZ
         o8do21arxgk51sSknd0RscgDuHlGpjK1bjf1lZv/nvfoZZphtq3FGxaD370LONvSVuku
         jixsIZvojHocjTnpOSGrZtM5ZlBe3o7UfN+VzaVwn0s5OMu8n+ZKaDPweqJBn0q3lvQY
         v3Yu41ZruCbLMak1ATOwWcwQSn4llzAj1SEJPV94LVycZGe6yLTgup8vedyjdRLGc00e
         sCyCn7vhj0xUuTVrAP5A/RCk94FsmCMkWVxo4vW8u/x4Sby+DgM56HCXC/PoQkCieWqV
         UepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bOeXcUFSPcYL/INDY8K0u6Y3QzO9btbGMfXeg29IN0s=;
        b=eLn7t3zFabOE2v2hu6G261Wvw3+C2OqMI4zXoNl/KlVcMvY6s5CnKypyH01o4UGMXe
         9MOD3ZUMdy2N7na3lOG+qaDQmMD3L9XwnLO2KG2gS0rNdUuAlXkquhHUuGDJ01i7EaMI
         C8gBOPt8hEwxUCpr1dh4i38pNF21GGv72jKXjpXcI3i+CfRvSikzdyEUFNBgH+vGiKSQ
         EsQ9oGOMkkYkJlEp+nb6dxzUXxrc4t+mKyp58gXBGFFDd4gX4u2+PVT+orKw0Hn/TM2X
         svu/bRY/JI7jdQPhYd2SUy61hR9DEqzdAx6/LZPV0oWkNd80hNvQhHo+47ouom3TyHww
         e8fg==
X-Gm-Message-State: AKGB3mK4Sx6EEsVD12LVtwm13jyE+qDZkLsxIOgxcpn8fC8o1AwhFNzH
        RW60AncSVEfyqmKD9u+gaOc=
X-Google-Smtp-Source: ACJfBouVwaogTfBbqeroEEXq7WbGFslJfp5hE2biMCjaRcfYz32q5tw1e4mhOKnRal1/MfQHPhYniA==
X-Received: by 10.25.217.129 with SMTP id s1mr9885060lfi.83.1514311572412;
        Tue, 26 Dec 2017 10:06:12 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id o188sm1160789lff.61.2017.12.26.10.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 10:06:11 -0800 (PST)
Date:   Tue, 26 Dec 2017 21:06:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, marcin.nowakowski@imgtec.com,
        f.fainelli@gmail.com, kumba@gentoo.org,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] MIPS memblock: Remove bootmem code and switch to NO_BOOTMEM
Message-ID: <20171226180622.GA31719@mobilestation>
References: <20171219201400.GA10185@mobilestation>
 <eace1075-4e3f-1f0c-50ed-73a566ecd39b@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eace1075-4e3f-1f0c-50ed-73a566ecd39b@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

On Fri, Dec 22, 2017 at 08:18:09AM +0100, Marcin Nowakowski <marcin.nowakowski@mips.com> wrote:
> Hi Serge,
> 
> On 19.12.2017 21:14, Serge Semin wrote:
> >Hello folks,
> >
> >Almost a year ago I sent a patchset to the Linux MIPS community. The main target of the patchset
> >was to get rid from the old bootmem allocator usage at the MIPS architecture. Additionally I had
> >a problem with CMA usage on my MIPS machine due to some struct page-related issue. Moving to the
> >memblock allocator fixed the problem and gave us benefits like smaller memory consumption,
> >powerful memblock API to be used within the arch code.
> >
> >@marcin.nowakowski@imgtec.com. Could you confirm if you are still interested in the patchset and
> >ready to update the Loongson64 platform code so one would be compatible with it?
> 
> I am currently working on different projects, but I will try to do my best
> to help with this (but just might require more time than I would otherwise
> need).
> Given the scale of the task and the amount of testing required, I expect
> that it will take a while to get a complete set of patches reviewed and
> tested which should hopefully be enough to fix support for all platforms
> affected.
> 

Hello Marcin,
Thanks for the willing to help. I'll CC the patchset to you when it's ready.

-Sergey

> Marcin
