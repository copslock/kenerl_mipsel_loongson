Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2018 08:09:51 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:35808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991532AbeIUGJsZckpv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2018 08:09:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cg03QiRjf+HUQPKf/1TFGUUl54s7S7du4g8XL+t6vRk=; b=dc2q6qoqIxXBTE9q6iHSZxC8fR
        L2vj/KvmnIDkDtqwbwObTedmdHm3RyBP7J+FiXkATIqzjeITQejJpjy2Cp6xHFHN//AFXQB8pORUi
        +qUAkfLC+9AIEdw5r39uOVrf+ng0J3wwU7v9fiseqtjPSEHOjiM6Fpt1N1EaROP5qvy7YpSDFJtSw
        NcCO4/G42OVfq+YXydx3/3HZJffEQiGYsV8yR9ZBOlWUn8l3mfjZPUcM2w3tZjeHBfj941+o9cMCZ
        dFa+UDOsrsHn1Bx72snk6HTHx6dYsXCW4s98nO67BVygNZ1Bh+Mn2MCBYW1y1o6Gzr13GzqJ6J4Ed
        ZZotdvBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3EdJ-00026K-EN; Fri, 21 Sep 2018 06:09:41 +0000
Date:   Thu, 20 Sep 2018 23:09:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH 0/3] System call table generation support
Message-ID: <20180921060941.GB13865@infradead.org>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
 <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
 <CAK8P3a1=BriZ7hgzgK4QpAT00MBEtXaKOSU+vdHN1=5owB9i4A@mail.gmail.com>
 <20180920204833.gpypjjxcmxjupls6@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180920204833.gpypjjxcmxjupls6@pburton-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+9c098bdbed5ba9a68ca5+5507+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66474
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

On Thu, Sep 20, 2018 at 08:48:37PM +0000, Paul Burton wrote:
> > Speaking of nanoMIPS, what is your plan for the syscall ABI there?
> > I can see two ways of approaching it:
> > 
> > a) keep all the MIPSisms in the data structures, and just use a subset of
> >     o32 that drops all the obsolete entry points
> > b) start over and stay as close as possible to the generic ABI, using the
> >     asm-generic versions of both the syscall table and the uapi header
> >     files instead of the traditional version.
> 
> We've taken option b in our current downstream kernel & that's what I
> hope we'll get upstream too. There's no expectation that we'll ever need
> to mix pre-nanoMIPS & nanoMIPS ISAs or their associated ABIs across the
> kernel/user boundary so it's felt like a great opportunity to clean up &
> standardise.
> 
> Getting nanoMIPS/p32 support submitted upstream is on my to-do list, but
> there's a bunch of prep work to get in first & of course that to-do list
> is forever growing. Hopefully in the next couple of cycles.

p32 is just the ABI name for nanoMIPS or yet another MIPS ABI?

Either way, І think if there is yet another ABI even on an existing port
we should always aim for the asm-generic syscall table indeed.

Especially for mips where o32 has a rather awkward ABI only explained by
odd decisions more than 20 years ago.
