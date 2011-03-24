Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 13:59:37 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:54688 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491112Ab1CXM7T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 13:59:19 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2k89-0005V7-E0; Thu, 24 Mar 2011 13:59:13 +0100
Date:   Thu, 24 Mar 2011 13:59:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [patch 10/38] MIPS: JZ4740: GPIO: Use shared irq chip for all
 gpios
In-Reply-To: <4D8B35DA.6020804@mvista.com>
Message-ID: <alpine.LFD.2.00.1103241358480.31464@localhost6.localdomain6>
References: <20110323210437.398062704@linutronix.de> <20110323210535.525705907@linutronix.de> <4D8B35DA.6020804@mvista.com>
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
X-archive-position: 29484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Thu, 24 Mar 2011, Sergei Shtylyov wrote:

> Hello.
> 
> On 24-03-2011 0:08, Thomas Gleixner wrote:
> 
> > Currently there is one irq_chip per gpio_chip with the only difference
> > being the name. Since the information whether the irq belong to GPIO
> > bank A, B, C or D is not that important rewrite the code to simply use
> > a single irq_chip for all gpio_chips.
> 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
>    If these 2 patches are from Lars, shouldn't there be "From: Lars-Peter
> Clausen <lars@metafoo.de>" line at the start of the patches?

Yep. Mangled that, sorry.
