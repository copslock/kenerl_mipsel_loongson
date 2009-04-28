Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 16:23:40 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:54312 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20025532AbZD1PXi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 16:23:38 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3SFNUtj018169;
	Tue, 28 Apr 2009 17:23:32 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3SFNPFG018167;
	Tue, 28 Apr 2009 17:23:25 +0200
Date:	Tue, 28 Apr 2009 17:23:25 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] txx9dmac: Fix clearing of CHAR register in 32-bit
	kernel
Message-ID: <20090428152325.GA17411@linux-mips.org>
References: <1240931475-31326-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1240931475-31326-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 29, 2009 at 12:11:15AM +0900, Atsushi Nemoto wrote:

> The CHAR register is 64-bit width but 32-bit kernel uses its lower
> part only.  Be careful of initializing it.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch is against linux-mips.org linux-queue tree.
> Please queue this or fold into "DMA: TXx9 Soc DMA Controller driver" patch.

Done.  Thanks!

  Ralf
