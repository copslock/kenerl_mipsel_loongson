Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 02:39:46 +0100 (BST)
Received: from [65.98.92.6] ([65.98.92.6]:16136 "EHLO b32.net")
	by ftp.linux-mips.org with ESMTP id S20021940AbZDXBjk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2009 02:39:40 +0100
Received: (qmail 22939 invoked from network); 24 Apr 2009 01:39:37 -0000
Received: from softdnserror (HELO two) (127.0.0.1)
  by softdnserror with SMTP; 24 Apr 2009 01:39:37 -0000
Received: by two (sSMTP sendmail emulation); Thu, 23 Apr 2009 18:38:57 -0700
Message-Id: <0483452db22e72f57289e63fcf097120d94c2a37.1240533480.git@localhost>
From:	Kevin Cernekee <cernekee@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:	Thu, 23 Apr 2009 17:03:43 -0700
Subject: [PATCH 0/3] MIPS: Extend plat_* abstractions, cache support
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am upgrading an SoC to the 2.6.29.1 kernel from an earlier version,
and in the process I am switching over the old board support
customizations to use the newer, cleaner plat_* functions.  I found two
cases where the plat_* functions did not provide enough information,
so I had to modify the API:

plat_unmap_dma_mem() - Our handler needs to know the size and direction
of the DMA mapping.  This information is not encoded in the DMA address,
so it needed to be passed in explicitly.

plat_dma_addr_to_phys() - The bus<->physical address mappings differ
based on which bus is being used.  It is not always possible to infer
which bus is being used from the bus address alone, so I added a
"struct device" to the function definition.

Also, our MIPS core uses 64-byte D$ lines, so I needed to generate the
corresponding blast* functions.

These patches apply against the linux-mips.org GIT tree.
