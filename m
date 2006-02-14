Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 16:26:06 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:52505 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133476AbWBNQZ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 16:25:57 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1EGRMJ0030836;
	Tue, 14 Feb 2006 16:27:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1EGRMwf030835;
	Tue, 14 Feb 2006 16:27:22 GMT
Date:	Tue, 14 Feb 2006 16:27:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"Peter 'p2' De Schrijver" <p2@mind.be>, linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060214162722.GD21016@linux-mips.org>
References: <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl> <20060124122700.GA8527@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver> <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl> <20060203150232.GA25701@deprecation.cyrius.com> <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl> <20060213223951.GA4226@deprecation.cyrius.com> <20060213224733.GA4983@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213224733.GA4983@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 13, 2006 at 10:47:33PM +0000, Martin Michlmayr wrote:

> >   LD      .tmp_vmlinux1
> > arch/mips/kernel/built-in.o: In function `einval':arch/mips/kernel/scall32-o32.S:(.text+0xb6c0): undefined reference to `sys_newfstatat'
> > 
> > This is with binutils 2.16.1cvs20060117-1 and gcc 4.0.3 20051201.
> 
> I see a fix for this just went into Linus' git tree.  Can we have this
> in the linux-mips tree too please.
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=326a625748535c4cdb1c632b1dcb07030989a393

Ah, Yoichi at it again.  He really loves sending patches upstream without
letting me know.

  Ralf
