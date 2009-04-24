Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 05:23:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:29343 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20022140AbZDXEXP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2009 05:23:15 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3O4NBC8022755;
	Fri, 24 Apr 2009 06:23:11 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3O4NAvZ022753;
	Fri, 24 Apr 2009 06:23:10 +0200
Date:	Fri, 24 Apr 2009 06:23:10 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kevin Cernekee <cernekee@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] MIPS: Extend plat_* abstractions, cache support
Message-ID: <20090424042310.GA19096@linux-mips.org>
References: <0483452db22e72f57289e63fcf097120d94c2a37.1240533480.git@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0483452db22e72f57289e63fcf097120d94c2a37.1240533480.git@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 23, 2009 at 05:03:43PM -0700, Kevin Cernekee wrote:

> I am upgrading an SoC to the 2.6.29.1 kernel from an earlier version,
> and in the process I am switching over the old board support
> customizations to use the newer, cleaner plat_* functions.  I found two
> cases where the plat_* functions did not provide enough information,
> so I had to modify the API:
> 
> plat_unmap_dma_mem() - Our handler needs to know the size and direction
> of the DMA mapping.  This information is not encoded in the DMA address,
> so it needed to be passed in explicitly.
> 
> plat_dma_addr_to_phys() - The bus<->physical address mappings differ
> based on which bus is being used.  It is not always possible to infer
> which bus is being used from the bus address alone, so I added a
> "struct device" to the function definition.
> 
> Also, our MIPS core uses 64-byte D$ lines, so I needed to generate the
> corresponding blast* functions.
> 
> These patches apply against the linux-mips.org GIT tree.

Queued for 2.6.31.  Thanks Kevin!

Which SoC port are you working on btw?

  Ralf
