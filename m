Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBQLiXt26503
	for linux-mips-outgoing; Wed, 26 Dec 2001 13:44:33 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBQLiTX26496
	for <linux-mips@oss.sgi.com>; Wed, 26 Dec 2001 13:44:30 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBP3f3x16237;
	Tue, 25 Dec 2001 01:41:03 -0200
Date: Tue, 25 Dec 2001 01:41:03 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: a small patch for latest (2.4.15+) unaligned.c
Message-ID: <20011225014103.B1296@dea.linux-mips.net>
References: <20011205.171232.115909036.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011205.171232.115909036.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Dec 05, 2001 at 05:12:32PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Dec 05, 2001 at 05:12:32PM +0900, Atsushi Nemoto wrote:

> The latest arch/mips/kernel/unaligned.c loses some jump instructions
> in .fixup section.  Here is a patch to fix it.  This patch is created
> with linux_2_4 branch but can be applied to MAIN trunk also.

It took a while but I applied it.

Thanks,

  Ralf
