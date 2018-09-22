Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Sep 2018 21:24:48 +0200 (CEST)
Received: from mail-ot1-x343.google.com ([IPv6:2607:f8b0:4864:20::343]:36343
        "EHLO mail-ot1-x343.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993060AbeIVTYpJZ3rW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 22 Sep 2018 21:24:45 +0200
Received: by mail-ot1-x343.google.com with SMTP id w17-v6so16274268otk.3
        for <linux-mips@linux-mips.org>; Sat, 22 Sep 2018 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=jgDbLxFGMh9wYyda9+QvM/Jo2YW19tN9kX5vB0mfvjQ=;
        b=BAf1N0qO+v3QAHNby4aBjph0Vmtbfw3fHgQYR0fIbiFIrpB0BShpj2PL/AYbb41JlK
         hpjRprC+WIyvS1wnZU6QWSl9Fmj27pByW2Ud1mnKSi2NuwcSbiwAbWc2YE9CO4l+OmCi
         mvhov7+U1YIXOWWQ6+MAyiaSo2B15ejXumreIp+eAHRisv191DbXux8UDVMyHs03yd/y
         Phi7xicSU645huDhjE2EKR11ozs/0hPgfJQME/zCgkgZUmR4ZkFjSE8dcE/6CsevFQNm
         QgNhenJkbM0kqwvU1+jVnMwX31f1y+g9TmJ8/MdvTKaK8QqJnCCZUexEp2mPzyswo2fb
         I3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=jgDbLxFGMh9wYyda9+QvM/Jo2YW19tN9kX5vB0mfvjQ=;
        b=NR/b/8ke60ozB5nugr2a9kwlo6TZJj2OWbx4R3tBqY5hjuz+gYZbgboczKarkW8Gm4
         ZHrXGYw158PM4fYohslkw9heVdaj4Kk6ga64hnuvrJrOUMzFopyy7aqR9jhYmUo3D1pH
         jHC6om4ggSAy1V6Cawi3kXxccY53Zzz8BOwcbhhF3atpylOsj8ruwyNXf7ZMEosDapsW
         KOmG14aC1ucKfkFbonr56O8ToP1zf40J8lz5rmFynU+4R80TmV8JmClJzV1bgf8BwJUu
         Pdzo6MhT72524cT843LZofDqlFU0OhLYI9HiQf/JsDCwVkBeL7ajPYFyoe4BufmjboRh
         yrbA==
X-Gm-Message-State: ABuFfoh3vLy+GzYTkxGV/yH5V98XmCkcNkCvbCyM2d18Z+A2Ikovkhqo
        EgKhY1PX72SNG9/54ucKREQ=
X-Google-Smtp-Source: ACcGV60FpWLjz8VN6sMB6BxXhgt2180XDPX0ZuewPnHNNviXDY0jATPuZpiMMxu5nJC/P3oweJIW9g==
X-Received: by 2002:a9d:6554:: with SMTP id q20-v6mr2292044otl.209.1537644278671;
        Sat, 22 Sep 2018 12:24:38 -0700 (PDT)
Received: from nexus5x-flo.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id a3-v6sm6082001otd.17.2018.09.22.12.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 12:24:37 -0700 (PDT)
Date:   Sat, 22 Sep 2018 12:24:33 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180921194218.at7ejkmmiucmawzo@pburton-laptop>
References: <20180911090049.10747-1-hch@lst.de> <20180921061052.GA13705@lst.de> <20180921194218.at7ejkmmiucmawzo@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH, for-4.19] dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
To:     Paul Burton <paul.burton@mips.com>, Christoph Hellwig <hch@lst.de>,
        Kevin Cernekee <cernekee@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <62B54A6B-6E10-4A40-8E61-C1D23A853816@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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



On September 21, 2018 12:42:20 PM PDT, Paul Burton <paul.burton@mips.com> wrote:
>Hi Christoph,
>
>On Fri, Sep 21, 2018 at 08:10:52AM +0200, Christoph Hellwig wrote:
>> Paul, other mips folks, any comments?
>> 
>> At this point I'm tempted to just move it to 4.20 and add a stable
>> tag given that no one cared so far.
>
>Copying Kevin & Florian as maintainers of the affected BMIPS systems in
>case they have anything to add.
>
>> On Tue, Sep 11, 2018 at 11:00:49AM +0200, Christoph Hellwig wrote:
>> > The patch adding the infrastructure failed to actually add the
>symbol
>> > declaration, oops..
>> > 
>> > Fixes: faef87723a ("dma-noncoherent: add a
>arch_sync_dma_for_cpu_all hook")
>> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>> > ---
>> >  kernel/dma/Kconfig | 3 +++
>> >  1 file changed, 3 insertions(+)
>> > 
>> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
>> > index 9bd54304446f..1b1d63b3634b 100644
>> > --- a/kernel/dma/Kconfig
>> > +++ b/kernel/dma/Kconfig
>> > @@ -23,6 +23,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
>> >  	bool
>> >  	select NEED_DMA_MAP_STATE
>> >  
>> > +config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
>> > +	bool
>> > +
>> >  config DMA_DIRECT_OPS
>> >  	bool
>> >  	depends on HAS_DMA
>
>The change looks reasonable to me, so feel free to take your choice of:
>
>    Reviewed-by: Paul Burton <paul.burton@mips.com>
>    Acked-by: Paul Burton <paul.burton@mips.com>
>
>My thought would be that it would be ideal to fix in 4.19 since that's
>where the breakage is, but having said that I don't have much insight
>into how bad the breakage is for the affected systems.


AFAIR, DMA corruption is typically what you would observe, which could prove difficult if you are not exactly looking for it. In any case, I don't have a BMIPS system running 4.19 right now to exercise this on, but this looks correct:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
