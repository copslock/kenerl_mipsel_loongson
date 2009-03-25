Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 15:42:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:35483 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28573951AbZCYPm1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2009 15:42:27 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2PFgPEt004716;
	Wed, 25 Mar 2009 16:42:25 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2PFgOmv004714;
	Wed, 25 Mar 2009 16:42:24 +0100
Date:	Wed, 25 Mar 2009 16:42:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alan Wu <alan.wu@mstarsemi.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: VPE loader support on 34K
Message-ID: <20090325154224.GB32398@linux-mips.org>
References: <B34CE01D80AD4D309E259934BA1361AA@mstarsemi.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B34CE01D80AD4D309E259934BA1361AA@mstarsemi.com.tw>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 25, 2009 at 10:37:20PM +0800, Alan Wu wrote:

> I'm porting 2.6.26 Linux on the platform of MIPS 34K. Currently, the uni-processor 
> kernel model(1 VPE) and SMP model (2 VPE) are up and work perfectly.
> 
> Now, I need to port the AP/SP model on a normal Linux uniprocessor kernel model. 
> I'd like to load an application program (ELF ?) into kernel space where this 
> application will run on a Secondary VPE undisturbed by the Linux kernel.
> 
> After I enabled the MIPS_VPE_LOADER [=y] in .config , the kernel is up without
> any error/warning message.
> 
> Please help :
> 
> 1. How to load the application into VPE1 from VPE0 ? (cat XYZapp >/dev/vpe1 ?)
> 2. Is there any sample "Hello World" application for this ? 
> 3. Any specific tool chain needed ?

I assume you're a MTI customer?  If so I suggest you talk to customer
support.  There are docs, SDE-based toolchain and example code showing
how to use this.  If you understand the technical details it will not
be too difficult to figure out your own solution using a standard
Linux/MIPS toolchains but of course in that case you can't use any of
the userspace libraries for building an AP/SP program.

  Ralf
