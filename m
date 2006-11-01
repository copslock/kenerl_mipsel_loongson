Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 18:47:32 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:8084 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039636AbWKASrb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Nov 2006 18:47:31 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kA1IluTC028108;
	Wed, 1 Nov 2006 18:47:56 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kA1Iltdm028107;
	Wed, 1 Nov 2006 18:47:55 GMT
Date:	Wed, 1 Nov 2006 18:47:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips irq cleanups
Message-ID: <20061101184755.GC4736@linux-mips.org>
References: <20061102.020836.25912635.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102.020836.25912635.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 02, 2006 at 02:08:36AM +0900, Atsushi Nemoto wrote:

> This is a big irq cleanup patch.

>  37 files changed, 289 insertions(+), 1647 deletions(-)

Very nice.  I gave it a shot on a Malta and it works just fine.

  Ralf
