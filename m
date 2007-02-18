Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2007 17:55:54 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:26757 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039280AbXBRRzw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Feb 2007 17:55:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1IHtoKj031749;
	Sun, 18 Feb 2007 17:55:50 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1IHtnXn031748;
	Sun, 18 Feb 2007 17:55:49 GMT
Date:	Sun, 18 Feb 2007 17:55:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add external declaration of pagetable_init() to pgalloc.h
Message-ID: <20070218175549.GA31727@linux-mips.org>
References: <20070219.012734.21956981.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070219.012734.21956981.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 19, 2007 at 01:27:34AM +0900, Atsushi Nemoto wrote:

> This fixes some sparse warnings.
> 
> pgtable-32.c:15:6: warning: symbol 'pgd_init' was not declared. Should it be static?
> pgtable-32.c:32:13: warning: symbol 'pagetable_init' was not declared. Should it be static?

Thanks, applied.

  Ralf
