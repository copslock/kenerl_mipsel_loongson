Return-Path: <SRS0=ZcmI=YZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA4CCA9ECF
	for <linux-mips@archiver.kernel.org>; Fri,  1 Nov 2019 23:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE02620679
	for <linux-mips@archiver.kernel.org>; Fri,  1 Nov 2019 23:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572650874;
	bh=KN3WQXmsibFO8twacp2N/YdEY4mMgeHvP5tPKD2b0NM=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=N7YDwxNpEUQ+CrkAqxkn93DvXz5XzzhzJXmaI7PpPJbEQsujDMX8tu32EOQc9s7Zl
	 2hw+o+pU4JmdezziWKWSUdt6LeNfHjaxo8X/nx/VASsNIGFTzaT3ffgYUTlXqT+ba9
	 2v4yEjXYDOg5daF/pAC0p8kHTS8q3r3O70KwILpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfKAX1y (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Nov 2019 19:27:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33970 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAX1y (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 1 Nov 2019 19:27:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id x195so4556622pfd.1
        for <linux-mips@vger.kernel.org>; Fri, 01 Nov 2019 16:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=06oQR5SrM37qy3A4Fp0rhDuwDg2kkem19cyhrI1fnn8=;
        b=MmIOj8KZweQMEi1Djf9ZiqmmaspAOweCsYNV1ivrm005CSBVPPBx6CMMy2sC3bTrCT
         As532iKORS4sKJFiRtD901GlQ6Y6x2kIXVsz4eyAcDGdEDP5CxhUsSGlcov4uWoNMCCm
         DxAfIt5jz2VhUktl23xx84mMWD5eC27C/s8z6oAaT1ArzSWSvXduafvxPOTnlM4KuUcz
         ufOVyHerk89SWrxOvN/6G4gX9zTgz3g+aL7XZC35jQfqFpju4T6NInl+ZselP1lCnVvW
         +M+dQpo6SuJz3ZdD8ADhlLEtB72Yzvp74mQBjjr3xAcfF9u0A5J3DiFXx5HyFJ5dMYEn
         8YEA==
X-Gm-Message-State: APjAAAUW28voRF+5loNPf5sqw/FsGYHaVBTh3fkYtsBcuVqMFIKli+oM
        FFbgpC9FuVeZVilhnwDC1Xlk4zPcjdaC2g==
X-Google-Smtp-Source: APXvYqwcAUgejrq5XBntamc2ufG4FLCilwQ4sEWSvjYlrQ+G4ReMz0uhcxjCcKHLZAN6BWXb334Eow==
X-Received: by 2002:a63:fe0c:: with SMTP id p12mr16149712pgh.121.1572650872960;
        Fri, 01 Nov 2019 16:27:52 -0700 (PDT)
Received: from localhost ([2601:646:8a00:9810:9d6:9cca:ff8c:efe0])
        by smtp.gmail.com with ESMTPSA id u21sm17261143pjx.2.2019.11.01.16.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 16:27:52 -0700 (PDT)
Message-ID: <5dbcbf78.1c69fb81.86ca8.e144@mx.google.com>
Date:   Fri, 01 Nov 2019 16:27:51 -0700
From:   Paul Burton <paulburton@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     linux-mips@vger.kernel.org
CC:     chenhc@lemote.com, paul.burton@mips.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/6] MIPS: Loongson64: Rename CPU TYPES
References:  <20191020144318.18341-2-jiaxun.yang@flygoat.com>
In-Reply-To:  <20191020144318.18341-2-jiaxun.yang@flygoat.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Jiaxun Yang wrote:
> CPU_LOONGSON2 -> CPU_LOONGSON2EF
> CPU_LOONGSON3 -> CPU_LOONGSON64
> 
> As newer loongson-2 products (2G/2H/2K1000) can share kernel
> implementation with loongson-3 while 2E/2F are less similar with
> other LOONGSON64 products.

Applied to mips-next.

> commit 268a2d600130
> https://git.kernel.org/mips/c/268a2d600130
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
