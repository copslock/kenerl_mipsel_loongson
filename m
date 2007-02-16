Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 00:43:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12263 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037758AbXBPAnU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Feb 2007 00:43:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1G0hJnm021963;
	Fri, 16 Feb 2007 00:43:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1G0hHMD021960;
	Fri, 16 Feb 2007 00:43:17 GMT
Date:	Fri, 16 Feb 2007 00:43:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Optimize generic get_unaligned / put_unaligned implementations.
Message-ID: <20070216004317.GA18987@linux-mips.org>
References: <20050830104056.GA4710@linux-mips.org> <20060306.203218.69025300.nemoto@toshiba-tops.co.jp> <20060306170552.0aab29c5.akpm@osdl.org> <20070214214226.GA17899@linux-mips.org> <20070214203903.8d013170.akpm@linux-foundation.org> <20070215143441.GA18155@linux-mips.org> <20070215135358.020781dd.akpm@linux-foundation.org> <20070215221839.GA14103@linux-mips.org> <20070215153823.239fd616.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070215153823.239fd616.akpm@linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 15, 2007 at 03:38:23PM -0800, Andrew Morton wrote:

> hm.  So if I have
> 
> 	struct bar {
> 		unsigned long b;
> 	} __attribute__((packed));
> 
> 	struct foo {
> 		unsigned long u;
> 		struct bar b;
> 	};
> 
> then the compiler can see that foo.b.b is well-aligned, regardless of the
> packedness.
> 
> Plus some crazy people compile the kernel with icc (or at least they used
> to).  What happens there?

A quick grep for __attribute__((packed)) and __packed find around 900 hits,
I'd probably find more if I'd look for syntactical variations.  Some hits
are in arch/{i386,x86_64,ia64}.  At a glance it seems hard to configure a
useful x86 kernel that doesn't involve any packed attribute.  I take that
as statistical proof that icc either has doesn't really work for building
the kernel or groks packing.  Any compiler not implementing gcc extensions
is lost at building the kernel but that's old news.

  Ralf
