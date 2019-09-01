Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC285C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 17:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E8920818
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 17:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfIARhB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 13:37:01 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:32587 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfIARhA (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 13:37:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id F0EA83F771;
        Sun,  1 Sep 2019 19:36:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oY_sST62O6du; Sun,  1 Sep 2019 19:36:58 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 3967A3F6FD;
        Sun,  1 Sep 2019 19:36:57 +0200 (CEST)
Date:   Sun, 1 Sep 2019 19:36:57 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mips@vger.kernel.org
Subject: Re: [PATCH 011/120] MIPS: R5900: Avoid pipeline hazard with the TLBP
 instruction
Message-ID: <20190901173657.GA24945@sx9>
References: <cover.1567326213.git.noring@nocrew.org>
 <d3b43e48be1b888c4bd675dc4c0633dc1e8fe791.1567326213.git.noring@nocrew.org>
 <314ae9e1-80d2-68f7-4942-c04e25dc60ef@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <314ae9e1-80d2-68f7-4942-c04e25dc60ef@cogentembedded.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Sergei,

> > +	case CPU_R5900:
> > +		/*
> > +		 * On the R5900, the TLBWP instruction must be immediately
> 
>    So is it TLBP or TLBWP?

TLBWP does not exist, so it must be TLBP. Thanks! :)

Fredrik
