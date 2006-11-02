Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2006 14:04:29 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:18669 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039228AbWKBOE2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Nov 2006 14:04:28 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kA2E4rDe018478;
	Thu, 2 Nov 2006 14:04:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kA2E4prK018477;
	Thu, 2 Nov 2006 14:04:51 GMT
Date:	Thu, 2 Nov 2006 14:04:51 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Randy Dunlap <rdunlap@xenotime.net>
Cc:	Wim Van Sebroeck <wim@iguana.be>,
	Thomas Koeller <thomas@koeller.dyndns.org>,
	Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20061102140450.GE16883@linux-mips.org>
References: <20061101184633.GA7056@infomag.infomag.iguana.be> <20061101221125.73505baa.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101221125.73505baa.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 01, 2006 at 10:11:25PM -0800, Randy Dunlap wrote:

> > 	wd_regs = ioremap_nocache(rr->start, rr->end + 1 - rr->start);
> > 	if (unlikely(!wd_regs))
> > 		return -ENOMEM;
> 
> There's no way to return the resources on failure?

MIPS drivers (and this one is specific to a particular MIPS SOC) are
generally a bit sloopy about checking of return values of ioremap because
ioremap is only doing some address arithmetic but no allocations that
actually could fail.  So for 64-bit kernels or addresses below 0x20000000
on a 32-bit system ioremap cannot fail.  In the same cases ioremap happens
to be a no-op because where nothing was allocated nothing needs to be
freed.

> > 			if (unlikely(__copy_from_user(&val, (const void __user *) arg,

Note to self, __copy_from_user and gang are generally assume to not
return an error so it might be a good idea to move that unlikely() into
the macro definitions.

  Ralf
