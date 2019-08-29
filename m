Return-Path: <SRS0=4KhX=WZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A67DC3A59F
	for <linux-mips@archiver.kernel.org>; Thu, 29 Aug 2019 11:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6665720828
	for <linux-mips@archiver.kernel.org>; Thu, 29 Aug 2019 11:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfH2LiT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:38:19 -0400
Received: from elvis.franken.de ([193.175.24.41]:39765 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfH2LiS (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 29 Aug 2019 07:38:18 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1i3Ikr-0000FK-01; Thu, 29 Aug 2019 13:38:17 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 5E222C2767; Thu, 29 Aug 2019 13:33:20 +0200 (CEST)
Date:   Thu, 29 Aug 2019 13:33:20 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tommy Jin <tjin@wavecomp.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Zhongwu Zhu <zzhu@wavecomp.com>
Subject: Re: [PATCH] MIPS64: add KASAN support
Message-ID: <20190829113320.GB9113@alpha.franken.de>
References: <1566894474-31011-1-git-send-email-tjin@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566894474-31011-1-git-send-email-tjin@wavecomp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, Aug 27, 2019 at 08:28:38AM +0000, Tommy Jin wrote:
> +/* 64-bit segment value. */
> +#define XKPHYS_CACHE_SEG	(0xa8)

that's just cachable coherent exclusive on write, what about
cachable non coherent (0x98) and cachable exclusive (0xa0) ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
