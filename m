Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6AH5KA31554
	for linux-mips-outgoing; Tue, 10 Jul 2001 10:05:20 -0700
Received: from localhost.localdomain (client124091.atl.mediaone.net [24.31.124.91])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6AH5IV31551
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 10:05:18 -0700
Received: (from marck@localhost)
	by localhost.localdomain (8.11.2/8.11.2) id f6AH52X09215;
	Tue, 10 Jul 2001 13:05:02 -0400
X-Authentication-Warning: localhost.localdomain: marck set sender to marc_karasek@ivivity.com using -f
Subject: Re: MIPS Cross Compiler Tools
From: Marc Karasek <marc_karasek@ivivity.com>
To: H "." J "." Lu <hjl@lucon.org>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
In-Reply-To: <20010710094627.D19026@lucon.org>
References: <25369470B6F0D41194820002B328BDD27D22@ATLOPS> 
	<20010710094627.D19026@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 10 Jul 2001 13:05:01 -0400
Message-Id: <994784701.9191.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is for an embedded platform, with no harddrive.  So I will need to
use things like busybox, etc.  I just need the headers & libs.  So far I
have only been able to find glibc-2.2.2 from deb in an rpm format.
Could not get this to install in /usr/local/mips-linux/...  properly.  I
guess what I am really looking for is a tgz file of the libs/headers.
SO I can put it where I want it. Any packaged dist (RH, deb) would not
be usefull in this scenario.  At least that is my experience todate.... 

Thanks for the quick response..

On 10 Jul 2001 09:46:27 -0700, H . J . Lu wrote:
> On Tue, Jul 10, 2001 at 12:27:43PM -0400, Marc Karasek wrote:
> > I had a question about the cross compiler tools for MIPS, specifically
> > glibc.  I d/l the rpms from oss.sgi.com,  but they are only binutils, and
> > the compiler (C, C++).  
> > 
> > Are most people building glibc against these or are you building the tools
> > completely from scratch?  As glibc is needed to compile anything else other
> > than the kernel. 
> 
> My RedHat 7.1 release on oss.sgi.com has the complete cross toolchain:
> 
> 
> 
> H.J.
> -----
> My mini-port of RedHat 7.1 is at
> 
> ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/
> 
> you should be able to put a small RedHat 7.1 on the mips/mipsel box and
> compile the rest of RedHat 7.1 yourselves.
> 
> Here are something you should know:
> 
> 1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
> toolchain rpm. The binary rpms for the mips and mipsel cross compilers
> are included.
> 2. You have to find a way to put those rpms on your machine. I use
> network boot and NFS root to do it.
--
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
