Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2015 18:55:00 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:33471 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008654AbbIWQy6n0D47 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Sep 2015 18:54:58 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 23 Sep 2015 09:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,577,1437462000"; 
   d="scan'208";a="811571382"
Received: from binbinwu-mobl1.ccr.corp.intel.com (HELO [10.254.215.200]) ([10.254.215.200])
  by orsmga002.jf.intel.com with ESMTP; 23 Sep 2015 09:54:50 -0700
Subject: Re: [PATCH 0/6] Implement generic IPI support mechanism
To:     Qais Yousef <qais.yousef@imgtec.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
Cc:     marc.zyngier@arm.com, jason@lakedaemon.net,
        linux-mips@linux-mips.org
From:   Jiang Liu <jiang.liu@linux.intel.com>
Organization: Intel
Message-ID: <5602D958.6000003@linux.intel.com>
Date:   Thu, 24 Sep 2015 00:54:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jiang.liu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.liu@linux.intel.com
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

On 2015/9/23 22:49, Qais Yousef wrote:
> This RFC series attempts to implement a generic IPI layer for reserving and sending IPI.
> 
> It is based on the discussion in this link
> 
> 	https://lkml.org/lkml/2015/8/26/713
> 
> This series deals with points #1 and #2 only. Since I'm not the irq expert, I'm hoping this
> series will give me early feedback and drive the discussion further about any potential
> tricky points.
> 
> I tried to keep changes clean and small, but since this is just an RFC I might have missed
> few things.
> 
> Thomas I hope I didn't stray far from what you had in mind :-)
> 
> My only testing so far is having SMP linux booting.
Hi Qais,
	Thanks for doing this, but the change is a little bigger than
my expectation. Could we achieve this by:
1) extend irq_chip to support send_ipi operation
2) reuse existing irqdomain allocation interfaces to allocate IPI IRQ
3) arch code to create an IPI domain for IPI allocations
4) IRQ core provides some helpers to help arch code to implement IPI
   irqdomain
	I think that may make the change smaller and more clear.
Thanks!
Gerry

> 
> Qais Yousef (6):
>   irqdomain: add new IRQ_DOMAIN_FLAGS_IPI
>   irqdomain: add a new send_ipi() to irq_domain_ops
>   irqdomain: add struct irq_hwcfg and helper functions
>   irq: add a new generic IPI handling code to irq core
>   irqchip: mips-gic: add a IPI hierarchy domain
>   irqchip: mips-gic: use the new generic IPI API
> 
>  arch/mips/kernel/smp-gic.c       |  37 ++--
>  drivers/irqchip/Kconfig          |   1 +
>  drivers/irqchip/irq-mips-gic.c   | 189 ++++++++++++++++++---
>  include/linux/irqchip/mips-gic.h |   3 +-
>  include/linux/irqdomain.h        |  67 ++++++++
>  kernel/irq/irqdomain.c           | 352 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 601 insertions(+), 48 deletions(-)
> 
