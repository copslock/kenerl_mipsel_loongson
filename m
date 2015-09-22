Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 12:25:06 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:40974 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007645AbbIVKZCeE-iK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 12:25:02 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZeKkw-00071X-6s; Tue, 22 Sep 2015 12:25:02 +0200
Date:   Tue, 22 Sep 2015 12:24:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexander Couzens <lynxis@fe80.eu>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: ath79: add irq chip ar7240-misc-intc
In-Reply-To: <1442636780-2891-3-git-send-email-lynxis@fe80.eu>
Message-ID: <alpine.DEB.2.11.1509221223280.5606@nanos>
References: <1442636780-2891-1-git-send-email-lynxis@fe80.eu> <1442636780-2891-3-git-send-email-lynxis@fe80.eu>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49270
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

On Sat, 19 Sep 2015, Alexander Couzens wrote:

> The ar7240 misc irq chip use ack handler
> instead of ack_mask handler. All new ath79 chips use
> the ar7240 misc irq chip
> 
> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> Acked-by: Alban Bedel <albeu@free.fr>
> ---
>  .../interrupt-controller/qca,ath79-misc-intc.txt     | 20 ++++++++++++++++++--
>  arch/mips/ath79/irq.c                                | 10 ++++++++++

That driver should probably move into drivers/irqchip.

Other than that.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
