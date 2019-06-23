Return-Path: <SRS0=DK7y=UW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29307C48BE4
	for <linux-mips@archiver.kernel.org>; Sun, 23 Jun 2019 18:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F08620645
	for <linux-mips@archiver.kernel.org>; Sun, 23 Jun 2019 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfFWSZD (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 23 Jun 2019 14:25:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43474 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWSZD (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 23 Jun 2019 14:25:03 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B318A1263F1F8;
        Sun, 23 Jun 2019 11:25:02 -0700 (PDT)
Date:   Sun, 23 Jun 2019 11:25:02 -0700 (PDT)
Message-Id: <20190623.112502.1981269479319700405.davem@davemloft.net>
To:     paul.burton@mips.com
Cc:     macro@linux-mips.org, netdev@vger.kernel.org, pburton@wavecomp.com,
        Sergey.Semin@t-platforms.ru, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FDDI: defza: Include linux/io-64-nonatomic-lo-hi.h
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190620221224.27352-1-paul.burton@mips.com>
References: <20190620221224.27352-1-paul.burton@mips.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 23 Jun 2019 11:25:03 -0700 (PDT)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>
Date: Thu, 20 Jun 2019 22:13:58 +0000

> Currently arch/mips/include/asm/io.h provides 64b memory accessor
> functions such as readq & writeq even on MIPS32 platforms where those
> accessors cannot actually perform a 64b memory access. They instead
> BUG(). This is unfortunate for drivers which either #ifdef on the
> presence of these accessors, or can function with non-atomic
> implementations of them found in either linux/io-64-nonatomic-lo-hi.h or
> linux/io-64-nonatomic-hi-lo.h. As such we're preparing to remove the
> definitions of these 64b accessor functions for MIPS32 kernels.
> 
> In preparation for this, include linux/io-64-nonatomic-lo-hi.h in
> defza.c in order to provide a non-atomic implementation of the
> readq_relaxed & writeq_relaxed functions that are used by this code. In
> practice this will have no runtime effect, since use of the 64b accessor
> functions is conditional upon sizeof(unsigned long) == 8, ie. upon
> CONFIG_64BIT=y. This means the calls to these non-atomic readq & writeq
> implementations will be optimized out anyway, but we need their
> definitions to keep the compiler happy.
> 
> For 64bit kernels using this code this change should also have no effect
> because asm/io.h will continue to provide the definitions of
> readq_relaxed & writeq_relaxed, which linux/io-64-nonatomic-lo-hi.h
> checks for before defining itself.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
 ...
> Maciej, David, if you'd be happy to provide an Ack so that I can take
> this through the mips-next branch that would be great; that'll let me
> apply it prior to the asm/io.h change.

Acked-by: David S. Miller <davem@davemloft.net>
