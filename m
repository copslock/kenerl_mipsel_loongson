Received:  by oss.sgi.com id <S553914AbRAPTP6>;
	Tue, 16 Jan 2001 11:15:58 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:26102 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553911AbRAPTPu>; Tue, 16 Jan 2001 11:15:50 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870766AbRAPTO5>; Tue, 16 Jan 2001 17:14:57 -0200
Date:	Tue, 16 Jan 2001 17:14:57 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Ian Chilton <ian@ichilton.co.uk>
Cc:	macro@ds2.pg.gda.pl, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116171457.A884@bacchus.dhis.org>
References: <20010116165534.A26392@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010116165534.A26392@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Tue, Jan 16, 2001 at 04:55:34PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 04:55:34PM +0000, Ian Chilton wrote:

> Hello,
> 
> > mem=0x07800000@0x08800000
> 
> What will I use with 96MB RAM please ?
> 
> 
> Is someone going to fix it so this param is not needed?

Don't use mem= on an ARC machine.  The ARC firmware provides a usable way
to detect the installed amount of memory including memory used internally
by the firmware.  If you use mem= on an ARC machine you'll simply make
the kernel stomp over all this firmwar data with more or less random
results.

  Ralf
