Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2007 16:13:53 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:37022 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039452AbXBRQNw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Feb 2007 16:13:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1IGDqIp029527;
	Sun, 18 Feb 2007 16:13:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1IGDq0f029526;
	Sun, 18 Feb 2007 16:13:52 GMT
Date:	Sun, 18 Feb 2007 16:13:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make __declare_dbe_table() static
Message-ID: <20070218161352.GC24660@linux-mips.org>
References: <20070219.004435.25910295.anemo@mba.ocn.ne.jp> <20070218155408.GA24660@linux-mips.org> <20070219.005850.96686775.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070219.005850.96686775.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 19, 2007 at 12:58:50AM +0900, Atsushi Nemoto wrote:

> On Sun, 18 Feb 2007 15:54:08 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > Make __declare_dbe_table() static and call it explicitly to ensure not
> > > optimized out.
> > 
> > That's what __attribute_used__ was meant to be used for.
> 
> But we do not need empty __declare_dbe_table() function body (jr ra +
> nop) at all.  If we called it explicitly, compiler will optimized it
> out.  Saves two instructions ;)

_asm__(
"       .section        __dbe_table, \"a\"\n"
"       .previous                       \n");

is even simpler :-)

  Ralf
