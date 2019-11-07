Return-Path: <SRS0=EWWg=Y7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22353C5DF60
	for <linux-mips@archiver.kernel.org>; Thu,  7 Nov 2019 11:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1B321882
	for <linux-mips@archiver.kernel.org>; Thu,  7 Nov 2019 11:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="fTqLKDMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfKGLrW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:47:22 -0500
Received: from forward105j.mail.yandex.net ([5.45.198.248]:43251 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbfKGLrW (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 7 Nov 2019 06:47:22 -0500
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id CBD9AB22347;
        Thu,  7 Nov 2019 14:47:19 +0300 (MSK)
Received: from mxback3q.mail.yandex.net (mxback3q.mail.yandex.net [IPv6:2a02:6b8:c0e:39:0:640:4545:437c])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id C8DFBCF40014;
        Thu,  7 Nov 2019 14:47:19 +0300 (MSK)
Received: from vla1-b617950fbd54.qloud-c.yandex.net (vla1-b617950fbd54.qloud-c.yandex.net [2a02:6b8:c0d:3495:0:640:b617:950f])
        by mxback3q.mail.yandex.net (mxback/Yandex) with ESMTP id 7Iix0pDqki-lJq8AxQu;
        Thu, 07 Nov 2019 14:47:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1573127239;
        bh=GbP+q3vNczyFL5igNpsNBuQtEr87kiPomvB6A7eQM4Y=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=fTqLKDMNDN3uyuE3MJNv83H0LAnXyXevqBcvOcXheAakhZiNTY6RobV1RsuAHsfjB
         p5bO+SogDSRoDjvnLGV/kTanpZHh5In0ZpTCO9KHCEizK8TnYFZml32FgO439QBJzr
         n/2t+cn7nA8u7+Ga62wMolpq5MgpyJKiRzbrLfFQ=
Authentication-Results: mxback3q.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by vla1-b617950fbd54.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id stihQb0LaY-lDYSlFjg;
        Thu, 07 Nov 2019 14:47:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH V2] MIPS: Loongson: Add board_ebase_setup() support
To:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Paul Burton <paulburton@kernel.org>, linux-mips@linux-mips.org,
        linux-mips@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
References: <1572847781-21652-1-git-send-email-chenhc@lemote.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <6f6ce0de-bad9-d1c4-f8d6-244b11eef0b1@flygoat.com>
Date:   Thu, 7 Nov 2019 19:47:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572847781-21652-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


ÔÚ 2019/11/4 ÏÂÎç2:09, Huacai Chen Ð´µÀ:
> Old processors before Loongson-3A2000 have a 32bit ebase register and
> have no WG bit, new processors since Loongson-3A2000 have a 64bit ebase
> register and do have the WG bit. Unfortunately, Loongson processors
> which have the WG bit are slightly different from MIPS R2. This makes
> the generic ebase setup not suitable for every scenarios.
> 
> To make Loongson's kernel be more robust, we add a board_ebase_setup()
> hook to ensure that CKSEG0 is always used for ebase. This is also useful
> on platforms where BIOS doesn't initialise an appropriate ebase.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

This patch is essential as most Loongson boards with Tianocore based
UEFI firmware didn't set their ebase correctly.

Should we backport it to stable?

--
Jiaxun Yang
