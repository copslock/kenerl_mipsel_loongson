Received:  by oss.sgi.com id <S553921AbRA1CzZ>;
	Sat, 27 Jan 2001 18:55:25 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:52998 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S553939AbRA1CzJ>;
	Sat, 27 Jan 2001 18:55:09 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA01531
	for <linux-mips@oss.sgi.com>; Sat, 27 Jan 2001 18:55:08 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870773AbRA0TBG>; Sat, 27 Jan 2001 11:01:06 -0800
Date: 	Sat, 27 Jan 2001 11:01:06 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Justin Carlson <carlson@sibyte.com>, linux-mips@oss.sgi.com
Subject: Re: GDB 5 for mips-linux/Shared library loading with new binutils/glibc
Message-ID: <20010127110106.F867@bacchus.dhis.org>
References: <0101261750492Y.00834@plugh.sibyte.com> <Pine.GSO.3.96.1010127084850.29150E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010127084850.29150E-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Sat, Jan 27, 2001 at 09:01:47AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Jan 27, 2001 at 09:01:47AM +0100, Maciej W. Rozycki wrote:

>  I've contributed all patches I've written myself.  Unfortunately, most of
> the code needed for gdb 5.0 to run on MIPS was taken from the 4.x CVS at
> oss.sgi.com.  As such it is required all authors of patches have to have
> their copyright assigned to FSF before committing them to the gdb CVS.
> 
>  I've asked people to resolve ownership of the code here some time ago,
> but it seems nobody is really interested in getting this code into
> official gdb, sigh... 

The only people who have contributed amounts of code large enough for the
FSF to requires an assignment are David Miller (davem@redhat.com) and
myself.  I've already signed an assignment with the FSF and I'm also sure
David has.  I btw. cannot remember having seen any mail from you regarding
copyright assignments of GDB.

> > However, ld.so seems to know nothing about relocating shared library with a
> > non-zero shared library base address, which causes dynamically linked
> > stuff to crash spectacularly.  
> 
>  Does it?  Please provide more details.  All of my system (linux 2.4.0,
> glibc 2.2.1) is dynamically linked and it works fine.

I don't know what you look at - ld.so fails to handle libraries which are
not linked to 0x5fffe000 ...

> > binutils we're using is from CVS as of about Dec 17th.  Glibc is also a
> > snapshot from about the same time.
> 
>  Glibc should be fine as is although you might consider getting the 2.2.1
> release.  You may try to check if patches from my binutils package (also
> available at the mentioned site) solve certain or all of your problems. 
> The patches have been proposed for an inclusion in the upcoming binutils
> 2.11 release -- I hope they will finally get there.

Ulf?

  Ralf
