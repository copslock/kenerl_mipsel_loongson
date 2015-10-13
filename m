Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 15:53:46 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:51131 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009769AbbJMNxpAS4Aj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 15:53:45 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Zm01N-0008Da-1e; Tue, 13 Oct 2015 15:53:41 +0200
Date:   Tue, 13 Oct 2015 15:53:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [RFC v2 PATCH 00/14] Implement generic IPI support mechanism
In-Reply-To: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1510131550020.25029@nanos>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49524
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

On Tue, 13 Oct 2015, Qais Yousef wrote:

> This series is based on Linus tree. I couldn't compile test it
> because MIPS compilation was broken due to other reasons. I expect
> some brokeness because of the introduction of struct irq_common_data
> which is not present on the 4.1 tree I was testing my code on before
> porting it to Linus tip. I will fix these issues and introduce
> proper accessors for accessing struct ipi_mask given that the
> concept is approved.

Please base it on 4.1-rc5 + irq/core.
 
>   irq: add new IRQ_DOMAIN_FLAGS_IPI

The proper prefix for the core parts is 'genirq:'. Please start the
sentence after the prefix with an uppercase letter

>   irq: add GENERIC_IRQ_IPI Kconfig symbol
>   irq: add new struct ipi_mask
>   irq: add a new irq_send_ipi() to irq_chip
>   irq: add struct ipi_mask to irq_data
>   irq: add struct ipi_mapping and its helper functions
>   irq: add a new generic IPI reservation code to irq core
>   irq: implement irq_send_ipi
>   MIPS: add support for generic SMP IPI support
>   MIPS: make smp CMP, CPS and MT use the new generic IPI functions
>   MIPS: delete smp-gic.c
>   irqchip: mips-gic: add a IPI hierarchy domain

Please make that

irqchip/mips-gic: Add ....

Thanks,

	tglx
