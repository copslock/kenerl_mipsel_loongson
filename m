Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2007 16:17:06 +0000 (GMT)
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:48294 "EHLO
	mtagate4.uk.ibm.com") by ftp.linux-mips.org with ESMTP
	id S20039047AbXBKQRB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Feb 2007 16:17:01 +0000
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l1BGFtUl098518;
	Sun, 11 Feb 2007 16:15:55 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1BGFtLJ1884306;
	Sun, 11 Feb 2007 16:15:55 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1BGFs8u023924;
	Sun, 11 Feb 2007 16:15:55 GMT
Received: from localhost (ICON-9-164-132-193.megacenter.de.ibm.com [9.164.132.193])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l1BGFsQu023921;
	Sun, 11 Feb 2007 16:15:54 GMT
Date:	Sun, 11 Feb 2007 17:14:46 +0100
From:	Heiko Carstens <heiko.carstens@de.ibm.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Woodhouse <dwmw2@infradead.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
Subject: Re: -mm merge plans for 2.6.21
Message-ID: <20070211161446.GB11547@osiris.ibm.com>
References: <20070208150710.1324f6b4.akpm@linux-foundation.org> <1171042535.29713.96.camel@pmac.infradead.org> <20070209134516.2367a7aa.akpm@linux-foundation.org> <1171058342.29713.136.camel@pmac.infradead.org> <Pine.LNX.4.64.0702091442230.2786@alien.or.mcafeemobile.com> <20070210102205.GB8145@osiris.boeblingen.de.ibm.com> <1171103527.29713.228.camel@pmac.infradead.org> <20070210213447.GB9116@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070210213447.GB9116@linux-mips.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Return-Path: <heiko.carstens@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko.carstens@de.ibm.com
Precedence: bulk
X-list: linux-mips

On Sat, Feb 10, 2007 at 09:34:47PM +0000, Ralf Baechle wrote:
> On Sat, Feb 10, 2007 at 10:32:07AM +0000, David Woodhouse wrote:
> 
> > On Sat, 2007-02-10 at 11:22 +0100, Heiko Carstens wrote:
> > > Which remembers me that I think that MIPS is using the non-compat version
> > > of sys_epoll_pwait for compat syscalls. But maybe MIPS doesn't need a compat
> > > syscall for some reason. Dunno. 
> > 
> > It's OK as long as the 64-bit kernel, N32 and O32 userspace all agree
> > there there's 32 bits of padding between the fields of this structure:
> > 
> > struct epoll_event {
> >         __u32 events;
> >         __u64 data;
> > };
> > 
> > I suspect it's a fairly safe bet that N32 userspace agrees; if the O32
> > ABI is different then it would need the compat syscall.
> 
> That is correct - and apparently for all ABIs because I wasn't able to find
> a compat_sys_epoll_pwait at all.

Hmm.. so you don't need to do some fancy compat conversion for the sigset_t
that gets passed? Why is that? I don't get it...
