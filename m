Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2018 18:50:31 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994674AbeE3QuYNnSK2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 May 2018 18:50:24 +0200
Received: from localhost (unknown [104.133.8.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1044720849;
        Wed, 30 May 2018 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527699016;
        bh=8w2MvR86pcmA3Y/lyZBWiMP44kR8KdW4/GEj8ST3nXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YpNmISmXYwmXqNgH64n0L8sMPQL/ngY3WllhOlKLrOSKLkBxRILIUKhLXUHA76AUH
         lsPP3hakeLGElt4QK3NKCS7kXoFRvSDMiRVyDEk+h2vPdoeTRXzJ3hcG7OwBOyrNTc
         SIOnlEPi0MNtreL2XKl1KsvcYjjekaNEO866m6iI=
Date:   Wed, 30 May 2018 11:50:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MIPS: PCI: Use dev_printk()
Message-ID: <20180530165015.GL39853@bhelgaas-glaptop.roam.corp.google.com>
References: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helgaas@kernel.org
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

On Tue, May 22, 2018 at 08:11:36AM -0500, Bjorn Helgaas wrote:
> Use dev_printk() to follow style of other arches.
> 
> I'll merge via the PCI tree unless there are objections.
> 
> ---
> 
> Bjorn Helgaas (1):
>       MIPS: PCI: Use dev_printk() when possible
> 
> 
>  arch/mips/pci/pci-legacy.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied with James' ack to pci/misc for v4.18.
