Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2015 12:19:34 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60486 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009728AbbJOKTc5mHQg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2015 12:19:32 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZmfdC-0007JC-S7; Thu, 15 Oct 2015 12:19:31 +0200
Date:   Thu, 15 Oct 2015 12:18:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Alex Smith <alex.smith@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] irqchip: irq-mips-gic: Provide function to map
 GIC user section
In-Reply-To: <561F73D6.8040300@imgtec.com>
Message-ID: <alpine.DEB.2.11.1510151218010.3960@nanos>
References: <1443435117-17144-1-git-send-email-markos.chandras@imgtec.com> <1444642843-16375-1-git-send-email-markos.chandras@imgtec.com> <561B82BA.30809@arm.com> <alpine.DEB.2.11.1510121155490.6097@nanos> <561F73D6.8040300@imgtec.com>
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
X-archive-position: 49562
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

On Thu, 15 Oct 2015, Qais Yousef wrote:
> It could be refactored but the DT binding already specifies the GIC timer as a
> subnode of GIC. Exposing this usermode register is the only thing left in the
> register set that GIC driver wasn't dealing with.
> 
> Little gain in changing all of this now I think?

Well, the not so little gain is clear separation and a sane design.

Thanks,

	tglx
