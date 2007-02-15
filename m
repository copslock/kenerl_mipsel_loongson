Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 22:18:44 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:37273 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037553AbXBOWSn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 22:18:43 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1FMIfZp014744;
	Thu, 15 Feb 2007 22:18:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1FMIdGY014743;
	Thu, 15 Feb 2007 22:18:39 GMT
Date:	Thu, 15 Feb 2007 22:18:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Optimize generic get_unaligned / put_unaligned implementations.
Message-ID: <20070215221839.GA14103@linux-mips.org>
References: <20050830104056.GA4710@linux-mips.org> <20060306.203218.69025300.nemoto@toshiba-tops.co.jp> <20060306170552.0aab29c5.akpm@osdl.org> <20070214214226.GA17899@linux-mips.org> <20070214203903.8d013170.akpm@linux-foundation.org> <20070215143441.GA18155@linux-mips.org> <20070215135358.020781dd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070215135358.020781dd.akpm@linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 15, 2007 at 01:53:58PM -0800, Andrew Morton wrote:

> > The whole union thing was only needed to get rid of a warning but Marcel's
> > solution does the same thing by attaching the packed keyword to the entire
> > structure instead, so this patch is now using his macros but using __packed
> > instead.
> 
> How do we know this trick will work as-designed across all versions of gcc
> and icc (at least) and for all architectures and for all sets of compiler
> options?
> 
> Basically, it has to be guaranteed by a C standard.  Is it?

Gcc info page says:

[...]
`packed'
     The `packed' attribute specifies that a variable or structure field
     should have the smallest possible alignment--one byte for a
     variable, and one bit for a field, unless you specify a larger
     value with the `aligned' attribute.
[...]

Qed?

  Ralf
