Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 18:01:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14561 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20032748AbYGKRA1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 18:00:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6BEAsfE013750;
	Fri, 11 Jul 2008 15:10:56 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6BEArdl013749;
	Fri, 11 Jul 2008 15:10:53 +0100
Date:	Fri, 11 Jul 2008 15:10:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	linux-mtd <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH][MIPS] MTX-1 flash partition setup move to platform
	devices registration
Message-ID: <20080711141053.GD13593@linux-mips.org>
References: <20080711223448.f5826678.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080711223448.f5826678.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 11, 2008 at 10:34:48PM +0900, Yoichi Yuasa wrote:

> MTX-1 flash partition setup move to platform devices registration.

MTD guys, if you're ok with this patch I'd like to queue it for 2.6.27.

  Ralf
