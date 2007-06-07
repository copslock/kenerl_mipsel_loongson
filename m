Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 18:44:06 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:9447 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027225AbXFGRoE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 18:44:04 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57Hd5Pw002569;
	Thu, 7 Jun 2007 18:39:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57Hd423002568;
	Thu, 7 Jun 2007 18:39:04 +0100
Date:	Thu, 7 Jun 2007 18:39:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Unify watch.S and remove arch/mips/lib-{32,64}
Message-ID: <20070607173904.GA1893@linux-mips.org>
References: <20070605.000239.31638706.anemo@mba.ocn.ne.jp> <20070604151048.GA30128@linux-mips.org> <20070605.012807.112854731.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070605.012807.112854731.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 05, 2007 at 01:28:07AM +0900, Atsushi Nemoto wrote:

> OK, then this is an alternative patch to drop them.

Wonderful, so arch/mips/lib-{32,64} is history now.

Thanks!

  Ralf
