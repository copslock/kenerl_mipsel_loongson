Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 17:21:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:31972 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023628AbXFSQVb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2007 17:21:31 +0100
Received: from localhost (p2028-ipad208funabasi.chiba.ocn.ne.jp [60.43.103.28])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A88C0A7B3; Wed, 20 Jun 2007 01:21:27 +0900 (JST)
Date:	Wed, 20 Jun 2007 01:22:06 +0900 (JST)
Message-Id: <20070620.012206.30438292.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	sknauert@wesleyan.edu, linux-mips@linux-mips.org
Subject: Re: Legacy PCI IO for PCI graphics on SGI O2...Anybody?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0706191246060.15474@blysk.ds.pg.gda.pl>
References: <54672.129.133.92.31.1182184357.squirrel@webmail.wesleyan.edu>
	<20070619.121030.130240189.nemoto@toshiba-tops.co.jp>
	<Pine.LNX.4.64N.0706191246060.15474@blysk.ds.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 19 Jun 2007 13:03:24 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  That should be taken care of in glibc (or your libc of choice) -- with 
> ioperm() or iopl() and then in{b,w,l}() and out{b,w,l}() as appropriate.  
> Either of the two formers are used to mmap() the right area of /dev/mem 
> and then the latters are used access the area with the desired width (and 
> stride, if applicable -- portable code should not assume subsequent I/O 
> port addresses are adjacent in the MMIO space).  It has worked like this 
> for other platforms for at least ten years now.
> 
>  Of course the function doing mmap() still has to know the CPU physical 
> address of the I/O space from somewhere.  For quite some time my feeling 
> has been it should come from /proc/iomem, where we actually fail to 
> register the I/O space, but these days sysfs is probably better (though I 
> plan to have a look at /proc/iomem for the use of human beings anyway).  

Oh I thought ioperm() or iopl() on archs other then x86 are all dummy
routines, but apparently that was wrong.  Now I have looked some
ioperm.c in glibc and am very suprised by so many hard-coded
boardname/addresses ;)

>  That still does not solve the problem of multiple independent I/O spaces, 
> but I gather such configurations are very rare indeed.

I agree.
---
Atsushi Nemoto
