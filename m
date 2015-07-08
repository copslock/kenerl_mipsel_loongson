Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 14:57:45 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:38254 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010191AbbGHM5npN0bu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2015 14:57:43 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZCov1-0006SH-6x; Wed, 08 Jul 2015 14:57:43 +0200
Date:   Wed, 8 Jul 2015 14:57:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] MIPS, IRQCHIP: Move i8259 irqchip driver to
 drivers/irqchip.
In-Reply-To: <20150708124608.GS18167@linux-mips.org>
Message-ID: <alpine.DEB.2.11.1507081456560.5134@nanos>
References: <20150708124608.GS18167@linux-mips.org>
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
X-archive-position: 48117
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

On Wed, 8 Jul 2015, Ralf Baechle wrote:

>  arch/mips/Kconfig           |   4 -
>  arch/mips/kernel/Makefile   |   1 -
>  arch/mips/kernel/i8259.c    | 384 --------------------------------------------
>  drivers/irqchip/Kconfig     |   4 +
>  drivers/irqchip/Makefile    |   1 +
>  drivers/irqchip/irq-i8259.c | 383 +++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 388 insertions(+), 389 deletions(-)

Should I carry it, or want you merge it via the mips tree?

In the latter case: Acked-by-me.
 
