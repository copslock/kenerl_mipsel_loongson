Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 17:11:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51632 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493263AbZKIQLh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Nov 2009 17:11:37 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA9GBV0Q015585;
	Mon, 9 Nov 2009 17:11:32 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA9GBRwE015583;
	Mon, 9 Nov 2009 17:11:27 +0100
Date:	Mon, 9 Nov 2009 17:11:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 0/7] add support for lemote loongson2f machines
Message-ID: <20091109161127.GA15319@linux-mips.org>
References: <cover.1257781987.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1257781987.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 10, 2009 at 12:05:21AM +0800, Wu Zhangjin wrote:

> for example, if you pass "machtype=8.9" to kernel when booting, it will run
> well on yeeloong netbook. the default machtype is 2f-box, so, you can run the
> kernel on fuloong2f directly. In the future, we will pass the machtype argument
> by PMON directly, and then the linux distributions will only need to build one
> kernel image, and will make it work on all of lemote loongson2f family
> machines.

A more general solution to this sort of problem is the flattened device tree.
Grant Likely convinced me in Tokyo that this is the way to go.  He intends
to rewrite the FDT code into an easily re-usable library which he estimates
to take a month or two after which I'd like to start using it on MIPS.
This probably also means FDT support for PMON will eventually be needed.

Until then of course machtype=<whatever> is a fair solution.

  Ralf
