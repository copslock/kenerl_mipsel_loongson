Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 08:47:01 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:51884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990498AbdJRGqyFQUFI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2017 08:46:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ih3vSc/mVwF+EeLJFksZDMO55GFhDX3b+PntyVLQ+hA=; b=GLcLGZ2zobafeE1sQK5KIqrAn
        aT06/GF6AUPVeLPlf8T2isLtMyyuXl7eJMhEu2awGYCdhQzSjS9lvRRkYy+uvsXoRVrrVSCdkw0W8
        IhfUgly5XzOSuoAtCwegAUREp9O4qYkEdkjEfAYK6ip69Pl5WlFAFzofECIVXI8N4nH2IonXP/5sn
        4NUXz/O2ILj1UPEKjFcLMt5OHAhcSfmfqGF11OFoc8iz0tMGr5KtQbnm0kGKm9iod27S+Mlz7t9uN
        /1lVtRJ0Mj9noexZDdN81n0Wn2wnVm8tFixHcFnhyqk/gtUvWD8ai7IiWBGul7HgL2K1aCaflC0Fk
        r0VCXZY+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1e4i7t-0006kd-41; Wed, 18 Oct 2017 06:46:49 +0000
Date:   Tue, 17 Oct 2017 23:46:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 1/9] SOC: brcmstb: add memory API
Message-ID: <20171018064649.GA7734@infradead.org>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-2-git-send-email-jim2101024@gmail.com>
 <20171017082413.GA10574@infradead.org>
 <abdb1e9d-f8c9-8066-48c5-37b4e2474952@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abdb1e9d-f8c9-8066-48c5-37b4e2474952@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+33c0a560d8cf4f6c9bdc+5169+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60440
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

On Tue, Oct 17, 2017 at 09:12:22AM -0700, Florian Fainelli wrote:
> > Please move this into the arm arch code.
> 
> No, this needs to work on both ARM and ARM64, hence the reason why this
> is in a reasonably architecture neutral place.

So there is no other shared code between the ARM and ARM64 ports for
this SOC?

> >> +EXPORT_SYMBOL(brcmstb_memory_phys_addr_to_memc);
> > 
> >> +EXPORT_SYMBOL(brcmstb_memory_memc_size);
> > 
> > Why is this exported?
> 
> Because the PCIE RC driver can be built as a module.

Hmm, supporting PCIE RC as module sounds odd, but it seems like there
are a few others like that.  At least make it EXPORT_SYMBOL_GPL() then
to document the internal nature.
