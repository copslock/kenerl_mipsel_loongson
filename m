Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2007 15:38:11 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:48583 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037643AbXBSPiJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Feb 2007 15:38:09 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1JFc9Kc013301;
	Mon, 19 Feb 2007 15:38:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1JFc784013282;
	Mon, 19 Feb 2007 15:38:07 GMT
Date:	Mon, 19 Feb 2007 15:38:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: struct sigcontext for N32 userland
Message-ID: <20070219153805.GD11401@linux-mips.org>
References: <20070213.005113.89067116.anemo@mba.ocn.ne.jp> <cda58cb80702130027o1ebec149ib25090881f7ac6a1@mail.gmail.com> <20070213113826.GA4569@linux-mips.org> <20070218.001257.88702762.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070218.001257.88702762.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 18, 2007 at 12:12:57AM +0900, Atsushi Nemoto wrote:

> > Looks like a case for __u32, __u64 then.
> 
> Then how about this?
> 
> Subject: export proper struct sigcontext to userland on N32

Looks good, applied.

Thanks,

  Ralf
