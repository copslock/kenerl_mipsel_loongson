Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Feb 2007 10:24:25 +0000 (GMT)
Received: from mtagate6.de.ibm.com ([195.212.29.155]:59957 "EHLO
	mtagate6.de.ibm.com") by ftp.linux-mips.org with ESMTP
	id S20037476AbXBJKYU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Feb 2007 10:24:20 +0000
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1AANE5g036144;
	Sat, 10 Feb 2007 10:23:14 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com [9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1AANEdN1384540;
	Sat, 10 Feb 2007 11:23:14 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1AANEPW027364;
	Sat, 10 Feb 2007 11:23:14 +0100
Received: from localhost (dyn-9-152-198-88.boeblingen.de.ibm.com [9.152.198.88])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l1AANEjR027361;
	Sat, 10 Feb 2007 11:23:14 +0100
Date:	Sat, 10 Feb 2007 11:22:05 +0100
From:	Heiko Carstens <heiko.carstens@de.ibm.com>
To:	Davide Libenzi <davidel@xmailserver.org>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Cc:	David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
Subject: Re: -mm merge plans for 2.6.21
Message-ID: <20070210102205.GB8145@osiris.boeblingen.de.ibm.com>
References: <20070208150710.1324f6b4.akpm@linux-foundation.org> <1171042535.29713.96.camel@pmac.infradead.org> <20070209134516.2367a7aa.akpm@linux-foundation.org> <1171058342.29713.136.camel@pmac.infradead.org> <Pine.LNX.4.64.0702091442230.2786@alien.or.mcafeemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702091442230.2786@alien.or.mcafeemobile.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Return-Path: <heiko.carstens@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko.carstens@de.ibm.com
Precedence: bulk
X-list: linux-mips

On Fri, Feb 09, 2007 at 02:50:12PM -0800, Davide Libenzi wrote:
> On Fri, 9 Feb 2007, David Woodhouse wrote:
> 
> > On Fri, 2007-02-09 at 13:45 -0800, Andrew Morton wrote:
> > > > I would strongly recommend that in the general case, you don't merge new
> > > > system calls unless the corresponding compat_ system call is
> > > > implemented.
> > > 
> > > Good point. 
> > 
> > It's a _damn_ good point, but I see we went ahead and merged
> > sys_epoll_pwait without it anyway -- despite the fact that it's
> > include/linux/eventpoll.h which contains the example of why we should
> > think first :)
> > 
> > I think I even threw together an untested implementation of
> > compat_sys_epoll_pwait() at one point to assist with that task, but it
> > didn't seem to help much.
> 
> Damn! I always forget. Doing it right now ...

Which remembers me that I think that MIPS is using the non-compat version
of sys_epoll_pwait for compat syscalls. But maybe MIPS doesn't need a compat
syscall for some reason. Dunno.
