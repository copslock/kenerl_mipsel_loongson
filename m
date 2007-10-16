Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 20:00:47 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34222 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037601AbXJPTAp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 20:00:45 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9GJ0ja3030664;
	Tue, 16 Oct 2007 20:00:45 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9GJ0iJg030663;
	Tue, 16 Oct 2007 20:00:44 +0100
Date:	Tue, 16 Oct 2007 20:00:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dhaval Giani <dhaval@linux.vnet.ibm.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: Build breakage if !SYSFS
Message-ID: <20071016190044.GA24696@linux-mips.org>
References: <20071016130231.GA10778@linux-mips.org> <20071016174016.GC5693@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071016174016.GC5693@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 16, 2007 at 11:10:16PM +0530, Dhaval Giani wrote:

> On Tue, Oct 16, 2007 at 02:02:31PM +0100, Ralf Baechle wrote:
> > Changeset 5cb350baf580017da38199625b7365b1763d7180 causes build breakage
> > if sysfs support is disabled:
> > 
> > kernel/built-in.o: In function `uids_kobject_init':
> > (.init.text+0x1488): undefined reference to `kernel_subsys'
> > kernel/built-in.o: In function `uids_kobject_init':
> > (.init.text+0x1490): undefined reference to `kernel_subsys'
> > kernel/built-in.o: In function `uids_kobject_init':
> > (.init.text+0x1480): undefined reference to `kernel_subsys'
> > kernel/built-in.o: In function `uids_kobject_init':
> > (.init.text+0x1494): undefined reference to `kernel_subsys'
> > 
> > This breaks for example mipssim_defconfig.
> > 
> >   Ralf
> 
> Hi Ralf,
> 
> Can you try this and confirm if it works?

Yes, this solves the issue.

Thanks,

  Ralf
