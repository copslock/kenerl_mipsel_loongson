Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7MBh4F27010
	for linux-mips-outgoing; Wed, 22 Aug 2001 04:43:04 -0700
Received: from dea.linux-mips.net (u-250-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7MBh1927007
	for <linux-mips@oss.sgi.com>; Wed, 22 Aug 2001 04:43:01 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7MBeHO18758;
	Wed, 22 Aug 2001 13:40:17 +0200
Date: Wed, 22 Aug 2001 13:40:17 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: Magic numbers about stack layout
Message-ID: <20010822134017.A18730@dea.linux-mips.net>
References: <20010822.144547.30190293.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010822.144547.30190293.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Aug 22, 2001 at 02:45:47PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 22, 2001 at 02:45:47PM +0900, Atsushi Nemoto wrote:

> There are some magic constant numbers about stack layout in
> thread_saved_pc() and get_wchan() function.
> 
> I made a patch to eliminate these magic numbers.  This patch analyzes
> some functions prologue codes in heuristic way at run-time.  "ps -l"
> (and "MAGIC SYSRQ" feature) works fine with this patch.

Very nice, this part of the kernel used to be rather fragile on all
architectures; when wchan computation broke usually nobody complained
and this looks like a major improvment!

Thanks,

  Ralf
