Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Jul 2015 22:36:37 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:50851 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010537AbbGKUge6rD8O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Jul 2015 22:36:34 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZE1Vg-0000vF-CW; Sat, 11 Jul 2015 22:36:32 +0200
Date:   Sat, 11 Jul 2015 22:36:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alban Bedel <albeu@free.fr>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath79: irq: Remove the include of
 drivers/irqchip/irqchip.h
In-Reply-To: <1436379071-31574-1-git-send-email-albeu@free.fr>
Message-ID: <alpine.DEB.2.11.1507112233280.20072@nanos>
References: <1436379071-31574-1-git-send-email-albeu@free.fr>
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
X-archive-position: 48198
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

On Wed, 8 Jul 2015, Alban Bedel wrote:
> We shouldn't include irqchip.h from outside of the drivers/irqchip
> directory. The irq driver should idealy be there, however this not
> trivial at the moment. We still need to support platforms without DT
> support and the interface to the DDR controller still use a custom
> arch specific API.
> 
> For now just redefine the IRQCHIP_DECLARE macro to avoid the cross
> tree include.

The macro has been moved to linux/irqchip.h.

But even if it would still be in drivers/irqchip such a redefine is
even worse than the ../../... include. And the proper solution from
the very beginning would have been to move the macro to the global
header instead of this horrible include.

Sigh,

	tglx

 
