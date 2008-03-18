Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 13:27:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:6619 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28639340AbYCRN1K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Mar 2008 13:27:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2IDRAqA013484;
	Tue, 18 Mar 2008 13:27:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2IDR9vc013483;
	Tue, 18 Mar 2008 13:27:09 GMT
Date:	Tue, 18 Mar 2008 13:27:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2][MIPS] replace c0_compare acknowledge by
	c0_timer_ack()
Message-ID: <20080318132709.GC11382@linux-mips.org>
References: <20080317234740.705a8a34.yoichi_yuasa@tripeaks.co.jp> <20080317161635.GA25549@linux-mips.org> <200803180447.m2I4lJ40005091@po-mbox301.hop.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200803180447.m2I4lJ40005091@po-mbox301.hop.2iij.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 18, 2008 at 01:47:20PM +0900, Yoichi Yuasa wrote:

> On Mon, 17 Mar 2008 16:16:35 +0000
> Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> > On Mon, Mar 17, 2008 at 11:47:40PM +0900, Yoichi Yuasa wrote:
> > 
> > > VR41xx, CP0 hazard is necessary between read_c0_count() and write_c0_compare().
> > 
> > Interesting.  I wonder why you need this patch but nobody else?
> 
> Three NOP are necessary on the TB0287(VR4131 board).

That much was obvious from your patch.  I was more wondering about this
change:

-               write_c0_compare(read_c0_count());
+               c0_timer_ack();

c0_timer_ack is defined as

static void c0_timer_ack(void)
{
        write_c0_compare(read_c0_compare());
}

so your patch does a functional change there - even though it should not
actually matter.  So I was wondering if for some reason you need that
change.

Just interested - it looks a bit cleaner so I'm leaning to apply this
change anyway.

  Ralf
