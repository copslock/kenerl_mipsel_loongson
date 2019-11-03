Return-Path: <SRS0=LebK=Y3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FC6CA9EB0
	for <linux-mips@archiver.kernel.org>; Sun,  3 Nov 2019 23:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F51F2190F
	for <linux-mips@archiver.kernel.org>; Sun,  3 Nov 2019 23:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfKCXI3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 3 Nov 2019 18:08:29 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:33308 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfKCXI3 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 3 Nov 2019 18:08:29 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991035AbfKCXI0uVKha (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 4 Nov 2019 00:08:26 +0100
Date:   Sun, 3 Nov 2019 23:08:26 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-mips@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH 1/3] MIPS: Loongson: Remove Loongson-2E/2F support
In-Reply-To: <1572758417-29265-1-git-send-email-chenhc@lemote.com>
Message-ID: <alpine.LFD.2.21.1911032301160.367459@eddie.linux-mips.org>
References: <1572758417-29265-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sun, 3 Nov 2019, Huacai Chen wrote:

> Loongson-2E/2F is old, inactive and a bit ugly, so let's remove them
> and the world will be more comfortable.

 People still use them, e.g. I do, and upstream removal causes an issue
with the need to backport changes not specific to the platform.

 If you don't want to maintain the code, then just mark it orphan and rely 
on the community to maintain it.  If it starts breaking and nobody picks 
it to make fixes, then it can be removed.  There's no need to rush IMO.

 BTW, there used to be a patch somewhere to support more than 512MiB of 
DRAM with the 2E, but I can't find it -- can you help me tracking it down?

  Maciej
