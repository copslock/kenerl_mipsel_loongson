Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 17:28:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38881 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039109AbXJQQ2i (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 17:28:38 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9HGScEh006156;
	Wed, 17 Oct 2007 17:28:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9HGSbr3006155;
	Wed, 17 Oct 2007 17:28:37 +0100
Date:	Wed, 17 Oct 2007 17:28:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: plat_timer_setup, mips_timer_ack, etc.
Message-ID: <20071017162837.GA5491@linux-mips.org>
References: <20071017.005211.108739735.anemo@mba.ocn.ne.jp> <20071016163610.GA25794@linux-mips.org> <20071017.020113.63743059.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071017.020113.63743059.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 17, 2007 at 02:01:13AM +0900, Atsushi Nemoto wrote:

> On Tue, 16 Oct 2007 17:36:10 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > Also I found mips_timer_ack and cycles_per_jiffy are not used now.
> > > Can we remove them entirely?
> > 
> > I think so.  Each clockevent device should rather try to be independent
> > of others.  What made the old timer code such a mess is that it was
> > desparately trying to share resources giving everybody plenty of rope ...
> 
> So all mips_timer_ack users should implement its own clockevent
> device, right?

Yes.

> $ git-grep mips_timer_ack arch/mips
> arch/mips/dec/time.c:   mips_timer_ack = dec_timer_ack;
> arch/mips/jmr3927/rbhma3100/setup.c:    mips_timer_ack = jmr3927_timer_ack;
> arch/mips/philips/pnx8550/common/time.c:        mips_timer_ack = timer_ack;
> arch/mips/sni/time.c:        mips_timer_ack = sni_a20r_timer_ack;

Not too many then I guess ;-)

  Ralf
