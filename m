Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2007 16:36:28 +0000 (GMT)
Received: from x35.xmailserver.org ([64.71.152.41]:29966 "EHLO
	x35.xmailserver.org") by ftp.linux-mips.org with ESMTP
	id S20039057AbXBKQgY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Feb 2007 16:36:24 +0000
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S214926> for <linux-mips@linux-mips.org> from <davidel@xmailserver.org>;
	Sun, 11 Feb 2007 11:34:52 -0500
Date:	Sun, 11 Feb 2007 08:34:51 -0800 (PST)
From:	Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To:	Heiko Carstens <heiko.carstens@de.ibm.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
Subject: Re: -mm merge plans for 2.6.21
In-Reply-To: <20070211161446.GB11547@osiris.ibm.com>
Message-ID: <Pine.LNX.4.64.0702110819290.21815@alien.or.mcafeemobile.com>
References: <20070208150710.1324f6b4.akpm@linux-foundation.org>
 <1171042535.29713.96.camel@pmac.infradead.org> <20070209134516.2367a7aa.akpm@linux-foundation.org>
 <1171058342.29713.136.camel@pmac.infradead.org>
 <Pine.LNX.4.64.0702091442230.2786@alien.or.mcafeemobile.com>
 <20070210102205.GB8145@osiris.boeblingen.de.ibm.com>
 <1171103527.29713.228.camel@pmac.infradead.org> <20070210213447.GB9116@linux-mips.org>
 <20070211161446.GB11547@osiris.ibm.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <davidel@xmailserver.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davidel@xmailserver.org
Precedence: bulk
X-list: linux-mips

On Sun, 11 Feb 2007, Heiko Carstens wrote:

> On Sat, Feb 10, 2007 at 09:34:47PM +0000, Ralf Baechle wrote:
> > On Sat, Feb 10, 2007 at 10:32:07AM +0000, David Woodhouse wrote:
> > 
> > > On Sat, 2007-02-10 at 11:22 +0100, Heiko Carstens wrote:
> > > > Which remembers me that I think that MIPS is using the non-compat version
> > > > of sys_epoll_pwait for compat syscalls. But maybe MIPS doesn't need a compat
> > > > syscall for some reason. Dunno. 
> > > 
> > > It's OK as long as the 64-bit kernel, N32 and O32 userspace all agree
> > > there there's 32 bits of padding between the fields of this structure:
> > > 
> > > struct epoll_event {
> > >         __u32 events;
> > >         __u64 data;
> > > };
> > > 
> > > I suspect it's a fairly safe bet that N32 userspace agrees; if the O32
> > > ABI is different then it would need the compat syscall.
> > 
> > That is correct - and apparently for all ABIs because I wasn't able to find
> > a compat_sys_epoll_pwait at all.
> 
> Hmm.. so you don't need to do some fancy compat conversion for the sigset_t
> that gets passed? Why is that? I don't get it...

The compat_sys_epoll_pwait function has two sources of compat. One is the 
sigset_t and the other one is the struct epoll_event. The sigset_t compat 
is always needed, while the struct epoll_event may be needed. The code of 
(upcoming) compat_sys_epoll_pwait takes care of both, with a smart 
compile-time check to wire sys_epoll_wait or compat_sys_epoll_wait, 
depending on the need of the struct epoll_event compat handling.
So yes, compat_sys_epoll_pwait is needed.



- Davide
