Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fALE0m906805
	for linux-mips-outgoing; Wed, 21 Nov 2001 06:00:48 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fALE0jo06795
	for <linux-mips@oss.sgi.com>; Wed, 21 Nov 2001 06:00:45 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fALD0e121274;
	Thu, 22 Nov 2001 00:00:40 +1100
Date: Thu, 22 Nov 2001 00:00:40 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: FP exception statistics
Message-ID: <20011122000040.A19180@dea.linux-mips.net>
References: <20011121.160347.48536367.nemoto@toshiba-tops.co.jp> <20011121192530.A13414@dea.linux-mips.net> <20011121.202906.28780735.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011121.202906.28780735.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Nov 21, 2001 at 08:29:06PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Nov 21, 2001 at 08:29:06PM +0900, Atsushi Nemoto wrote:

> Yes, my patch provides "CPU" statistics (not "thread" statistics).
> Counting per thread might be useful in some case, but counting
> globally (like "unaligned_instructions" or "ll_ops" counter) is enough
> for me.

Those are certainly unlucky examples for performance counter interfaces.
We have further problems to solve in that area.  Many current cpus
implement performance counters and right now Linux/MIPS doesn't use or
support those at all.  Unfortunately performance counter implementations
differ wildly.  We have to deciede about an interface that's supportable
by all the hardware out there.

  Ralf
