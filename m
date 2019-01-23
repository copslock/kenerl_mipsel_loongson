Return-Path: <SRS0=SfrM=P7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D385FC282C3
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 00:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C08621726
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 00:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="JXl0qaN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfAWAT5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:19:57 -0500
Received: from forward104p.mail.yandex.net ([77.88.28.107]:48010 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfAWAT5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 19:19:57 -0500
Received: from mxback7g.mail.yandex.net (mxback7g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:168])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id E52B24B02BE4;
        Wed, 23 Jan 2019 03:19:53 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback7g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mZN1oRCSUn-JrKKplnf;
        Wed, 23 Jan 2019 03:19:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548202793;
        bh=QdgGDMcfs8D/6/3N1nNeo8exzsuSSrLRy8KRb1s1W80=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:Message-ID;
        b=JXl0qaN25Lx+qbEc/RiBUjl2046YoIu6iBIgVYmAk/PpKgl6xoq5p6Hpm08h466Qf
         bh2jZ/r4pjk7C1KKN8bigYlucjqwPp8056fHs1yooD1G/S2WDLRZSkVpvxQOPZBjuf
         Hwc1CzckYaJcf0mEtvOkK/NUZ5b8r4J7e/yB0J84=
Authentication-Results: mxback7g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id l9DH5z0c2Z-JqGeTUUn;
        Wed, 23 Jan 2019 03:19:52 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Wed, 23 Jan 2019 08:19:44 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190122173934.g4xbqsq43w7hkwy6@pburton-laptop>
References: <20190122130415.3440-1-jiaxun.yang@flygoat.com> <20190122130415.3440-2-jiaxun.yang@flygoat.com> <20190122173934.g4xbqsq43w7hkwy6@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/6] MIPS: Loongson32: workaround di issue
To:     Paul Burton <paul.burton@mips.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "keguang.zhang@gmail.com" <keguang.zhang@gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <B8246DC0-2BFE-4FEA-914B-FA86CE78267A@flygoat.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



On January 23, 2019 1:39:36 AM GMT+08:00, Paul Burton <paul=2Eburton@mips=
=2Ecom> wrote:
>Hi Jiaxun,
>
>
>
>Thanks for your patches=2E
>
>Since this bug exists on both Loongson 1 CPUs & Loongson 3 CPUs, I'm
>wondering whether it also exists on Loongson 2 CPUs=2E Do you happen to
>know whether that is the case=EF=BC=9F

Early Loongson-2 such as Loongson-2E/F/G/H does not have di/ei instruction=
s=EF=BC=8C they are not R2 compatible=2E

The latest Loongson-2K1000 have the same di/ei bug but it hasn't been subm=
itted to the mainline=2E

Thanks


>
>Thanks,
>    Paul

--=20
Jiaxun Yang
