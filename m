Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 15:26:29 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:25292
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20027440AbYGRO0R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 15:26:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6IEQEct025500;
	Fri, 18 Jul 2008 15:26:14 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6IEQD4X025498;
	Fri, 18 Jul 2008 15:26:13 +0100
Date:	Fri, 18 Jul 2008 15:26:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix Cobalt I/O port resource range
Message-ID: <20080718142613.GA25491@linux-mips.org>
References: <20080718230315.7a08ffed.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080718230315.7a08ffed.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 18, 2008 at 11:03:15PM +0900, Yoichi Yuasa wrote:

> LCD and buttons don't use I/O port space.

Makes sense, applied.

  Ralf
