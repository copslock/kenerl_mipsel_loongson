Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 22:57:54 +0000 (GMT)
Received: from mo00.po.2iij.net ([210.130.202.204]:7917 "EHLO mo00.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133507AbWBNW5p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2006 22:57:45 +0000
Received: NPO MO00 id k1EN422E017301; Wed, 15 Feb 2006 08:04:02 +0900 (JST)
Received: from stratos (87.26.30.125.dy.iij4u.or.jp [125.30.26.87])
	by mbox.po.2iij.net (NPO-MR/mbox01) id k1EN41T8007816
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Wed, 15 Feb 2006 08:04:01 +0900 (JST)
Date:	Wed, 15 Feb 2006 08:04:00 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, tbm@cyrius.com, macro@linux-mips.org,
	p2@mind.be, linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-Id: <20060215080400.0e523f60.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060214162722.GD21016@linux-mips.org>
References: <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl>
	<20060124122700.GA8527@deprecation.cyrius.com>
	<Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl>
	<20060124232117.GA4165@codecarver>
	<Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl>
	<20060203150232.GA25701@deprecation.cyrius.com>
	<Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl>
	<20060213223951.GA4226@deprecation.cyrius.com>
	<20060213224733.GA4983@deprecation.cyrius.com>
	<20060214162722.GD21016@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 10465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 14 Feb 2006 16:27:22 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Feb 13, 2006 at 10:47:33PM +0000, Martin Michlmayr wrote:
> 
> > >   LD      .tmp_vmlinux1
> > > arch/mips/kernel/built-in.o: In function `einval':arch/mips/kernel/scall32-o32.S:(.text+0xb6c0): undefined reference to `sys_newfstatat'
> > > 
> > > This is with binutils 2.16.1cvs20060117-1 and gcc 4.0.3 20051201.
> > 
> > I see a fix for this just went into Linus' git tree.  Can we have this
> > in the linux-mips tree too please.
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=326a625748535c4cdb1c632b1dcb07030989a393
> 
> Ah, Yoichi at it again.  He really loves sending patches upstream without
> letting me know.

Sorry, I forgot add Cc: .

Yoichi
