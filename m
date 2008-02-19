Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2008 16:38:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:61090 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027001AbYBSQiK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Feb 2008 16:38:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1JGc93f011141;
	Tue, 19 Feb 2008 16:38:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1JGc80x011140;
	Tue, 19 Feb 2008 16:38:08 GMT
Date:	Tue, 19 Feb 2008 16:38:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.25 patch] mips: fix SNI_RM EISA=n compilation
Message-ID: <20080219163808.GA11006@linux-mips.org>
References: <20080217215948.GL1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080217215948.GL1403@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 17, 2008 at 11:59:48PM +0200, Adrian Bunk wrote:

> This patch fixes the following build error with CONFIG_EISA=n caused by 
> commit 231a35d37293ab88d325a9cb94e5474c156282c0:

Applied.  Thanks,

  Ralf
