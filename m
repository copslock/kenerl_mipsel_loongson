Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2016 15:32:29 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:32778 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993214AbcHCNcV3vKQt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2016 15:32:21 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u73DVc3c006602
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 3 Aug 2016 06:31:38 -0700 (PDT)
Received: from yow-pgortmak-d1 (128.224.56.57) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.248.2; Wed, 3 Aug 2016
 06:31:37 -0700
Received: by yow-pgortmak-d1 (Postfix, from userid 1000)        id 7A5C7281E99; Wed,
  3 Aug 2016 09:31:37 -0400 (EDT)
Date:   Wed, 3 Aug 2016 09:31:37 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        John Crispin <john@phrozen.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Subject: Re: [PATCH] mips: lantiq: fix irq_chip name to not land in new
 parent field
Message-ID: <20160803133136.GJ29630@windriver.com>
References: <20160802185447.3831-1-paul.gortmaker@windriver.com>
 <20160803055653.GG15910@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20160803055653.GG15910@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

[Re: [PATCH] mips: lantiq: fix irq_chip name to not land in new parent field] On 03/08/2016 (Wed 07:56) Ralf Baechle wrote:

> On Tue, Aug 02, 2016 at 02:54:47PM -0400, Paul Gortmaker wrote:
> 
> > As of commit be45beb2df69 ("genirq: Add runtime power management
> > support for IRQ chips") the irq_chip struct got a struct *device
> > parent_device field added to it.  However, it was added at the
> > beginning of the struct, which previously was the "name" entry.
> > 
> > The driver here was using a mix of ordered struct init entries and
> > named init entries.  It was supplying the name assuming it was the 1st
> > in the order, and hence when that became a struct *device we get:
> > 
> > arch/mips/lantiq/irq.c:209:2: warning: initialization from incompatible pointer type [enabled by default]
> > arch/mips/lantiq/irq.c:209:2: warning: (near initialization for 'ltq_irq_type.parent_device') [enabled by default]
> > arch/mips/lantiq/irq.c:219:2: warning: initialization from incompatible pointer type [enabled by default]
> > arch/mips/lantiq/irq.c:219:2: warning: (near initialization for 'ltq_eiu_type.parent_device') [enabled by default]
> > 
> > While not runtime tested, I can't imagine trying to dereference a
> > a struct device field from a char string will end well.
> > 
> > Here we've used named element init entries for the name string as well
> > to fix it.
> > 
> > Fixes: be45beb2df69 ("genirq: Add runtime power management support for IRQ chips")
> > Cc: Jon Hunter <jonathanh@nvidia.com>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: John Crispin <john@phrozen.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-mips@linux-mips.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Thanks for the patch but I've already applied the identical patch
> https://patchwork.linux-mips.org/patch/13684/.

Patchwork shows that patch was from June, however I still saw the issue
on the linux-next from yesterday (or maybe the weekend?).   Is the
branch you applied it to being fed into sfr's daily merge queue?

P.
--
> 
>   Ralf
