Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Mar 2007 22:05:38 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:50899 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037729AbXCDWFh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Mar 2007 22:05:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l24M3l50013751;
	Sun, 4 Mar 2007 22:03:47 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l24M3kOQ013750;
	Sun, 4 Mar 2007 22:03:46 GMT
Date:	Sun, 4 Mar 2007 22:03:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove redundant tx39_blast_icache() calls
Message-ID: <20070304220346.GA13508@linux-mips.org>
References: <20070305.004139.89066671.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070305.004139.89066671.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 05, 2007 at 12:41:39AM +0900, Atsushi Nemoto wrote:

> Apply commit 0550d9d13e02b30efa117d47fcadea450bb23d23 to c-tx39.c too.
> And fix a warning in local_tx39_flush_data_cache_page().

Applied, thanks.

  Ralf
