Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jun 2007 21:56:09 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:19418 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021672AbXFXUzz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 24 Jun 2007 21:55:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5OKslYU005846;
	Sun, 24 Jun 2007 21:54:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5OKsi6a005845;
	Sun, 24 Jun 2007 22:54:44 +0200
Date:	Sun, 24 Jun 2007 22:54:44 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	mlachwani@mvista.com
Subject: Re: [PATCH 2/4] rbtx4938: Convert SPI codes to use generic SPI
	drivers
Message-ID: <20070624205444.GC5814@linux-mips.org>
References: <20070622.232206.88704003.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070622.232206.88704003.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 22, 2007 at 11:22:06PM +0900, Atsushi Nemoto wrote:

> Use rtc-rs5c348 and at25 spi protocol driver and spi_txx9 spi
> controller driver instead of platform dependent codes.
> 
> This patch also removes dependencies to old RTC interfaces such as
> rtc_mips_get_time, etc.

Queued also,

  Ralf
