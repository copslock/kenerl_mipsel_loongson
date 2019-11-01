Return-Path: <SRS0=ZcmI=YZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C15CA9ECF
	for <linux-mips@archiver.kernel.org>; Fri,  1 Nov 2019 23:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE7621897
	for <linux-mips@archiver.kernel.org>; Fri,  1 Nov 2019 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572650883;
	bh=kewpRN3e+FHUGQZGjOBlY0BFbAOZeKDPNdnGwrEDbSA=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=W7/g3rYGkkx2p2XbmDi1RIQ1DMpXr8Xbqb88wkXJbX6N9pisJjMQOhUhbMpKyPfZv
	 3udYm79qFmo9NmqSj6KM2m41zlKYq6cgObOhZsnV5K1X9A+TEMv6IILtKkl0PJXYx+
	 NkmvvmXmspIkmgKL5X4n0lpnRW+tdE8hjKfUQE/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfKAX2D (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Nov 2019 19:28:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35846 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAX2C (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 1 Nov 2019 19:28:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so4997644plp.3
        for <linux-mips@vger.kernel.org>; Fri, 01 Nov 2019 16:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=Sitk5lEqQu27AK/EpTTHuVCWiR7rvbBvIHITsD69UuQ=;
        b=kqAkG/HAOY6HUibhWpPG6gAYRMh7RikIxMcgjJ2DInVrPYkLAB/H/U8eCVMIkavRig
         aXTzy91iqLol7DOpWMYs5J9kVhFvRXw04YFVqcSjj+aVa4s/Vtc9wKkk9xVL/aobhsdg
         ewXPzDLuvf/FZ1LfQSHIaE06pmEMt3vIznHJPkQKAIS7l/vaURpRbpq74pz3xLbkOztC
         +qvzc/ust5fsdWuf+tdJLUh8KwyZdgqh8o1q8XYFm0C7P3sZ/0EWSw0jFcXFWEBvs9UA
         oxQvEHSjrNL+tR/IuIxIvuAROLALij6p56UzLoJgS3ez6cv0xuDdNoLzqe1Xca8DFD72
         W/hQ==
X-Gm-Message-State: APjAAAVu7vNe+MNN5FKgcSrcjZLB5PBf6DQZ0xd8cA/Ow1xb0H/KiDXr
        ES4qeJdvC6fqSI1AmHYXr2I4LFkwdwLm6w==
X-Google-Smtp-Source: APXvYqy3O/GJR3lURm8ryIyI0koqU65uG+Vwa/UM2jv9IvfkYjCmqO386YeNdJx45tL+Le/uoxNZ7A==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr15169592plf.239.1572650882061;
        Fri, 01 Nov 2019 16:28:02 -0700 (PDT)
Received: from localhost ([2601:646:8a00:9810:9d6:9cca:ff8c:efe0])
        by smtp.gmail.com with ESMTPSA id s11sm8486333pjp.26.2019.11.01.16.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 16:28:01 -0700 (PDT)
Message-ID: <5dbcbf81.1c69fb81.23dfc.9b8a@mx.google.com>
Date:   Fri, 01 Nov 2019 16:28:01 -0700
From:   Paul Burton <paulburton@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     linux-mips@vger.kernel.org
CC:     chenhc@lemote.com, paul.burton@mips.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH 4/6] MIPS: Loongson64: Cleanup unused code
References:  <20191020150137.19256-1-jiaxun.yang@flygoat.com>
In-Reply-To:  <20191020150137.19256-1-jiaxun.yang@flygoat.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Jiaxun Yang wrote:
> Clean up legacy code after stripping out Loongson2ef code.

Applied to mips-next.

> commit 1bdb7b76705a
> https://git.kernel.org/mips/c/1bdb7b76705a
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
