Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 20:49:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57196 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493607AbZJHStF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Oct 2009 20:49:05 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n98IoEZL011522;
	Thu, 8 Oct 2009 20:50:14 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n98IoCTg011519;
	Thu, 8 Oct 2009 20:50:12 +0200
Date:	Thu, 8 Oct 2009 20:50:12 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] MIPS: fix pfn_valid() for FLAGMEM
Message-ID: <20091008185012.GA10365@linux-mips.org>
References: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com> <20091008144230.GA682@linux-mips.org> <1255016760.14496.57.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255016760.14496.57.camel@falcon>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 08, 2009 at 11:46:00PM +0800, Wu Zhangjin wrote:

> > Are the non-memory parts marked as reserved?
> > 
> No, so, is that a need to mark them?

Initially all pages are marked as reserved.

Which seems to be good enough for x86:

$ cat /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000c0000-000cffff : pnp 00:0d
000e0000-000fffff : pnp 00:0d
00100000-7fe5b7ff : System RAM
[...]

The 0x9f000 - 0x9ffff range is the good old ISA I/O memory range (classic
MDA/CGA/VGA etc.), that is non-memory yet:

#ifdef CONFIG_FLATMEM
#define pfn_valid(pfn)          ((pfn) < max_mapnr)
#endif /* CONFIG_FLATMEM */

is sufficient on x86 so I think something else must be wrong.

  Ralf
