Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2007 13:04:03 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:22696 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022751AbXEAMD7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 May 2007 13:03:59 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l41C3Ove008537;
	Tue, 1 May 2007 13:03:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l416VYUg005206;
	Tue, 1 May 2007 07:31:34 +0100
Date:	Tue, 1 May 2007 07:31:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org, jeff@garzik.org,
	sshtylyov@ru.mvista.com, akpm@linux-foundation.org
Subject: Re: [PATCH 4/5] ne: MIPS: Use platform_driver for ne on RBTX49XX
Message-ID: <20070501063134.GA5183@linux-mips.org>
References: <20070501.002758.15250764.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070501.002758.15250764.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 01, 2007 at 12:27:58AM +0900, Atsushi Nemoto wrote:

> This patch lets RBTX49XX boards use generic platform_driver interface
> for the ne driver.
> 
> * Use platform_device to pass ioaddr and irq to the ne driver.
> * Remove unnecessary ifdefs for RBTX49XX from the ne driver.
> * Make the ne driver selectable on these boards regardless of CONFIG_ISA
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
