Return-Path: <SRS0=kRNa=WK=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A5C433FF
	for <linux-mips@archiver.kernel.org>; Wed, 14 Aug 2019 14:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0681C2083B
	for <linux-mips@archiver.kernel.org>; Wed, 14 Aug 2019 14:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHNO3R (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:29:17 -0400
Received: from elvis.franken.de ([193.175.24.41]:33402 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfHNO3R (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:17 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1hxuGx-0005Vf-00; Wed, 14 Aug 2019 16:29:07 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 91682C25C0; Wed, 14 Aug 2019 16:28:28 +0200 (CEST)
Date:   Wed, 14 Aug 2019 16:28:28 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     aurelien@aurel32.net, paul.burton@mips.com, sfr@canb.auug.org.au,
        chenhc@lemote.com, Serge Semin <fancer.lancer@gmail.com>,
        yasha.che3@gmail.com, matt.redfearn@mips.com,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 3/7] MIPS: fw: Record prom memory
Message-ID: <20190814142828.GA1568@alpha.franken.de>
References: <20190814172100.KtYqTGuD@smtp2o.mail.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814172100.KtYqTGuD@smtp2o.mail.yandex.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Aug 14, 2019 at 10:20:48PM +0800, Jiaxun Yang wrote:
> Hi Thomas
> 
> I can see only two ROM DATA maps in your system.
> As we're only recording ROM DATA here, rest types of memory will be handled
> by memblock.

ok, sorry for the noise.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
