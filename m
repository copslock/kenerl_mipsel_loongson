Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6AHCNp31874
	for linux-mips-outgoing; Tue, 10 Jul 2001 10:12:23 -0700
Received: from localhost.localdomain (client124091.atl.mediaone.net [24.31.124.91])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6AHCLV31869
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 10:12:22 -0700
Received: (from marck@localhost)
	by localhost.localdomain (8.11.2/8.11.2) id f6AHBrZ09236;
	Tue, 10 Jul 2001 13:11:53 -0400
X-Authentication-Warning: localhost.localdomain: marck set sender to marc_karasek@ivivity.com using -f
Subject: Re: MIPS Cross Compiler Tools
From: Marc Karasek <marc_karasek@ivivity.com>
To: Steve Langasek <vorlon@netexpress.net>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
In-Reply-To: 
	<Pine.LNX.4.30.0107101132510.25158-100000@tennyson.netexpress.net>
References: 
	<Pine.LNX.4.30.0107101132510.25158-100000@tennyson.netexpress.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 10 Jul 2001 13:11:53 -0400
Message-Id: <994785113.9191.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I really need the libs to cross-compile some other apps.  The target is
an embedded system, so I need to crosscompile things like busybox,
tinylogin, etc.  (It will NOT have a harddrive) I have done this before
with ARM and it is pretty easy once you get the tools in place.
Sometimes that is the hardest part... 
  

On 10 Jul 2001 11:35:20 -0500, Steve Langasek wrote:
> Hi Marc,
> 
> On Tue, 10 Jul 2001, Marc Karasek wrote:
> 
> > I had a question about the cross compiler tools for MIPS, specifically
> > glibc.  I d/l the rpms from oss.sgi.com,  but they are only binutils, and
> > the compiler (C, C++).
> 
> > Are most people building glibc against these or are you building the tools
> > completely from scratch?  As glibc is needed to compile anything else other
> > than the kernel.
> 
> You don't need a special 'cross-compiler' glibc in order to set up a
> cross-build environment for MIPS; simply grab a glibc package that's
> precompiled for MIPS and install it into your cross-build root directory.
> 
> I don't know who (if anyone) would have rpms or a recent mips glibc; I use
> Debian, where I have the packages available as part of the distro.
> 
> Regards,
> Steve Langasek
> postmodern programmer
--
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
