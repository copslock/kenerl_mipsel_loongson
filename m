Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 17:23:31 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:1237 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022694AbXFGQX3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 17:23:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57GGTLE030066;
	Thu, 7 Jun 2007 17:16:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57GGSgi030065;
	Thu, 7 Jun 2007 17:16:28 +0100
Date:	Thu, 7 Jun 2007 17:16:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove unused time.c for swarm
Message-ID: <20070607161628.GA30044@linux-mips.org>
References: <20070607222750.5f43aa85.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070607222750.5f43aa85.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 07, 2007 at 10:27:50PM +0900, Yoichi Yuasa wrote:

> This patch has removed unused time.c for swarm.

Thanks, I've put this into the -time patch series.  One file less to
clean.

  Ralf
