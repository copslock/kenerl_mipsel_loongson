Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 12:19:15 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:8597 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039432AbWH2LTN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 12:19:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k7TBJdLw027050;
	Tue, 29 Aug 2006 12:19:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7TBJdXS027049;
	Tue, 29 Aug 2006 12:19:39 +0100
Date:	Tue, 29 Aug 2006 12:19:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	thomas@koeller.dyndns.org
Cc:	linux-mips@linux-mips.org,
	Thomas =?iso-8859-1?Q?K=F6ller?= <thomas.koeller@baslerweb.com>
Subject: Re: [PATCH] Move excite_fpga.h to include/asm-mips/mach-excite
Message-ID: <20060829111517.GA25039@linux-mips.org>
References: <200608271354.31525.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608271354.31525.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 27, 2006 at 01:54:31PM +0200, thomas@koeller.dyndns.org wrote:

> excite_fpga.h, like all platform headers, really belongs in the
> platform header directory.
> 
> Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>

Applied - but I had to edit the patch file, long lines had been wrapped.

  Ralf
