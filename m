Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 15:26:05 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:48836 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021840AbXDRO0D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Apr 2007 15:26:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3IEPs2i024167;
	Wed, 18 Apr 2007 15:25:54 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3IEPrHL024166;
	Wed, 18 Apr 2007 15:25:53 +0100
Date:	Wed, 18 Apr 2007 15:25:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix BUG(), BUG_ON() handling
Message-ID: <20070418142553.GA24160@linux-mips.org>
References: <20070412.200254.128619887.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070412.200254.128619887.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 12, 2007 at 08:02:54PM +0900, Atsushi Nemoto wrote:

> With commit 63dc68a8cf60cb110b147dab1704d990808b39e2, kernel can not
> handle BUG() and BUG_ON() properly since get_user() returns false for
> kernel code.  Use __get_user() to skip unnecessary access_ok().  This
> patch also make BRK_BUG code encoded in the TNE instruction.

Thanks, applied to 2.6.20-stable and master.

  Ralf
