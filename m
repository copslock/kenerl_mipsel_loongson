Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 12:17:20 +0000 (GMT)
Received: from [81.2.74.4] ([81.2.74.4]:23531 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22725216AbYJ3MRI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 12:17:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9UCH7rP012714;
	Thu, 30 Oct 2008 12:17:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9UCH7hd012712;
	Thu, 30 Oct 2008 12:17:07 GMT
Date:	Thu, 30 Oct 2008 12:17:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tiejun Chen <tiejun.chen@windriver.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Reserve stack/heap area for RP program
Message-ID: <20081030121707.GJ26256@linux-mips.org>
References: <1225365345-15635-1-git-send-email-tiejun.chen@windriver.com> <1225365345-15635-2-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225365345-15635-2-git-send-email-tiejun.chen@windriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 30, 2008 at 07:15:45PM +0800, Tiejun Chen wrote:

> When you want to run a program on RP it's necessary to reserve
> corresponding stack/heap area of that program.

The official method is to pass a mem= argument when booting the kernel and
adjust by the amount required.  Which certainly is more flexible than
having to hack a constant deeply hidden in the kernel code as in your
proposed patch.

  Ralf
