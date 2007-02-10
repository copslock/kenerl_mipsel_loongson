Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2007 02:51:26 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:35206 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038444AbXBKCuv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Feb 2007 02:50:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1ALYlFh010856;
	Sat, 10 Feb 2007 21:37:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1ALYl8e010855;
	Sat, 10 Feb 2007 21:34:47 GMT
Date:	Sat, 10 Feb 2007 21:34:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Woodhouse <dwmw2@infradead.org>
Cc:	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
Subject: Re: -mm merge plans for 2.6.21
Message-ID: <20070210213447.GB9116@linux-mips.org>
References: <20070208150710.1324f6b4.akpm@linux-foundation.org> <1171042535.29713.96.camel@pmac.infradead.org> <20070209134516.2367a7aa.akpm@linux-foundation.org> <1171058342.29713.136.camel@pmac.infradead.org> <Pine.LNX.4.64.0702091442230.2786@alien.or.mcafeemobile.com> <20070210102205.GB8145@osiris.boeblingen.de.ibm.com> <1171103527.29713.228.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1171103527.29713.228.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 10, 2007 at 10:32:07AM +0000, David Woodhouse wrote:

> On Sat, 2007-02-10 at 11:22 +0100, Heiko Carstens wrote:
> > Which remembers me that I think that MIPS is using the non-compat version
> > of sys_epoll_pwait for compat syscalls. But maybe MIPS doesn't need a compat
> > syscall for some reason. Dunno. 
> 
> It's OK as long as the 64-bit kernel, N32 and O32 userspace all agree
> there there's 32 bits of padding between the fields of this structure:
> 
> struct epoll_event {
>         __u32 events;
>         __u64 data;
> };
> 
> I suspect it's a fairly safe bet that N32 userspace agrees; if the O32
> ABI is different then it would need the compat syscall.

That is correct - and apparently for all ABIs because I wasn't able to find
a compat_sys_epoll_pwait at all.

Unfortunately struct epoll_event contains a gap so it bets on identical
padding rules between native and compat ABI and anyway, padding is wasted
space so the struct members should have been swapped when this structure
was created.  Oh well, too late.

  Ralf
