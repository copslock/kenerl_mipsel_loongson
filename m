Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f47I4EO16821
	for linux-mips-outgoing; Mon, 7 May 2001 11:04:14 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f47I47F16790
	for <linux-mips@oss.sgi.com>; Mon, 7 May 2001 11:04:09 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f45Hrjd01646;
	Sat, 5 May 2001 14:53:45 -0300
Date: Sat, 5 May 2001 14:53:45 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ian Thompson <iant@palmchip.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Debug format problem with -ggdb flag
Message-ID: <20010505145344.B1252@bacchus.dhis.org>
References: <3AF098B7.F111B230@palmchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF098B7.F111B230@palmchip.com>; from iant@palmchip.com on Wed, May 02, 2001 at 04:31:03PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 02, 2001 at 04:31:03PM -0700, Ian Thompson wrote:

> I'm running into problems with the debug information that is generated
> by the kernel compilation process.  Basically, I'm seeing that 
> multiple function symbols have the same begin address in the .mdebug
> section.  For example -- the init_arch and r3081_wait functions in my
> build have differnet addresses as far as compilation is concerned, and
> code executes correctly.  When I look into the .mdebug section, I see 
> that the begin, end, stab, and external records are all correct for 
> the r3081_wait function, but that the begin record for the init_arch
> function is the same as that for the the r3081_wait function!  This in
> turn seems to be causing the stab and external records to be incorrect,
> causing symbolic problems in my debugger.  
> 
> I've traced the problem down, and it seems to be a side-effect of 
> partial linking.  When the linker links multiple .o files into another
> .o file (which is later used as input to another ld command), the 
> debug records inside the .mdebug section are getting corrupted.  Has
> anyone run into this problem before?  Any suggestions of other flags
> I can pass into the partial link that may help?  I'm using the mipsel
> rpm of binutils 2.9.5-3.  Or, are there any alternatives to 
> partial linking that don't involve a lot of makefile manipulation?
> 
> I've tried using the -gcoff option to remove the stab records, but that
> option does not allow the 2.4 kernel to compile under egcs 2.91.66.

So then is a binutils and not a compiler problem.  What binutils are you
using?  Binutils 2.8.1 which I'm still recommending (mostly to avoid
sending people into a maze of version dependencies) is getting dated and
the bug may well have been fixed in the meantime.

  Ralf
