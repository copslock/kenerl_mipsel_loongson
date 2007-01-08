Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2007 16:26:16 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:13191 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574123AbXAHQ0O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jan 2007 16:26:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l08GR3gp007260;
	Mon, 8 Jan 2007 16:27:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l08GR2mK007259;
	Mon, 8 Jan 2007 16:27:02 GMT
Date:	Mon, 8 Jan 2007 16:27:02 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Unify memset.S
Message-ID: <20070108162702.GA5763@linux-mips.org>
References: <20061218.000740.08076708.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218.000740.08076708.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 18, 2006 at 12:07:40AM +0900, Atsushi Nemoto wrote:

> The 32-bit version and 64-bit version are almost equal.  Unify them.
> This makes further improvements (for example, supporting CDEX, etc.)
> easier.

Queued for 2.6.21 as well.  Thanks,

  Ralf
