Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 14:36:03 +0200 (CEST)
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41991 "EHLO
	www.linux.org.uk") by linux-mips.org with ESMTP id <S1123396AbSJDMgC>;
	Fri, 4 Oct 2002 14:36:02 +0200
Received: from dsl-212-23-14-246.zen.co.uk ([212.23.14.246] helo=gallifrey.home.treblig.org)
	by www.linux.org.uk with esmtp (Exim 3.33 #5)
	id 17xRgR-0005VB-00; Fri, 04 Oct 2002 13:35:55 +0100
Received: from dg by gallifrey.home.treblig.org with local (Exim 3.36 #1 (Debian))
	id 17xRgQ-0007CR-00; Fri, 04 Oct 2002 13:35:54 +0100
Date: Fri, 4 Oct 2002 13:35:54 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
Message-ID: <20021004123554.GD710@gallifrey>
References: <3D9D484B.4C149BD8@mips.com> <200210041153.MAA12052@mudchute.algor.co.uk> <3D9D855B.12128FA2@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9D855B.12128FA2@mips.com>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 13:34:03 up 2 days, 15:01,  1 user,  load average: 0.00, 0.02, 0.14
Return-Path: <dg@treblig.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilbertd@treblig.org
Precedence: bulk
X-list: linux-mips

* Carsten Langgaard (carstenl@mips.com) wrote:

> > For a Linux user program, at least, memory pages are "memory-like":
> > reads are guaranteed to be side-effect free, so any outlying
> > prefetches are harmless.  It's hard to see any circumstance where an
> > accessible cacheable location would lead to bad side-effects on read.
> 
> What about an UART RX register, we might loose a character ?
> You can also configure you system, so you get a external interrupt from you
> system controller in case of a bus error, there is no way the CPU can
> relate this interrupt to the prefetching.

Well those woudn't be cacheable (hmm what happens to a prefetch on none
cached areas?) and also you could argue that you shouldn't be proding
UARTs from user space (although you could equally argue that it is
perfectly valid - but if you were doing it you probably wouldn't
be attacking them with a memcpy).

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
