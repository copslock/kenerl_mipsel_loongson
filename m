Received:  by oss.sgi.com id <S553946AbRA1CzZ>;
	Sat, 27 Jan 2001 18:55:25 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:53254 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S553921AbRA1CzJ>;
	Sat, 27 Jan 2001 18:55:09 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA07036
	for <linux-mips@oss.sgi.com>; Sat, 27 Jan 2001 18:55:09 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870775AbRA0TLq>; Sat, 27 Jan 2001 11:11:46 -0800
Date: 	Sat, 27 Jan 2001 11:11:46 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Justin Carlson <carlson@sibyte.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: GDB 5 for mips-linux/Shared library loading with new binutils/glibc
Message-ID: <20010127111146.G867@bacchus.dhis.org>
References: <0101261750492Y.00834@plugh.sibyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0101261750492Y.00834@plugh.sibyte.com>; from carlson@sibyte.com on Fri, Jan 26, 2001 at 05:40:07PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 05:40:07PM -0800, Justin Carlson wrote:

> Also, I've run into a problem with ld.so from glibc-2.2 on mips32-linux.
> After some hunting, I found that the templates in elf32bsmip.sh for gnu
> ld have recently changed to support SHLIB_TEXT_START_ADDR as a (non-zero)
> base address for shared library loading.  SHLIB_TEXT_START_ADDR defaults
> to 0x5ffe0000 in the current sources.

For obscure reasons which probably spell IRIX 5.x ELF compatibility ELF
shared objects except the dynamic linker itself are linked to this base
address.

> I'm curious if anyone knows the rationale for these changes.  Best conjecture
> I've heard is that it allows ld.so to not have to relocate itself, as it will
> load by default to the high address.  

By default ld.so get loaded to 0xfb60000.  Again this is an obscure IRIXism.

> However, ld.so seems to know nothing about relocating shared library with a
> non-zero shared library base address, which causes dynamically linked stuff
> to crash spectacularly.  
> 
> I think fixing ld.so won't be too difficult, but I'm really wanting to
> find out why these changes were made.  And whether I'm reinventing some
> wheels by fixing ld.so to cope with the new binutils stuff.

Glibc 2.0 as of '96 already does this just as glibc 2.2 is supposed to.
You may look at the source in the srpm package of glibc 2.1.95 on oss which
definately handles this right.

  Ralf
