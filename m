Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 23:09:42 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:46171 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491933Ab1CWWJj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 23:09:39 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2WFB-0002IO-MM; Wed, 23 Mar 2011 23:09:33 +0100
Date:   Wed, 23 Mar 2011 23:09:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] genirq: Add chip hooks for taking CPUs on/off
 line.
In-Reply-To: <4D8A6E38.7020203@gmail.com>
Message-ID: <alpine.LFD.2.00.1103232304240.31464@localhost6.localdomain6>
References: <1300484916-11133-1-git-send-email-ddaney@caviumnetworks.com> <1300484916-11133-2-git-send-email-ddaney@caviumnetworks.com> <alpine.LFD.2.00.1103192050400.2787@localhost6.localdomain6> <4D879869.8060405@caviumnetworks.com>
 <alpine.LFD.2.00.1103212136430.24415@localhost6.localdomain6> <4D8A6E38.7020203@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Wed, 23 Mar 2011, David Daney wrote:
> On 03/21/2011 02:13 PM, Thomas Gleixner wrote:
> > I can't imagine any other purpose for that.
> 
> Modifying the affinity of non-per-cpu IRQs to use the new CPU?

Hmm. Good point. Ok, go ahead with that name.

> > Hmm. The offline fixup_irq() code is arch specific and usually calls
> > desc->irq_data.chip->irq_set_affinity under desc->lock. I have not yet
> > found an arch independent way to do that. Any ideas welcome.
> > 
> 
> There are all the new affinity callbacks, and the things shown in procfs?  Are
> those handled properly if I call chip->irq_set_affinity?  I think not.

If the arch code updates irq_data.affinity then yes. I still need to
go through all that maze and figure out what all the archs really want
to do in that case.

Thanks,

	tglx
