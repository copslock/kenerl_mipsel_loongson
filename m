Return-Path: <SRS0=+lB5=UX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F807C43613
	for <linux-mips@archiver.kernel.org>; Mon, 24 Jun 2019 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D621520645
	for <linux-mips@archiver.kernel.org>; Mon, 24 Jun 2019 19:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfFXTQa (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:16:30 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:43528 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfFXTQa (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 24 Jun 2019 15:16:30 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993003AbfFXTQ3NGNHy (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Mon, 24 Jun 2019 21:16:29 +0200
Date:   Mon, 24 Jun 2019 20:16:29 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
cc:     Carlo Pisani <carlojpisani@gmail.com>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Joshua Kinard <kumba@gentoo.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: SGI-IP30
In-Reply-To: <20190624175553.2tpepq5zsamovrra@pburton-laptop>
Message-ID: <alpine.LFD.2.21.1906242014270.28103@eddie.linux-mips.org>
References: <b201c33a-5beb-3dfb-b99b-d9b8fc6c2c64@hauke-m.de> <CA+QBN9A3JmvfCZkXZ2-Yd=nkQCQD48OgYEpe+Po4MuZFpmnPrQ@mail.gmail.com> <20190624175553.2tpepq5zsamovrra@pburton-laptop>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, 24 Jun 2019, Paul Burton wrote:

> - Maciej W. Rozycki who seems to have an affinity for MIPS machines from
>   this era, or at least plenty of knowledge about them :)

 Thanks for your words of appreciation, however I have own no actual SGI 
system, so any my advice related to such hardware will be limited to the 
CPU only.  This may not help with a port moving forward.

  Maciej
