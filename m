Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 15:11:32 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:56987 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038832AbXBTPLb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Feb 2007 15:11:31 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1KFBTl5000666;
	Tue, 20 Feb 2007 15:11:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1KFBSHC000662;
	Tue, 20 Feb 2007 15:11:28 GMT
Date:	Tue, 20 Feb 2007 15:11:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Drop __init from init_8259A()
Message-ID: <20070220151128.GA649@linux-mips.org>
References: <20070220.200845.98359099.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070220.200845.98359099.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 20, 2007 at 08:08:45PM +0900, Atsushi Nemoto wrote:

> init_8259A() is called from i8259A_resume() so should not be marked as
> __init.  And add some tests for whether 8259A was already initialized
> or not.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, applied.

  Ralf
