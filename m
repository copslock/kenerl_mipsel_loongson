Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 17:10:08 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2771 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133720AbWEBQKA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 17:10:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k42G9x6C016049;
	Tue, 2 May 2006 17:09:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k42G9w5u016048;
	Tue, 2 May 2006 17:09:58 +0100
Date:	Tue, 2 May 2006 17:09:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Randy.Dunlap" <rdunlap@xenotime.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: SETNAME (set nodename) in syscall.c
Message-ID: <20060502160958.GB15052@linux-mips.org>
References: <Pine.LNX.4.58.0604292059210.24032@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0604292059210.24032@shark.he.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 29, 2006 at 09:01:59PM -0700, Randy.Dunlap wrote:

> In arch/mips/syscall.c::_sys_sysmips(), case SETNAME,
> isn't one of the strncpy() and strlcpy() unneeded?
> 
> 		down_write(&uts_sem);
> 		strncpy(system_utsname.nodename, nodename, len);
> 		nodename[__NEW_UTS_LEN] = '\0';
> 		strlcpy(system_utsname.nodename, nodename,
> 		        sizeof(system_utsname.nodename));
> 		up_write(&uts_sem);

Seems that came with the 2.5.70 merge and got copied and moved around a
few times since.  I'm pretty sure the whole sysmips(SETNAME, ...)
operation is unused.

Any objections again removal of sysmips(SETNAME, ...) support?

  Ralf
