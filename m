Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2007 19:52:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52370 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021781AbXFMSwz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 Jun 2007 19:52:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5DIjWoG027533;
	Wed, 13 Jun 2007 19:45:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5DIjV6f027532;
	Wed, 13 Jun 2007 19:45:31 +0100
Date:	Wed, 13 Jun 2007 19:45:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: smp_mb() in asm-mips/bitops.h
Message-ID: <20070613184531.GA27194@linux-mips.org>
References: <20070607.165301.63743560.nemoto@toshiba-tops.co.jp> <20070607122344.GD26047@linux-mips.org> <20070614.005631.27954615.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070614.005631.27954615.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 14, 2007 at 12:56:31AM +0900, Atsushi Nemoto wrote:

> You forgot to remove one more 'res' variable.
> 
> 
> Subject: Remove a duplicated local variable in test_and_clear_bit()
> 
> Fix a sparse warning caused by 2c921d07f8c641e691b0dfd80a5cfe14c60ec489

Applied, Thanks, alot!

  Ralf
