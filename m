Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 17:04:55 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:36392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009618AbbJNPExQid-s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Oct 2015 17:04:53 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EB89BAAC4;
        Wed, 14 Oct 2015 15:04:51 +0000 (UTC)
Date:   Wed, 14 Oct 2015 08:04:31 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        jiang.liu@linux.intel.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [RFC v2 PATCH 00/14] Implement generic IPI support mechanism
Message-ID: <20151014150431.GF3052@linux-uzut.site>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dave@stgolabs.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@stgolabs.net
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

>Qais Yousef (14):
>  irq: add new IRQ_DOMAIN_FLAGS_IPI
>  irq: add GENERIC_IRQ_IPI Kconfig symbol
>  irq: add new struct ipi_mask
>  irq: add a new irq_send_ipi() to irq_chip
>  irq: add struct ipi_mask to irq_data
>  irq: add struct ipi_mapping and its helper functions
>  irq: add a new generic IPI reservation code to irq core
>  irq: implement irq_send_ipi
>  MIPS: add support for generic SMP IPI support
>  MIPS: make smp CMP, CPS and MT use the new generic IPI functions
>  MIPS: delete smp-gic.c
>  irqchip: mips-gic: add a IPI hierarchy domain
>  irqchip: mips-gic: implement the new irq_send_ipi
>  irqchip: mips-gic: remove IPI init code
>
> arch/mips/Kconfig                |   6 --
> arch/mips/include/asm/smp-ops.h  |   5 +-
> arch/mips/kernel/Makefile        |   1 -
> arch/mips/kernel/smp-cmp.c       |   4 +-
> arch/mips/kernel/smp-cps.c       |   4 +-
> arch/mips/kernel/smp-gic.c       |  64 -----------
> arch/mips/kernel/smp-mt.c        |   2 +-
> arch/mips/kernel/smp.c           | 117 ++++++++++++++++++++
> drivers/irqchip/Kconfig          |   2 +
> drivers/irqchip/irq-mips-gic.c   | 225 ++++++++++++++++++++++++---------------
> include/linux/irq.h              |  43 ++++++++
> include/linux/irqchip/mips-gic.h |   3 -
> include/linux/irqdomain.h        |  19 ++++
> kernel/irq/Kconfig               |   4 +
> kernel/irq/irqdomain.c           |  84 +++++++++++++++
> kernel/irq/manage.c              | 103 ++++++++++++++++++
> 16 files changed, 517 insertions(+), 169 deletions(-)
> delete mode 100644 arch/mips/kernel/smp-gic.c

It strikes me that Documentation/ should at least get _some_ love. Perhaps IRQ-ipi.txt? I dunno...

Thanks,
Davidlohr
