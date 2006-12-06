Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 13:44:24 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:26332 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037869AbWLFNoW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 13:44:22 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB6C7IgE013773;
	Wed, 6 Dec 2006 12:09:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB6C7HiL013772;
	Wed, 6 Dec 2006 12:07:17 GMT
Date:	Wed, 6 Dec 2006 12:07:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
Message-ID: <20061206120717.GA13744@linux-mips.org>
References: <20061205195702.GA2097@linux-mips.org> <20061206.103923.71086192.nemoto@toshiba-tops.co.jp> <20061206015818.GB27985@linux-mips.org> <20061206.115602.63741871.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206.115602.63741871.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 06, 2006 at 11:56:02AM +0900, Atsushi Nemoto wrote:
> Date:	Wed, 06 Dec 2006 11:56:02 +0900 (JST)
> To:	ralf@linux-mips.org
> Cc:	linux-mips@linux-mips.org
> Subject: Re: [PATCH] Import updates from i386's i8259.c
> From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Content-Type: Text/Plain; charset=us-ascii
> 
> On Wed, 6 Dec 2006 01:58:18 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > There are some other issues with the legacy IDE on the Intel PIIX which
> > likely affect other systems such as Alpha as well.  I think I solved that
> > so it's now time to tackle the IRQ stuff.  Even without your i8259 stuff
> > there are some strange things going on currently:
> > 
> > [...]
> > irq 7, desc: 803db360, depth: 1, count: 0, unhandled: 0
> > ->handle_irq():  8014ff28, handle_bad_irq+0x0/0x318
> > ->chip(): 803a3d4c, 0x803a3d4c
> > ->action(): 00000000
> >   IRQ_DISABLED set
> > unexpected IRQ # 7
> 
> Hmm ... malta_int.c:get_int() returned 7?  I have no idea, but it
> seems mips_irq_lock in malta_int.c can be replaced by i8259A_lock...

Your new patch works and also resolves this issue.

  Ralf
