Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Aug 2018 10:37:35 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:35940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeHEIhcc3NS2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Aug 2018 10:37:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UBKeKqFIKqzLixZUgiFcOU0BBIaKClQP8ffAFLrkRnY=; b=F+at7OG/7OSKqVNVKsIXxt2G0
        tu+qiWUQM+UAVTzwUl5jFcjQKJ6hFY1i7HNTawkWlfyKA2byeN07Me+Y4XYV0nt8lY3aOjUAM8jKd
        J6kQH/kwDQonNM2+psYpBTq8vA4B+FkILsUvCCEMZ7wH9Fs6Jpt0krAFBRrPiWk40m1YIWqYK2Rkq
        5kFUh89YwVQXggqiWM6HXLelZ4HoOAc+OyXeqz6jwMr4Awq1fQyGYr5m1SZHo0vMaFiZpEpqW3ccw
        Jl964ZmwYiVND9gAoRPj5LMUey59MlgDtIFPyNOorNps5ZvY6z54QndQmsmQ8pZxrRDItfKDoN9zg
        PgkygLNLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmEXS-0003yb-7D; Sun, 05 Aug 2018 08:37:22 +0000
Date:   Sun, 5 Aug 2018 01:37:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2 15/18] serial: intel: Support more platform
Message-ID: <20180805083722.GA30000@infradead.org>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-16-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803030237.3366-16-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+fb6f8c4579abdce3116e+5460+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The subject line also seems odd, your are changing deps on the lantiq
driver, not some (nonexistent) intel serial driver.
