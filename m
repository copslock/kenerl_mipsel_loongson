Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2007 16:09:46 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:6017 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20040612AbXAJQJo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 16:09:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0ABKt4C006269;
	Wed, 10 Jan 2007 11:21:04 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0ABKssQ006268;
	Wed, 10 Jan 2007 11:20:54 GMT
Date:	Wed, 10 Jan 2007 11:20:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Message-ID: <20070110112054.GA6193@linux-mips.org>
References: <116841864595-git-send-email-fbuihuu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <116841864595-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 10, 2007 at 09:44:03AM +0100, Franck Bui-Huu wrote:

> Here's is the second attempt to make this works on your Malta board
> and all other boards that have some data reserved at the start of
> their memories. In these cases the first patchset assumed wrongly that
> the start of the memory was after this reserved area.
> 
> Patch 1/2 should work alone now. the kernel should report that your
> mem config is wasting some memory for tracking reserved pages located
> at the start of the mem.

So this series now works for me, both 1/2 along and 1/2 + 2/2 applied.
So I'll drop this into the 2.6.21 queue.

  Ralf
