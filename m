Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 14:36:48 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:39454 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225808AbVDMNgd>; Wed, 13 Apr 2005 14:36:33 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3DDaSY5013480;
	Wed, 13 Apr 2005 14:36:28 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3DDaRAn013470;
	Wed, 13 Apr 2005 14:36:27 +0100
Date:	Wed, 13 Apr 2005 14:36:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tobias Klauser <tklauser@nuerscht.ch>
Cc:	kernel-janitors@lists.osdl.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net/ioc3-eth: Use the DMA_{32,64}BIT_MASK constants
Message-ID: <20050413133627.GI5253@linux-mips.org>
References: <20050413133147.GA9864@argon.tklauser.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413133147.GA9864@argon.tklauser.home>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 13, 2005 at 03:31:52PM +0200, Tobias Klauser wrote:

> Use the DMA_{32,64}BIT_MASK constants from dma-mapping.h when calling
> pci_set_dma_mask() or pci_set_consistent_dma_mask()
> This patch includes dma-mapping.h explicitly because patches caused
> errors on some architectures otherwise.
> See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details
> 
> Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Looks good,

  Ralf
