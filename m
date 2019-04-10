Return-Path: <SRS0=erdp=SM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E254C10F11
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 06:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F502083E
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 06:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RZyKzm4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDJGyo (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:54:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfDJGyo (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 10 Apr 2019 02:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=RZyKzm4u2hUpCKwebzI9rBT0V
        byzRMZTGU0wgRy/lta/IQ19i/ckswBwNHrr6CU+KJYzOzbVzrho7ndTkMN/HPOq9dQ7vDLXInFOHt
        mJX1BQ+7Ohgws7S1+JkKp0YgGfpb6zyPAEiWUukc8uZS9Tehszwf9N+2JCACMK1JOVHcCfQivq8Yf
        OZq2LYHbZMrt9+ZHOMk/AZmcwvECPoO+0kGqbylgtPsPFMyp+jjaMbDHynui5BOKWAndOs4vdKxFp
        3cvEWOBb4gThZA0XlBRs/6wxx9YpfZWxYw3T8MogZisEhC3ZR2QScAjwTzpw2nWeu7hM4VHmjuiSt
        Q/mBi9S7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE781-0000uJ-83; Wed, 10 Apr 2019 06:54:37 +0000
Date:   Tue, 9 Apr 2019 23:54:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 1/5] mm, fs: Move randomize_stack_top from fs to mm
Message-ID: <20190410065437.GB2942@infradead.org>
References: <20190404055128.24330-1-alex@ghiti.fr>
 <20190404055128.24330-2-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404055128.24330-2-alex@ghiti.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
