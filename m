Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6AH9wm31748
	for linux-mips-outgoing; Tue, 10 Jul 2001 10:09:58 -0700
Received: from localhost.localdomain (client124091.atl.mediaone.net [24.31.124.91])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6AH9uV31744
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 10:09:57 -0700
Received: (from marck@localhost)
	by localhost.localdomain (8.11.2/8.11.2) id f6AH9gb09226;
	Tue, 10 Jul 2001 13:09:42 -0400
X-Authentication-Warning: localhost.localdomain: marck set sender to marc_karasek@ivivity.com using -f
Subject: Re: MIPS Cross Compiler Tools
From: Marc Karasek <marc_karasek@ivivity.com>
To: ppopov@pacbell.net
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
In-Reply-To: <3B4B2FA6.4080508@pacbell.net>
References: <25369470B6F0D41194820002B328BDD27D22@ATLOPS> 
	<3B4B2FA6.4080508@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 10 Jul 2001 13:09:42 -0400
Message-Id: <994784982.9191.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Will these be in the form of rpms or tgz files??  In the case of rpm do
you know if they would be package similar to the ones on oss.sgi.com?
ie Setup for a crossdev enviroment.  I just really need the cross tools
as the dev is on an embedded system, with no harddrive.  The userland
stuff is pretty worthless to me.  I will be using busybox, tinylogin,
etc. for the standard bin utilities.  Having a few megabytes to store
everything in makes you very sensitive to size.... :-)

Thanks for the quick response...    

On 10 Jul 2001 09:39:02 -0700, Pete Popov wrote:
> Marc Karasek wrote:
> 
> > I had a question about the cross compiler tools for MIPS, specifically
> > glibc.  I d/l the rpms from oss.sgi.com,  but they are only binutils, and
> > the compiler (C, C++).  
> > 
> > Are most people building glibc against these or are you building the tools
> > completely from scratch?  As glibc is needed to compile anything else other
> > than the kernel. 
> 
> Friday or Monday MontaVista should have the HHL2.0 Journeyman mips 
> release on the ftp site which will include the userland apps, cross AND 
> native tools, etc.  The tools and glibc are very up to date. I would 
> suggest checking Monday for the release and using that instead of 
> building your own.
> 
> Pete
--
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
