Return-Path: <SRS0=sCPg=YD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35466C4360C
	for <linux-mips@archiver.kernel.org>; Thu, 10 Oct 2019 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11E32067B
	for <linux-mips@archiver.kernel.org>; Thu, 10 Oct 2019 13:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rdoak4lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfJJNxL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:53:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJJNxL (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 10 Oct 2019 09:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PhUnO+WIb25shMCfz6QmMOJuVwQTh3wAzjMfnDJXYUY=; b=Rdoak4lpexVX/qGtL9iLpUhgq
        7QpVg+i60M+fTGmAQBz2tNMhVAt6eQUc5SHCu9lRUACtMz5kDJmZw5fAT55qaPlWM6zdCQeehHsVP
        8F4ZAS+zWvgruin6D23DawDDv+fj2mCJN/WKy1sYLXLytXIfg8kQsDmUOvYszsgf8QEYQDvuyUQJj
        zgDtiRqjyAzK4QWbEns3YlzH2xKFpAp6Vt7Zaq0I6Wdc3jbm3/zc6Ao+2a8qBkk7IEs1sqSI+ruSb
        9Fz1HhZlWOSSWaMHD83c8tNUO2OHtFciCr6GODEBPrJaG+30Vp3WaI6v74MJ+KfhpvTSvite/m/8b
        GJEVqRlWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIYsO-0000bh-V7; Thu, 10 Oct 2019 13:53:08 +0000
Date:   Thu, 10 Oct 2019 06:53:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: add support for SGI Octane (IP30)
Message-ID: <20191010135308.GA2052@infradead.org>
References: <20191009155928.3047-1-tbogendoerfer@suse.de>
 <20191009184311.GA20261@infradead.org>
 <20191010150136.a30e47b37f8c8aed9e863a5e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010150136.a30e47b37f8c8aed9e863a5e@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Oct 10, 2019 at 03:01:36PM +0200, Thomas Bogendoerfer wrote:
> ok, as far as I can anticipate IP35 verion of this functions will be
> the same as well. So I'll move both into pci-xtalk-bridge.c in the
> next version of the patch.

Sounds good.  In fact you probably want to send a prep patch just
moving pci-ip27.c to pci-xtalk-bridge.c and adding a new
CONFIG_MIPS_PCI_XTALK_BRIDGE option that all these ports can select.
