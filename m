Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 14:13:40 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:40614 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20022552AbYDNNNh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Apr 2008 14:13:37 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3EDCsB8019651
	for <linux-mips@linux-mips.org>; Mon, 14 Apr 2008 06:12:54 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3EDDYr7013201;
	Mon, 14 Apr 2008 14:13:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3EDDXVh013200;
	Mon, 14 Apr 2008 14:13:33 +0100
Date:	Mon, 14 Apr 2008 14:13:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ths@networkno.de, linux-mips@linux-mips.org
Subject: Re: [PATCH] Reimplement clear_page/copy_page
Message-ID: <20080414131333.GC6361@linux-mips.org>
References: <20080218193249.GD4747@networkno.de> <20080414.175632.128440098.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080414.175632.128440098.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 14, 2008 at 05:56:32PM +0900, Atsushi Nemoto wrote:

> With this patch, on platforms do not have prefetch instruction, a
> first instruction of clear_page and copy_page would be something like:
> 
> 	ori a2, a0, PAGE_SIZE
> 
> Of course this does not work for odd pages.  Please fold this fix into
> your patch.

Folded into the 2.6.26 queue.  Thanks,

  Ralf
