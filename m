Received:  by oss.sgi.com id <S553675AbRAKXbe>;
	Thu, 11 Jan 2001 15:31:34 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:49649 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553695AbRAKXbZ>; Thu, 11 Jan 2001 15:31:25 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S867057AbRAKXUF>; Thu, 11 Jan 2001 21:20:05 -0200
Date:	Thu, 11 Jan 2001 21:20:05 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Ian Chilton <ian@ichilton.co.uk>
Cc:	linux-mips@oss.sgi.com
Subject: Re: Current CVS Kernel Broken on MIPS (010111 - 2.4.0)
Message-ID: <20010111212005.C894@bacchus.dhis.org>
References: <20010111225700.A2473@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010111225700.A2473@woody.ichilton.co.uk>; from ian@ichilton.co.uk on Thu, Jan 11, 2001 at 10:57:01PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 11, 2001 at 10:57:01PM +0000, Ian Chilton wrote:

> > Such a pile of numbers is pretty useless for debuggin unless accompanied
> > with the disassembler listing of the crashing code, System.map or even
> > better the kernel binary itself ...
> 
> Sorry, I forgot..:
> 
> http://files.ichilton.co.uk/linux-010111-IP22-4400.tar.gz
> 
> 
> It's all in there, ELF + ECOFF + System.map

It's a crash during the very early initialization of the kernel, that is
before trap_init() gets called.  __alloc_bootmem_core calls memset with
bogus addresses and that again crashes.  Not very much else I can read
from this crash and not very much I can do without an Indy ...

  Ralf
