Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 15:59:12 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:46024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992971AbeDXN7DUJQKM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Apr 2018 15:59:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4LgEwGaj1xK9/ebv559nZWzN+ETYzTjj0S6pMvWEt1o=; b=gQ6wjBTj/nZ9ip3rfQxYw6szE
        Sw/A0KONhnRSihNU5hlJowwFvBfTdc+Af56VxQ+nW2aKcA9ySg3ognZB7kuECP3PH8qIxpEmR0znu
        N9HtSZnw6TDFtENjEjU/9Ahn4xYy0I61ATp89JZ4VntoiEyhEkuLSBrlsbxWyHBAx2lC+ayzPJvpK
        kCpPCnAmA1U3AYEnQPdbyvw8eemi8f53ekXoE8Pb8t061G6Kxhbkwf5R0NsB2PdvHnQ+FZsVyOeJv
        3ssASYx79FXkhy1RTEdfxlHcnn7Lb4iDsIKF8iEz52poHD46XHl34PEfLtLxOpcQ/lUPjvk9CUdOa
        +yF2YET5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fAyTE-0003xa-HP; Tue, 24 Apr 2018 13:59:00 +0000
Date:   Tue, 24 Apr 2018 06:59:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Richter <rric@kernel.org>, oprofile-list@lists.sf.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180424135900.GA11224@infradead.org>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+433ba6cfe36175bf6d33+5357+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63729
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

On Tue, Apr 24, 2018 at 01:55:54PM +0100, Matt Redfearn wrote:
> The core oprofile code in drivers/oprofile/ has not seeen significant
> maintenance other than fixes to changes in other parts of the tree for
> the last 5 years at least. It looks as through the perf tool has
> more or less superceeded it's functionality.
> Additionally the MIPS architecture support has bitrotted to an extent
> meaning it is not currently functional.

I wonder if time has come to drop oprofile support entirely.

(in addition to your patch which seems more urgent)
