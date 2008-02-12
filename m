Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Feb 2008 12:11:39 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:26796 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030977AbYBLMLh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Feb 2008 12:11:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1CCBZXi030730;
	Tue, 12 Feb 2008 12:11:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1CCBZ5j030729;
	Tue, 12 Feb 2008 12:11:35 GMT
Date:	Tue, 12 Feb 2008 12:11:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fix broken rm7000/rm9000 interrupt handling
Message-ID: <20080212121135.GA30703@linux-mips.org>
References: <200802112342.13435.thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200802112342.13435.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 11, 2008 at 11:42:12PM +0100, Thomas Koeller wrote:

> Properly acknowledge RM7K and RM9K interrupts. Before this,
> interrupts were permanently masked after their first occurrence,
> making them non-functional.

Applied to 2.6.20 and up.  Thanks,

  Ralf
