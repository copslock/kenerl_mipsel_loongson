Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Feb 2008 09:58:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:20373 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28590580AbYB1J65 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Feb 2008 09:58:57 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1S9wuqG006496;
	Thu, 28 Feb 2008 09:58:56 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1S9wuXN006495;
	Thu, 28 Feb 2008 09:58:56 GMT
Date:	Thu, 28 Feb 2008 09:58:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH: linux-mips 2.6.24.2]: Move arch/mips/philips to
	arch/mips/nxp
Message-ID: <20080228095856.GE2750@linux-mips.org>
References: <64660ef00802270316s7164fcf6x5baf67c48029b730@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64660ef00802270316s7164fcf6x5baf67c48029b730@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 27, 2008 at 11:16:50AM +0000, Daniel Laird wrote:

I was looking through my mail in chronological order so I noticed the older
revision of your patch first.

So your mail client scambles inline patches:

Applying patch patches/0004-01.patch
patching file arch/mips/Kconfig
Hunk #1 succeeded at 309 (offset -3 lines).
patching file arch/mips/kernel/cpu-probe.c
Hunk #1 succeeded at 780 (offset 9 lines).
Hunk #3 succeeded at 889 (offset 11 lines).
patching file arch/mips/Makefile
Hunk #1 succeeded at 408 (offset -2 lines).
patching file arch/mips/nxp/pnx8550/common/gdb_hook.c
patch: **** malformed patch at line 273: IP3106_UART_FIFO_TXFIFO) >> 16) >= 16)

Some clients can be convinced to be nice to inline patches.  I've
collected some advice at http://www.linux-mips.org/wiki/Mailing-patches.
If _everything_ else fails, use attachments.

> Signed-off-by: daniel.j.laird <daniel.j.laird@nxp.com>

Yep :-)

  Ralf
