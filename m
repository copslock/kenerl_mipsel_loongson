Received:  by oss.sgi.com id <S553936AbRAPTii>;
	Tue, 16 Jan 2001 11:38:38 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:59353 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553933AbRAPTia>;
	Tue, 16 Jan 2001 11:38:30 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA25586;
	Tue, 16 Jan 2001 20:38:37 +0100 (MET)
Date:   Tue, 16 Jan 2001 20:38:37 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
In-Reply-To: <20010116171457.A884@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010116202627.5546W-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 16 Jan 2001, Ralf Baechle wrote:

> Don't use mem= on an ARC machine.  The ARC firmware provides a usable way
> to detect the installed amount of memory including memory used internally
> by the firmware.  If you use mem= on an ARC machine you'll simply make
> the kernel stomp over all this firmwar data with more or less random
> results.

 Ralf, please do not depreciate the tool.  You should not use "mem=" 
blindly on any kind of machine or bad things will happen.  Whenever you
use "mem=", you need to have at least a bare idea which memory areas are
usable and which are not.  You wouldn't like to put a process in
framebuffer memory, for example, would you?  When used carefully "mem=" 
may be a valuable tool for development and debugging.  It's flexible
enough to specify multiple memory ranges and you may use decimal, octal
and hexadecimal notation, as well as suffixes for kilo and mega (or kibi
and mebi, actually).  It may be used as a workaround for unsupported
memory configurations or broken memory areas.

 That written, one wouldn't normally use "mem=" for a production system,
of course.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
