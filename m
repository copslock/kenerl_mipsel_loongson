Return-Path: <SRS0=atGi=TI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E1C04A6B
	for <linux-mips@archiver.kernel.org>; Wed,  8 May 2019 06:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FB9214AF
	for <linux-mips@archiver.kernel.org>; Wed,  8 May 2019 06:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cGRjzaKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEHGQd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 8 May 2019 02:16:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEHGQd (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 8 May 2019 02:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ndZNRMuUqSNYtmyN4GBrkeNpOsJgEkpFgSfZUqvewUc=; b=cGRjzaKSVkWqiP0GA7heiJYCz
        mAX6zA1sxguiAYOKfuqN1HeVocER9T/4vwoAupMAXWNGZXkggge1fFMoDQ5ONvAOqc1eOBaUo1HeY
        V/1Sags+lJMiHFniREHnlQwPRzBSIM69HEudHPCkCo3RxqBbINLFQpOqr517YToOlNwwz+SOd/CCY
        JO3/33vg1EVkCBdX2NwlrPT45kAImo2IGjWI3vk0sB0pJJnLZR+ZP3QMLqpoBMyVFhQe+XeZINn3J
        ZyhOEq0wO89o94QTzHVigMptqGzRy+X2L9HzBmjB4mvR5G6nPqQJz6tLdvE7LzBIH4FWUeo+dPCd4
        W49SEi15Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOFsT-00089A-A7; Wed, 08 May 2019 06:16:29 +0000
Date:   Tue, 7 May 2019 23:16:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/3] MIPS: SGI-IP27 rework part2
Message-ID: <20190508061629.GA19227@infradead.org>
References: <20190507210917.4691-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507210917.4691-1-tbogendoerfer@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, May 07, 2019 at 11:09:12PM +0200, Thomas Bogendoerfer wrote:
> SGI IP27 (Origin/Onyx2) and SGI IP30 (Octane) have a similair

Typo s/similair/similar/

> architecture and share some hardware (ioc3/bridge). To share

Isn't much of this also shared by IP35, the next generation Origin/Onyx
and and co?  A quick web search shows there even is an early port to
IP35 here:

http://git.linux-mips.org/cgit/nyef/linux-ip35/log/?h=sgi-ip35-v4.2-2015-10-24
