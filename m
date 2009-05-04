Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2009 11:05:50 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:41674 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022035AbZEDKFn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2009 11:05:43 +0100
Received: (qmail 26180 invoked by uid 1000); 4 May 2009 12:05:42 +0200
Date:	Mon, 4 May 2009 12:05:42 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Anders Kaseorg <andersk@mit.edu>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Lots of unexpected non-allocatable section warnings
Message-ID: <20090504100542.GA26150@roarinelk.homelinux.net>
References: <20090503110517.6d09bca2@hyperion.delvare> <20090503103010.GA27978@uranus.ravnborg.org> <20090503124848.276b437f@hyperion.delvare> <20090503180332.GA31820@uranus.ravnborg.org> <20090503202939.GA1237@uranus.ravnborg.org> <20090504082816.GA25378@roarinelk.homelinux.net> <20090504094928.GA6157@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090504094928.GA6157@uranus.ravnborg.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Sam,

On Mon, May 04, 2009 at 11:49:28AM +0200, Sam Ravnborg wrote:
> On Mon, May 04, 2009 at 10:28:16AM +0200, Manuel Lauss wrote:
> > Hi Sam,
> > 
> > On Sun, May 03, 2009 at 10:29:39PM +0200, Sam Ravnborg wrote:
> > > This is due to the SUSE specific section as you expected.
> > > We ignore sections named ".comment" but not ".comment" sections
> > > with something appended to the name.
> > 
> > 
> > On a related note, I see tons of the following warnings cross-building for
> > MIPS:
> > 
> > WARNING: init/mounts.o (.mdebug.abi32): unexpected non-allocatable section.
> > Did you forget to use "ax"/"aw" in a .S file?                              
> > Note that for example <linux/init.h> contains                              
> > section definitions for use in .S files.                                   
> > 
> > WARNING: init/mounts.o (.pdr): unexpected non-allocatable section.
> > Did you forget to use "ax"/"aw" in a .S file?                     
> > Note that for example <linux/init.h> contains                     
> > section definitions for use in .S files. 
> > 
> > 
> > I added ".pdr" and ".mdebug*" to the whitelist;  the resulting kernels still
> > work.  (gcc-4.3.3, binutils-2.19.1)
> 
> Hi Manuel - thanks for reporting!
> 
> Is your mips target little or big endian?
> If it is a big-endian target (which I expect) then the right fix
> is the patch posted by Anders.

No, it's little-endian.  Cross-compiling on x86_64 to mipsel.

 
> In other words - what happens if you back out your change
> and apply the appended patch.

no change.

(Did you attach the wrong patch?  It does indentation fixes and adds a few
more entries)

Thanks!
	Manuel Lauss
