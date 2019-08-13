Return-Path: <SRS0=QBMR=WJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD36C433FF
	for <linux-mips@archiver.kernel.org>; Tue, 13 Aug 2019 15:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC37520874
	for <linux-mips@archiver.kernel.org>; Tue, 13 Aug 2019 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="d1cqyjnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfHMPJp (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:09:45 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:39579 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730064AbfHMPJo (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Tue, 13 Aug 2019 11:09:44 -0400
Received: from mxback17g.mail.yandex.net (mxback17g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:317])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 774754D4139F;
        Tue, 13 Aug 2019 18:09:42 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback17g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id nKRYGVDGLI-9fVehMtX;
        Tue, 13 Aug 2019 18:09:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1565708982;
        bh=qK+XsnqUe+pF4DvWMBiOclVfgGHLF6uESs5xLd8UPKI=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=d1cqyjnXkklZ7Y7GjZ38Bl0+P3mFVZnGzuN+x8eadFn44VpVwsIDrl7CpQrkNE73V
         U/geRwuutQ9TmowaPhKvU4VzoOx3+3xn+OxibU/Qdp0465CaurI/IgUZ/zgYnGwm7J
         Xv8QvZ+STLtIE9T4GVWLC8cMEVm6frgY9RTFXUJQ=
Authentication-Results: mxback17g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id fOcaaTtzkN-9WuOo41f;
        Tue, 13 Aug 2019 18:09:40 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [EXTERNAL]Drop boot_mem_map
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "yasha.che3@gmail.com" <yasha.che3@gmail.com>,
        "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "matt.redfearn@mips.com" <matt.redfearn@mips.com>,
        "chenhc@lemote.com" <chenhc@lemote.com>
References: <20190808075013.4852-1-jiaxun.yang@flygoat.com>
 <20190812045618.ncqtfm6qmia6cxaz@pburton-laptop>
 <ac8efbfe-be18-ca91-2060-2a8c601cbbd1@flygoat.com>
 <20190813083952.gg533rwix5ciclwc@mobilestation>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <c751783b-e0c1-f3c7-d59d-817ce400bfa3@flygoat.com>
Date:   Tue, 13 Aug 2019 23:09:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813083952.gg533rwix5ciclwc@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


On 2019/8/13 下午4:39, Serge Semin wrote:
> The cleanup you did is great! I was going to do this myself when get to have
> more free time. Thanks to you the only thing left is to review your work.
>
> Regarding the Paul' comment about the platforms source code buildability in
> patch 1. Alas it's a kernel patches requirement to leave the source code
> buildable and the kernel runnable after each patch [1].

Hi Serge:

Thanks for your remind.

I'm going to send v1 and correct the patch order after receiving your 
review tag.

> I am not sure about correct execution, but at least buildability can be reached
> just by moving the patch 1 to the tail of the series.
>
> Regarding the patches itself, I'll leave my comments inline within the
> corresponding emails.
>
> [1] https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L223

--

Jiaxun Yang

