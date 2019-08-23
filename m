Return-Path: <SRS0=Xg03=WT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9752EC3A5A2
	for <linux-mips@archiver.kernel.org>; Fri, 23 Aug 2019 17:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB8D2133F
	for <linux-mips@archiver.kernel.org>; Fri, 23 Aug 2019 17:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="jUfPLKeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbfHWRgc (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 23 Aug 2019 13:36:32 -0400
Received: from forward106j.mail.yandex.net ([5.45.198.249]:46968 "EHLO
        forward106j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389882AbfHWRg3 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Fri, 23 Aug 2019 13:36:29 -0400
Received: from mxback16g.mail.yandex.net (mxback16g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:316])
        by forward106j.mail.yandex.net (Yandex) with ESMTP id B723911A0052;
        Fri, 23 Aug 2019 20:36:26 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback16g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Di3qhoV3bL-aPnKIDdf;
        Fri, 23 Aug 2019 20:36:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1566581786;
        bh=P3aDP7nZiXM3Ci1iJ/HB1DRtPsbO1Qvxn+leyUChYi8=;
        h=In-Reply-To:Cc:To:From:Subject:Date:References:Message-ID;
        b=jUfPLKeENvLpFcau8LQiI8zbA4Gp+TbyWjvChH5PMTfToNKCMtJbk1LPbraqbQ4N6
         RcHxaA3mD6Xsqlgt9YKCcEN1bC9E+lP65PDXl43H9uafSOTnhC/LufQZavdxHU4UTu
         zJuFZcvjkVKuybHQuE6bRPQAPFmVk6MZoaT1gYIA=
Authentication-Results: mxback16g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Y9UbYehodS-aKXC4AP4;
        Fri, 23 Aug 2019 20:36:24 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v1 0/8] MIPS: Drop boot_mem_map
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        "yasha.che3@gmail.com" <yasha.che3@gmail.com>,
        "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "matt.redfearn@mips.com" <matt.redfearn@mips.com>,
        "chenhc@lemote.com" <chenhc@lemote.com>
References: <20190819142313.3535-1-jiaxun.yang@flygoat.com>
 <CY4PR2201MB1272B48BC8DCEACB50038F09C1A40@CY4PR2201MB1272.namprd22.prod.outlook.com>
 <783425a8-3067-f61b-9f7f-e01ca7fed121@flygoat.com>
Message-ID: <b4f7afab-ec17-6904-eb91-26cb629ed6c0@flygoat.com>
Date:   Sat, 24 Aug 2019 01:36:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <783425a8-3067-f61b-9f7f-e01ca7fed121@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


On 2019/8/24 上午1:20, Jiaxun Yang wrote:
>
> On 2019/8/23 下午10:45, Paul Burton wrote:
>> Hello,
>>
>> Jiaxun Yang wrote:
>>> v1: Reording patches, fixes according to Serge's suggestions,
>>> fix maar section mismatch.
>>>
>>> Jiaxun Yang (8):
>>>    MIPS: OCTEON: Drop boot_mem_map
>>>    MIPS: fw: Record prom memory
>>>    MIPS: malta: Drop prom_free_prom_memory
>>>    MIPS: msp: Record prom memory
>>>    MIPS: ip22: Drop addr_is_ram
>>>    MIPS: xlp: Drop boot_mem_map
>>>    MIPS: mm: Drop boot_mem_map
>>>    MIPS: init: Drop boot_mem_map
>>>
>>>   arch/mips/cavium-octeon/dma-octeon.c |  17 +-
>>>   arch/mips/cavium-octeon/setup.c      |   3 +-
>>>   arch/mips/fw/arc/memory.c            |  24 +-
>>>   arch/mips/include/asm/bootinfo.h     |  16 --
>>>   arch/mips/include/asm/maar.h         |   8 +-
>> Series applied to mips-next.
>
> Sorry Paul, there are some build issues suggested by kbuild test boot, 
> I'm going to send v2 later.
>
Or you can simply fix them and apply again...

Sorry for the stupid problems. I should test with varies of configs 
before send them out.

I promise that won't happen again.

--

Jiaxun Yang


