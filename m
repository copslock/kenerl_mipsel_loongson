Return-Path: <SRS0=hzgf=TZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0B6C07542
	for <linux-mips@archiver.kernel.org>; Sat, 25 May 2019 17:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB51120862
	for <linux-mips@archiver.kernel.org>; Sat, 25 May 2019 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558804076;
	bh=1NOG9vvuSugzbmEHIFTbaXcD4xyXPjqW8u8Apo5aY6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xNPqypsmdZtoJtEatrZwwq/xgnXcyMnSFPKkht6HOusZIGUIupbIjVCJQ6sHScxQg
	 FXdDlq2hKYUIxrU3y1i22txf4DkzIseXeVNOni6d+OV0U3YmELRPIzBiXOn2F3giZu
	 XWllIiD7A/mIAepgsTxtDXkcyiyI1eeEOQP7t/aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfEYRHw (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 25 May 2019 13:07:52 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:42326 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfEYRHw (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 25 May 2019 13:07:52 -0400
Received: by mail-lf1-f49.google.com with SMTP id y13so9250011lfh.9
        for <linux-mips@vger.kernel.org>; Sat, 25 May 2019 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5ktK9kr4E0UpbbeaHLRBxZcSjVJhVPG4g8QF69sVmY=;
        b=blWPgG96+VVQqIzaWJtzwSPl1QZ1S0Z04iNWgu72UYrrEMJjAjb0uL1VklvosGRad1
         QjwqdkB2pvLto1OJmIjJxoAO0TOZpQ+qmzwwgKrs9zICCkP//YwaeBtPKJ0BOb1W3+mo
         iEJkOggeA90YvBtGTsZFgAObtE+OMxPecZ/Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5ktK9kr4E0UpbbeaHLRBxZcSjVJhVPG4g8QF69sVmY=;
        b=cSUlJWg8Y7ZRMkIauz5zRP/cqhbp330rjJ9k3DHQaUK3WKYLF5k9ol6wIp1qooDPLx
         +ASMHu6pO1HbbRTVOJkCUiiPqsNeXvGhN8DB44kIQMH2PiAHzIIAVFOmmcxbkCUS8Aow
         +tTYOj5XqwdZX3tvNdVsxIWF35QpN2njgZcCiV73dOjQ3lAm6fPQHyF0zz05Db9CAoe+
         D6Drtws0D25vvQK8u1aLtT0G2yu60zaAZhEpz3BZss8m5oY+l/Q9etjuEbqTgeP1bHj3
         lIvDoeWw5ag+q8SEnyY28G1EjGFxtH5c6mzKPSQY/eLFa13Txb3a7a80Y7bn6a1hzjR8
         HzHg==
X-Gm-Message-State: APjAAAUcScSwkd7Qj6nXewf6Ceok9i1aU5Xb66DlNkyWjGIxIBlMX/Ib
        c5G8/t1ke/VpW1XT9Ev7RaUeTyjOacM=
X-Google-Smtp-Source: APXvYqwI4nfbjY3ww+pzqPayIQ/EJvMiaI/0HebACNqQVB2ZNDLlBt6gThn6ri9JQVTX+Qy20n32xg==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr421008lfh.15.1558804069803;
        Sat, 25 May 2019 10:07:49 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w2sm1422938ljh.54.2019.05.25.10.07.48
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 10:07:49 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id n134so9257719lfn.11
        for <linux-mips@vger.kernel.org>; Sat, 25 May 2019 10:07:48 -0700 (PDT)
X-Received: by 2002:a19:be17:: with SMTP id o23mr28987773lff.170.1558804068519;
 Sat, 25 May 2019 10:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190525133203.25853-1-hch@lst.de>
In-Reply-To: <20190525133203.25853-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 May 2019 10:07:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7=yxWUwao10GfUvE1aecidtHm8TGTPAUnvg0kbH8fpA@mail.gmail.com>
Message-ID: <CAHk-=wi7=yxWUwao10GfUvE1aecidtHm8TGTPAUnvg0kbH8fpA@mail.gmail.com>
Subject: Re: RFC: switch the remaining architectures to use generic GUP
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Looks good to me apart from the question about sparc64 (that you also
raised) and requesting that interface to be re-named if it is really
needed.

Let's just do it (but presumably for 5.3), and any architecture that
doesn't react to this and gets broken because it wasn't tested can get
fixed up later when/if they notice.

              Linus
