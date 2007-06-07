Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 11:48:03 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:42963 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022836AbXFGKq0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 11:46:26 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l577O6C1018012
	for <linux-mips@linux-mips.org>; Thu, 7 Jun 2007 08:24:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l577O6RX018011;
	Thu, 7 Jun 2007 08:24:06 +0100
Date:	Thu, 7 Jun 2007 08:24:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Unify dump_tlb
Message-ID: <20070607072406.GA17555@linux-mips.org>
References: <20070602.002130.41010462.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070602.002130.41010462.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 02, 2007 at 12:21:30AM +0900, Atsushi Nemoto wrote:

> Unify lib-{32,64}/dump_tlb.c into lib/dump_tlb.c and move
> lib-32/r3k_dump_tlb.c to lib directory.

Queued for 2.6.23.  Thanks,

  Ralf
