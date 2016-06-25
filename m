Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2016 11:00:31 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:51660 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014372AbcFYJA3cxn00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Jun 2016 11:00:29 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1bGjRx-0001EE-J2; Sat, 25 Jun 2016 11:00:25 +0200
Date:   Sat, 25 Jun 2016 10:58:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jason Cooper <jason@lakedaemon.net>
cc:     Qais Yousef <qsyousef@gmail.com>, g@io.lakedaemon.net,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com
Subject: Re: [PATCH] irqchip/mips-gic: Fix IRQs in gic_dev_domain
In-Reply-To: <20160623181117.GH9922@io.lakedaemon.net>
Message-ID: <alpine.DEB.2.11.1606251057460.5839@nanos>
References: <1464001552-31174-1-git-send-email-harvey.hunt@imgtec.com> <CA+mqd+7mh3v-1mk4xpxBjxtt4_JjycisWj6VnV7AaOH=i=y3Qw@mail.gmail.com> <20160623181117.GH9922@io.lakedaemon.net>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Thu, 23 Jun 2016, Jason Cooper wrote:

> Qais,
> 
> On Tue, May 24, 2016 at 11:43:07AM +0100, Qais Yousef wrote:
> > Hmm I certainly did test this on real hardware with GIC. Are you using the
> > new dev domain? The idea is that GIC is logically divided and shouldn't be
> > used directly. Sorry I'm travelling and can't check the code.
> 
> Any update on this patch?  Should I stop tracking it?

I sent it to Linus as it fixes a real problem for the MIPS people.

Thanks,

	tglx
