Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 04:03:35 +0200 (CEST)
Received: from kirsty.vergenet.net ([202.4.237.240]:44110 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008292AbbFECDbnuWk4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2015 04:03:31 +0200
Received: from penelope.kanocho.kobe.vergenet.net (g1-27-253-251-6.bmobile.ne.jp [27.253.251.6])
        by kirsty.vergenet.net (Postfix) with ESMTPSA id 7174125B741;
        Fri,  5 Jun 2015 12:03:23 +1000 (AEST)
Received: by penelope.kanocho.kobe.vergenet.net (Postfix, from userid 7100)
        id 30D92601D4; Fri,  5 Jun 2015 10:53:20 +0900 (JST)
Date:   Fri, 5 Jun 2015 10:53:20 +0900
From:   Simon Horman <horms@verge.net.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 5/7] PCI: Remove unnecessary #includes of <asm/pci.h>
Message-ID: <20150605015317.GB13022@verge.net.au>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150604214957.2399.66129.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150604214957.2399.66129.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Organisation: Horms Solutions Ltd.
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
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

On Thu, Jun 04, 2015 at 04:49:57PM -0500, Bjorn Helgaas wrote:
> In include/linux/pci.h, we already #include <asm/pci.h>, so we don't need
> to include <asm/pci.h> directly.
> 
> Remove the unnecessary includes.  All the files here already include
> <linux/pci.h>.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: linux-alpha@vger.kernel.org
> CC: linux-mips@linux-mips.org
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-sh@vger.kernel.org
> CC: x86@kernel.org
> ---
>  arch/alpha/kernel/core_irongate.c |    1 -
>  arch/alpha/kernel/sys_eiger.c     |    1 -
>  arch/alpha/kernel/sys_nautilus.c  |    1 -
>  arch/mips/pci/fixup-cobalt.c      |    1 -
>  arch/mips/pci/ops-mace.c          |    1 -
>  arch/mips/pci/pci-lantiq.c        |    1 -
>  arch/powerpc/kernel/prom.c        |    1 -
>  arch/powerpc/kernel/prom_init.c   |    1 -
>  arch/sh/drivers/pci/ops-sh5.c     |    1 -
>  arch/sh/drivers/pci/pci-sh5.c     |    1 -
>  arch/x86/kernel/x86_init.c        |    1 -
>  11 files changed, 11 deletions(-)

arch/sh/drivers portion:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
