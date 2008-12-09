Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2008 17:39:48 +0000 (GMT)
Received: from crux.i-cable.com ([203.83.115.104]:50056 "HELO crux.i-cable.com")
	by ftp.linux-mips.org with SMTP id S24108197AbYLIRjm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Dec 2008 17:39:42 +0000
Received: (qmail 23537 invoked by uid 107); 9 Dec 2008 17:39:30 -0000
Received: from 203.83.114.122 by crux (envelope-from <robert.zhangle@gmail.com>, uid 104) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7716. spamassassin: 2.63.  
 Clear:RC:1(203.83.114.122):SA:0(2.6/5.0):. 
 Processed in 5.524709 secs); 09 Dec 2008 17:39:30 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 9 Dec 2008 17:39:25 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id mB9HdOJT027713;
	Wed, 10 Dec 2008 01:39:24 +0800 (CST)
Date:	Wed, 10 Dec 2008 01:39:08 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: xorg-server-1.5.2 doesn't work because of missing sysfs pci
	resource files
Message-ID: <20081209173907.GB2741@adriano.hkcable.com.hk>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20081205154339.GA14327@adriano.hkcable.com.hk> <20081206102030.GA9410@linux-mips.org> <20081206164706.GB14327@adriano.hkcable.com.hk> <20081209172245.GA2741@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081209172245.GA2741@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 01:22 Wed 10 Dec     , Zhang Le wrote:
> On 00:47 Sun 07 Dec     , Zhang Le wrote:
> > On 10:20 Sat 06 Dec     , Ralf Baechle wrote:
> > > On Fri, Dec 05, 2008 at 11:43:42PM +0800, Zhang Le wrote:
> > > > Then I tried to read kernel code. I found it seems that for mips linux to have
> > > > this file, HAVE_PCI_MMAP must be defined. However, it is currently not defined.
> > > > 
> > > > Since I am not familiar with PCI, yet.
> > > > So could someone please shed some light on this?
> > > > Why HAVE_PCI_MMAP is not defined?
> > > 
> > > Here is a quick'n'dirty solution which I've not tested beyond just
> > > compiling.  It should work but performance will be bad.  Either way, I'm
> > > interested in a test report with X.
> 
> Hi, Ralf,
> 
> I have build a new kernel with this patch.
> Now I have the resource{0,1} file with permission 600.
> However, X is not working yet, since there is an undefined reference in sis's
> X driver.

It is working now! Just forget to load "vbe" module.
Thanks!

Zhang, Le
