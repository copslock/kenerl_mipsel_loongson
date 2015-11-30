Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 12:23:05 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:51810 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006873AbbK3LXDhKC0E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 12:23:03 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1a3MXr-0003Cc-4S; Mon, 30 Nov 2015 12:22:59 +0100
Date:   Mon, 30 Nov 2015 12:22:15 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 09/19] genirq: Add a new function to get IPI reverse
 mapping
In-Reply-To: <565C2ABD.5030409@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511301220380.3572@nanos>
References: <1448453217-3874-1-git-send-email-qais.yousef@imgtec.com> <1448453217-3874-10-git-send-email-qais.yousef@imgtec.com> <5658429D.3000105@imgtec.com> <alpine.DEB.2.11.1511301139500.3572@nanos> <565C2ABD.5030409@imgtec.com>
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
X-archive-position: 50165
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

On Mon, 30 Nov 2015, Qais Yousef wrote:
> On 11/30/2015 10:40 AM, Thomas Gleixner wrote:
> > On Fri, 27 Nov 2015, Qais Yousef wrote:
> > > While trying to get my remoteproc driver work with this I uncovered a
> > > problem
> > > with this approach.
> > > 
> > > mips-gic doesn't store the actual hwirq in the irq_data. It uses
> > > GIC_SHARED_TO_HWIRQ() and GIC_HWIRQ_TO_SHARED() to add and remove an
> > > offset.
> > Why can't MIPS store the real hwirq number in irq_data?
> 
> 
> I'm wary of ending up in inconsistency hell where some functions need to deal
> with raw hwirq and others with translated ones.
> 
> I will give this a go first and see if it gets really ugly.

Well, the question is why can't those functions not all use the raw
hardware irq. We have it in irq_data exactly to avoid calculations in
the hot path functions.

Thanks,

	tglx
