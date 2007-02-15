Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 23:41:45 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.24]:40599 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20037648AbXBOXlk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Feb 2007 23:41:40 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1FNcOhB032352
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Feb 2007 15:38:24 -0800
Received: from akpm.corp.google.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l1FNcNqp012309;
	Thu, 15 Feb 2007 15:38:24 -0800
Date:	Thu, 15 Feb 2007 15:38:23 -0800
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Optimize generic get_unaligned / put_unaligned
 implementations.
Message-Id: <20070215153823.239fd616.akpm@linux-foundation.org>
In-Reply-To: <20070215221839.GA14103@linux-mips.org>
References: <20050830104056.GA4710@linux-mips.org>
	<20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
	<20060306170552.0aab29c5.akpm@osdl.org>
	<20070214214226.GA17899@linux-mips.org>
	<20070214203903.8d013170.akpm@linux-foundation.org>
	<20070215143441.GA18155@linux-mips.org>
	<20070215135358.020781dd.akpm@linux-foundation.org>
	<20070215221839.GA14103@linux-mips.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 15 Feb 2007 22:18:39 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Thu, Feb 15, 2007 at 01:53:58PM -0800, Andrew Morton wrote:
> 
> > > The whole union thing was only needed to get rid of a warning but Marcel's
> > > solution does the same thing by attaching the packed keyword to the entire
> > > structure instead, so this patch is now using his macros but using __packed
> > > instead.
> > 
> > How do we know this trick will work as-designed across all versions of gcc
> > and icc (at least) and for all architectures and for all sets of compiler
> > options?
> > 
> > Basically, it has to be guaranteed by a C standard.  Is it?
> 
> Gcc info page says:
> 
> [...]
> `packed'
>      The `packed' attribute specifies that a variable or structure field
>      should have the smallest possible alignment--one byte for a
>      variable, and one bit for a field, unless you specify a larger
>      value with the `aligned' attribute.
> [...]
> 

hm.  So if I have

	struct bar {
		unsigned long b;
	} __attribute__((packed));

	struct foo {
		unsigned long u;
		struct bar b;
	};

then the compiler can see that foo.b.b is well-aligned, regardless of the
packedness.

Plus some crazy people compile the kernel with icc (or at least they used
to).  What happens there?

> Qed?

worried.
