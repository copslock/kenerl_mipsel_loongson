Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 16:06:12 +0000 (GMT)
Received: from sakura.staff.proxad.net ([213.228.1.107]:15589 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S20021927AbXCSQGG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 16:06:06 +0000
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1HTKJu-0005Sl-00; Mon, 19 Mar 2007 17:02:50 +0100
Subject: Re: [PATCH] Always use virt_to_phys() when translating kernel
	addresses
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Franck <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <45FE5ADA.3030309@innova-card.com>
References: <45FE5ADA.3030309@innova-card.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Freebox
Date:	Mon, 19 Mar 2007 17:02:49 +0100
Message-Id: <1174320169.32046.113.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Mon, 2007-03-19 at 10:41 +0100, Franck Bui-Huu wrote:

Hi Franck,

> This patch fixes two places where we used plain 'x - PAGE_OFFSET' to
> achieve virtual to physical address convertion. This type of convertion
> is no more allowed since commit 6f284a2ce7b8bc49cb8455b1763357897a899abb.

I think you should also review arch/mips/mm/dma-noncoherent.c, it seems
to use PAGE_OFFSET directly in dma_unmap_single. I'm using OWN_DMA so
this code is not used on my board.
 
Regards,

-- 
Maxime
