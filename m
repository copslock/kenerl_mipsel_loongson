Return-Path: <SRS0=99me=YR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00948CA9EAF
	for <linux-mips@archiver.kernel.org>; Thu, 24 Oct 2019 05:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA4E20679
	for <linux-mips@archiver.kernel.org>; Thu, 24 Oct 2019 05:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571893363;
	bh=RsYPue2XtyV4n8uczmn7omnYOTAAIS2eoViWxNkhkqk=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=wwER4lApXZn0Crhy2wfloMKg9L3bPvGdtxbULNVZGNd9dEjG2ufWZI+ARY276jf3M
	 v7ytlMXXsXYMAsC8d7/a2iEN7zpeObD+2YB1QgXiCQBGPh3zb3jvWu9oLyycVA+Ocl
	 ht17qr0hU2/GM2tFJ6hChfBaGGv3WsjBxngUPCKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437438AbfJXFCn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:02:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44075 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfJXFCn (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 24 Oct 2019 01:02:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so13462372pgd.11
        for <linux-mips@vger.kernel.org>; Wed, 23 Oct 2019 22:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=IPZJyobdu7JiI0Yobf+//me9Y0rqIjfI49OV/2ZZO4g=;
        b=cVjPv+uHP1PNi5w/S6aaAiTDYb7NAVf4cGTrYU8pZPUXYUh7Ss3iZy0noWLGJjlT39
         cgm6Ie2pnT4OC0a4NUAnaFFBVuRnrXDhkbVUfLMmqKsx9U5tED8oJPu6jVOsUaCibZ91
         PMCQDXmlu/ymSG+wmR82ABmIoctDKB77S+rOmLn/+F6ii86Zur+PglY6FyqR7LyLOule
         kVwYoXecPCyar8ee1eibTOIedVYbYZa15oQvVgMLI5OQXeZc/Y0gYD1k1WXioZ2DUWzB
         GTYpxoS6cS9ZqgkNqaKcXE190akeXIED1FEgr+8nnG35wot1R9WqtBgribqhKgefIfwF
         8QkA==
X-Gm-Message-State: APjAAAW51mQYMi9PPvimtrqMrcGsD0I38FqePTl8sEbgMGuHX0xpZfYG
        Sj6uRGL1LuEZhytzKB2l4HU=
X-Google-Smtp-Source: APXvYqyJXKOhXLnYkFkmhxPTJ4l/I/lPVKMHI0VZqsf2iKx98jjUhQGH9Xs/rQrNlpEZHwC1qtv6hQ==
X-Received: by 2002:a17:90a:5d04:: with SMTP id s4mr4536266pji.125.1571893362373;
        Wed, 23 Oct 2019 22:02:42 -0700 (PDT)
Received: from localhost ([2601:646:8a00:9810:5cfa:8da3:1021:be72])
        by smtp.gmail.com with ESMTPSA id n23sm23322027pff.137.2019.10.23.22.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 22:02:41 -0700 (PDT)
Message-ID: <5db13071.1c69fb81.1458d.eae6@mx.google.com>
Date:   Wed, 23 Oct 2019 22:02:41 -0700
From:   Paul Burton <paulburton@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
CC:     chenhc@lemote.com
CC:     chenhuacai@gmail.com, jhogan@kernel.org, jiaxun.yang@flygoat.com,
        linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        paul.burton@mips.com, ralf@linux-mips.org, wuzhangjin@gmail.com,
        zhangfx@lemote.com, Rikard Falkeborn <rikard.falkeborn@gmail.com>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: Loongson: Fix GENMASK misuse
References:  <20191022192547.480095-1-rikard.falkeborn@gmail.com>
In-Reply-To:  <20191022192547.480095-1-rikard.falkeborn@gmail.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Rikard Falkeborn wrote:
> Arguments are supposed to be ordered high then low.

Applied to mips-next.

> commit e02d026f08f1
> https://git.kernel.org/mips/c/e02d026f08f1
> 
> Fixes: 6a6f9b7dafd50efc1b2 ("MIPS: Loongson: Add CFUCFG&CSR support")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> Reviewed-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
