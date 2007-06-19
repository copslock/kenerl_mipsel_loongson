Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 13:03:32 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:24330 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023491AbXFSMDa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Jun 2007 13:03:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7A578E1D12;
	Tue, 19 Jun 2007 14:03:20 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pbTvWT-xfRTt; Tue, 19 Jun 2007 14:03:20 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1273BE1CD1;
	Tue, 19 Jun 2007 14:03:20 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l5JC3REX019059;
	Tue, 19 Jun 2007 14:03:28 +0200
Date:	Tue, 19 Jun 2007 13:03:24 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	sknauert@wesleyan.edu, linux-mips@linux-mips.org
Subject: Re: Legacy PCI IO for PCI graphics on SGI O2...Anybody?
In-Reply-To: <20070619.121030.130240189.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.64N.0706191246060.15474@blysk.ds.pg.gda.pl>
References: <cda58cb80706120255w5ef28123tc27a8152d18e3039@mail.gmail.com>
 <39830.129.133.92.31.1181651585.squirrel@webmail.wesleyan.edu>
 <54672.129.133.92.31.1182184357.squirrel@webmail.wesleyan.edu>
 <20070619.121030.130240189.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3466/Tue Jun 19 08:21:58 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 19 Jun 2007, Atsushi Nemoto wrote:

> I suppose HAVE_PCI_LEGACY provides us a standard way to access 8/16/32
> bit registers in PCI I/O space, right?
> 
> If so, it would be great; When I tried to read a 16-bit register in
> PCI I/O space from userland, I had to find a physical address of the
> PCI I/O region and mmap it via /dev/mem, since /dev/port only supports
> 8bit access.

 That should be taken care of in glibc (or your libc of choice) -- with 
ioperm() or iopl() and then in{b,w,l}() and out{b,w,l}() as appropriate.  
Either of the two formers are used to mmap() the right area of /dev/mem 
and then the latters are used access the area with the desired width (and 
stride, if applicable -- portable code should not assume subsequent I/O 
port addresses are adjacent in the MMIO space).  It has worked like this 
for other platforms for at least ten years now.

 Of course the function doing mmap() still has to know the CPU physical 
address of the I/O space from somewhere.  For quite some time my feeling 
has been it should come from /proc/iomem, where we actually fail to 
register the I/O space, but these days sysfs is probably better (though I 
plan to have a look at /proc/iomem for the use of human beings anyway).  

 That still does not solve the problem of multiple independent I/O spaces, 
but I gather such configurations are very rare indeed.

  Maciej
