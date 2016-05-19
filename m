Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 11:23:12 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:41533 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27030744AbcESJXKQ6yW8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 11:23:10 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1b3KAd-00010J-Ah; Thu, 19 May 2016 11:23:07 +0200
Date:   Thu, 19 May 2016 11:21:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Joe Perches <joe@perches.com>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/3] External Interrupt Controller (EIC) fixes
In-Reply-To: <1463495466-29689-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.11.1605191120220.3851@nanos>
References: <1463495466-29689-1-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 53544
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

On Tue, 17 May 2016, Paul Burton wrote:

> This series fixes a few small issues with support for External Interrupt
> Controllers (cpu_has_veic), ensuring that it is configured to service
> all interrupts by default & that when a GIC is present it's enabled when
> expected.
> 
> Applies atop v4.6.
> 
> Paul Burton (3):
>   MIPS: Clear Status IPL field when using EIC
>   MIPS: smp-cps: Clear Status IPL field when using EIC
>   irqchip: mips-gic: Setup EIC mode on each CPU if it's in use

I was not on CC for patch 1/3 and I assume this should go through one
tree. Ralf, can you pick that up with my acked-by for the irqchip change?

Thanks,

	tglx
