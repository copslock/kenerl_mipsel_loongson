Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 17:49:46 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38471 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6862357AbaCSQtop-AWL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Mar 2014 17:49:44 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2JGndfW029388;
        Wed, 19 Mar 2014 17:49:39 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2JGnaY6029387;
        Wed, 19 Mar 2014 17:49:36 +0100
Date:   Wed, 19 Mar 2014 17:49:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?utf-8?B?IumZiOWNjuaJjSI=?= <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <steven.hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V19 07/13] MIPS: Loongson 3: Add IRQ init and dispatch
 support
Message-ID: <20140319164936.GB4365@linux-mips.org>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
 <1392537690-5961-8-git-send-email-chenhc@lemote.com>
 <20140318145911.GE17197@linux-mips.org>
 <f863ed85ae872f0e3f7b00fb485ed457.squirrel@mail.lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f863ed85ae872f0e3f7b00fb485ed457.squirrel@mail.lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Mar 19, 2014 at 11:05:34AM +0800, "陈华才" wrote:

> >> +{
> >> +	unsigned int i, irq;
> >> +	unsigned int ht_irq[] = {1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
> >> +
> >> +	irq = LOONGSON_HT1_INT_VECTOR(0);
> >> +	LOONGSON_HT1_INT_VECTOR(0) = irq; /* Acknowledge the IRQs */
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(ht_irq); i++) {
> >> +		if (irq & (0x1 << ht_irq[i]))
> >> +			do_IRQ(ht_irq[i]);
> >> +	}
> >> +}
> >
> > Ouch.
> >
> > Initializing an array like this in C will generate code which at runtime
> > initializes the ht_irq[] array each time ht_irqdispatch is invoked
> > and slowing this function to a crawl.
> >
> > You want to make either move the definition of this array out of the
> > function body or make it "static const unsigned int ht_irq[] ..." to
> > avoid this.
> Since there are several patches have problem, and the first one is
> merged, I will send a V20 patchset without the first one ASAP.

Great.  I'll then drop V19 from patchwork.

Thanks,

  Ralf
