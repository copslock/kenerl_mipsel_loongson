Return-Path: <SRS0=vFX3=O2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3C1C43387
	for <linux-mips@archiver.kernel.org>; Mon, 17 Dec 2018 09:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BDA2084D
	for <linux-mips@archiver.kernel.org>; Mon, 17 Dec 2018 09:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeLQJNZ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:13:25 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:64398 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLQJNZ (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 17 Dec 2018 04:13:25 -0500
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id E77ED4B3E2;
        Mon, 17 Dec 2018 10:13:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id sB5SAam41ILG; Mon, 17 Dec 2018 10:13:13 +0100 (CET)
Subject: Re: MIPS (mt7688): EBase change in U-Boot breaks Linux
To:     Paul Burton <paul.burton@mips.com>
Cc:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <e4f0fff9-a3c5-85ce-c4be-6e0aa0f74592@denx.de>
 <d81ac18d-47ed-02ec-bc37-f5a7e0ab9223@gmail.com>
 <543512d8-91ea-2a49-5423-680860c0ba9f@denx.de>
 <CACUy__X434rmJnX96i057-ir8yiCBjMac_V41HJ+pyG0xLPcRg@mail.gmail.com>
 <dad02a31-ed34-f99a-26c5-60e4a7209057@denx.de>
 <CACUy__XtyDY08KTTMnKoXXKq4oUrNYdRXZOmtuXEmnfD7UveiA@mail.gmail.com>
 <20181213194740.mtphrijpnkzo2za4@pburton-laptop>
 <4ff76006-c524-ebaa-235a-6b253ce9cc09@denx.de>
 <20181214213109.3u37o7azx2jstg2d@pburton-laptop>
From:   Stefan Roese <sr@denx.de>
Message-ID: <bd197037-3eec-c3ef-6339-8320724409ee@denx.de>
Date:   Mon, 17 Dec 2018 10:13:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181214213109.3u37o7azx2jstg2d@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Paul,

On 14.12.18 22:31, Paul Burton wrote:
> On Fri, Dec 14, 2018 at 07:56:59AM +0100, Stefan Roese wrote:
>> So how to proceed? Should I enable CONFIG_CPU_MIPSR2_IRQ_VI or #define
>> "cpu_has_veic" to 1 as Lantiq does?
> 
> ...and on that point in particular, it really depends on your hardware.
> 
> You shouldn't need to do either of those things just to avoid this bug,
> but if your hardware actually supports VI or EIC then it may be
> beneficial to enable them.

Checking again, the MT7688 supports VI. config3=00002420, so VInt (Bit 5)
is set. But without CONFIG_CPU_MIPSR2_IRQ_VI being set, cpu_has_vint will
stay set to zero. So it seems that I need set CONFIG_CPU_MIPSR2_IRQ_VI
at least for this SoC (CONFIG_SOC_MT7620) if not even for all Ralink
based SoC's.

If nobody objects, I'll submit a patch enabling CONFIG_CPU_MIPSR2_IRQ_VI
for CONFIG_SOC_MT7620.

Thanks,
Stefan
