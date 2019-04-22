Return-Path: <SRS0=LSmN=SY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240B8C10F11
	for <linux-mips@archiver.kernel.org>; Mon, 22 Apr 2019 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39BF214AF
	for <linux-mips@archiver.kernel.org>; Mon, 22 Apr 2019 17:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfDVReO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:34:14 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:36036 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDVReO (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 22 Apr 2019 13:34:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 29FCD3F37A;
        Mon, 22 Apr 2019 19:34:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0_GwYMl2zxKC; Mon, 22 Apr 2019 19:34:11 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 814833F3B2;
        Mon, 22 Apr 2019 19:34:11 +0200 (CEST)
Date:   Mon, 22 Apr 2019 19:34:11 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Subject: Re: [RFC] MIPS: Install final length of TLB refill handler rather
 than 256 bytes
Message-ID: <20190422173411.GB28106@sx9>
References: <20190405160531.GF33393@sx9>
 <5b42742e-b9fb-996a-fbe4-918d48aa0a18@amsat.org>
 <20190415152252.GA7205@sx9>
 <20190415171728.hzplt56qt2f5c7ab@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415171728.hzplt56qt2f5c7ab@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Paul,

> > Are any MIPS kernel maintainers happy to review an initial R5900 patch
> > submission?
> 
> Yes, please submit it if you think it's ready :)

Great! I need a few weeks to prepare the patches.

> That's true, and I don't have any real problem with it if you want to
> submit it without the RFC tag. The change does only really benefit the
> R5900 though so my preference would be that you include the patch as
> part of your series adding R5900 support.

Agreed!

Fredrik
