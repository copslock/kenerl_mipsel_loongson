Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAL9Phg12983
	for linux-mips-outgoing; Wed, 21 Nov 2001 01:25:43 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAL9PZo12963
	for <linux-mips@oss.sgi.com>; Wed, 21 Nov 2001 01:25:41 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAL8PUC13477;
	Wed, 21 Nov 2001 19:25:30 +1100
Date: Wed, 21 Nov 2001 19:25:30 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: FP exception statistics
Message-ID: <20011121192530.A13414@dea.linux-mips.net>
References: <20011121.160347.48536367.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011121.160347.48536367.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Nov 21, 2001 at 04:03:47PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Nov 21, 2001 at 04:03:47PM +0900, Atsushi Nemoto wrote:

> Sometimes I want to know what kind of (and how many times) FP
> exceptions occurred in run time.  Here is a patch to provide us these
> informations via /proc/cpuinfo.
> 
> Any comments are welcome.  (This patch is not tested on SMP)

It get's atomicity wrong.  I suggest to make such statistics a per thread
thing.  That'll not only solve the SMP issues but also make sure processes
running in parallel won't influence the result.

  Ralf
