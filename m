Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2007 13:58:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:24523 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20028948AbXH1M61 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Aug 2007 13:58:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7SCwQad003336;
	Tue, 28 Aug 2007 13:58:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7SCwPLl003335;
	Tue, 28 Aug 2007 13:58:25 +0100
Date:	Tue, 28 Aug 2007 13:58:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, debian-users@cantastic.de
Subject: Re: [PATCH] tx4927: Cleanup unused macros and non-standard IO
	accessors.
Message-ID: <20070828125825.GA31568@linux-mips.org>
References: <20070828.002809.122594486.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070828.002809.122594486.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 28, 2007 at 12:28:09AM +0900, Atsushi Nemoto wrote:

> This patch removes many unused constants, replaces non-standard IO
> accessors with standard ones, and kills terrible tx4927_mips.h file.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Queued for 2.6.24.  Thanks!

  Ralf
