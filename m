Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 11:03:09 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:37418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbdD1JDCop00l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 11:03:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PleFTMafBju5UyHVuluvtD1Xjc8b6718A9cW7O8vw/0=; b=pGD038g8s7zMhu53l07P/sLwn
        hLn5e1kWlqDTlj1Izs9SNQ78+tvla0ER71PsqBZLBqbT1KfjF6Oh6IwFdp2KtrhKcaO34Q8/z/2qV
        GDIQFxrwJdkTmd+ie46C0CCklLlFHFfdioaBSSogGcW1nQZUf5myCBe5bWEvU/T9ta2omLukFis1z
        bwosXya8odb22trMqEbsgZpwvpbad7IbpdnzWlaV10i30c9/kDpF7kLs28SGYO4pt/iZdH6TU8L4Y
        3UN4rqyMi+B+1DDlc0S2d5gxTqdivyTwlJk2LykjPb4fOzGR8OhgsUsYBempZGyayg4MPJ2DgvjQS
        KbBewpXwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1d41nH-0004yS-Tn; Fri, 28 Apr 2017 09:02:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2873B20298380; Fri, 28 Apr 2017 11:02:26 +0200 (CEST)
Date:   Fri, 28 Apr 2017 11:02:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in
 NMI
Message-ID: <20170428090226.qqoe6qbewjeo57kd@hirez.programming.kicks-ass.net>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
 <20170424021747.GA630@jagdpanzerIV.localdomain>
 <20170427133819.GW3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427133819.GW3452@pathway.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Thu, Apr 27, 2017 at 03:38:19PM +0200, Petr Mladek wrote:
> Also we need to look for alternatives. There is a chance
> to create crashdump and get the ftrace messages from it.
> Also this might be scenario when we might need to suggest
> the early_printk() patchset from Peter Zijlstra.

I'd be happy to repost those. I still carry them in my tree.
