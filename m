Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Dec 2006 21:35:21 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:43744 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037799AbWLCVfT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 3 Dec 2006 21:35:19 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB3LZJub024195;
	Sun, 3 Dec 2006 21:35:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB3LZIwe024194;
	Sun, 3 Dec 2006 21:35:18 GMT
Date:	Sun, 3 Dec 2006 21:35:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Use conditional traps for BUG_ON on MIPS II and better.
Message-ID: <20061203213518.GA22225@linux-mips.org>
References: <S20037651AbWK3BXW/20061130012322Z+10503@ftp.linux-mips.org> <20061204.015327.36921579.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204.015327.36921579.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 04, 2006 at 01:53:27AM +0900, Atsushi Nemoto wrote:

> > This shaves of around 4kB and a few cycles for the average kernel that
> > has CONFIG_BUG enabled.
> > 
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> It seems this commit break QEMU kernel ...  or QEMU can not interpret
> the TNE instruction correctly?

Thiemo says that's indeed a possibility.  Probably that feature has not
been well tested in qemu.

  Ralf
