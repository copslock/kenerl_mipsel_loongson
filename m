Return-Path: <SRS0=YN1v=YL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FCECA9EAB
	for <linux-mips@archiver.kernel.org>; Fri, 18 Oct 2019 22:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011DB20854
	for <linux-mips@archiver.kernel.org>; Fri, 18 Oct 2019 22:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436790;
	bh=qtv9h+m7YbhoXKnIAaWLxWoNCZHkolR7CUl1IzvIhxM=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=IgXcbBWukoSr5411ggGoAs6EeNlAgPxhyAzId+N3iqIC7E9E4hX2xnHcwXlj3DnjL
	 POkLvpUHudX1PXVonk4rB8TXmtIKLTqYW9ymheYxp/vzJ6LWR/PMJJvn+7PoE9UNlb
	 UkLyCsrPona3Uxk/iz4cWF5wy5Wpth4L4wh3h9KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391900AbfJRWNJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:13:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43728 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389659AbfJRWNI (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 18 Oct 2019 18:13:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so4071811pgl.10
        for <linux-mips@vger.kernel.org>; Fri, 18 Oct 2019 15:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=sr3QEcA3GgbqmcHwvh+Z+2ViZkXbU6OBPmKTa4Kdh54=;
        b=kcNlL9vmMqJCPFzcyCrqECrkjFLlsUG4KrkpVmVo5K+MJOyv347UEW3jolCgE+I3EL
         AqtpyHmnJEjZau5As22JugBDqkRCL9sMZPlR5yp01t9TbhwYEU/2BM7rU57i7Lszvyh1
         MVmbulp2ssBRdjkNgJueDc9Bs3l+3U4SZY4j/D/wWH7NrxrMGSlC1vjm6CRtfiMhT3l2
         w8ssSR7T7fHoA9OxJ5OrRB0H56CRa4XDi5pMHImX/IvlXxw3d9d4LeSddsZp672woKaB
         Sjxc0Ro6b/TDzE8Sb1am2cPrL7u8xN6ZKWDPkFzFbfpA6X1gfPNCjQ51eBcylHFWoxgm
         y4Uw==
X-Gm-Message-State: APjAAAUC/bUJ8d42h1H2DG36buJIkHLQvu7klo5tKCRanrbUCb9pUF8A
        3nnyxhgI7lXUdaXQ/e/ELkM+Wah/xTI=
X-Google-Smtp-Source: APXvYqwFHed22KJ6gNBnvH5Yve3z/t81DbdCa7zJk3vIPJnx0GwLKS8oU239J0UbK5J/x1JrXCCYHw==
X-Received: by 2002:aa7:9a0c:: with SMTP id w12mr9175579pfj.81.1571436787831;
        Fri, 18 Oct 2019 15:13:07 -0700 (PDT)
Received: from localhost ([172.58.38.188])
        by smtp.gmail.com with ESMTPSA id y129sm5772499pgb.28.2019.10.18.15.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:13:07 -0700 (PDT)
Message-ID: <5daa38f3.1c69fb81.bba20.f8ab@mx.google.com>
Date:   Fri, 18 Oct 2019 15:13:05 -0700
From:   Paul Burton <paulburton@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
CC:     linux-mips@vger.kernel.org
CC:     pburton@wavecomp.com, mbizon@freebox.fr, vincenzo.frascino@arm.com
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH] mips: vdso: Fix __arch_get_hw_counter()
References:  <20191016134024.46671-1-vincenzo.frascino@arm.com>
In-Reply-To:  <20191016134024.46671-1-vincenzo.frascino@arm.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Vincenzo Frascino wrote:
> On some MIPS variants (e.g. MIPS r1), vDSO clock_mode is set to
> VDSO_CLOCK_NONE.
> 
> When VDSO_CLOCK_NONE is set the expected kernel behavior is to fallback
> on syscalls. To do that the generic vDSO library expects UULONG_MAX as
> return value of __arch_get_hw_counter().
> 
> Fix __arch_get_hw_counter() on MIPS defining a __VDSO_USE_SYSCALL case
> that addressed the described scenario.

Applied to mips-fixes.

> commit 8a1bef4193e8
> https://git.kernel.org/mips/c/8a1bef4193e8
> 
> Reported-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Tested-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
