Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 18:57:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:54751 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022676AbXC0R5j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 18:57:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2RHvYoH026539;
	Tue, 27 Mar 2007 18:57:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2RHvXTa026538;
	Tue, 27 Mar 2007 18:57:33 +0100
Date:	Tue, 27 Mar 2007 18:57:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Early printk recent changes.
Message-ID: <20070327175733.GA26496@linux-mips.org>
References: <cda58cb80703270716s6c95c66cgd03482a4852a69eb@mail.gmail.com> <Pine.LNX.4.64N.0703271526000.5547@blysk.ds.pg.gda.pl> <cda58cb80703270803g7c1119e4w22272e9e18c0d251@mail.gmail.com> <Pine.LNX.4.64N.0703271620080.5547@blysk.ds.pg.gda.pl> <cda58cb80703270906j74d6bf6fsb6259f24427faff5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80703270906j74d6bf6fsb6259f24427faff5@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 27, 2007 at 06:06:10PM +0200, Franck Bui-Huu wrote:

> > In this case I gather this was a bulk change and some platforms have
> >benefited and the DECstation has lost.  You seem to have problems as well.
> >These issues can be dealt with somehow and they do not mean the change was
> >bad as a whole.
> 
> I think that's the reason why I started this thread: To see if this
> change is good and really woth...
> 
> Making a new file 'early_printk' to gather 3 tiny functions. In the
> other way we lose the possibilty to register the console earlier, and
> we need to make some hacks to configure the console if it needs to be.
> 
> I understand that such change is needed by x86 arch but for mips I'm 
> skeptical.

I decieded to rush the whole early printk thing since we had several
copies of early printk in the MIPS code already.  Add plenty of
variations of prom_putchar / prom_printf.  We certainly now have less
loose ends in the code than before.  And since we're always in the trade
of better mouse trap I certainly won't object if submits has one :-)

  Ralf
