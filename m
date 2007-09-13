Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 16:51:16 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:1231 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022332AbXIMPvN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 16:51:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8DFoxh0008853;
	Thu, 13 Sep 2007 16:50:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8DFoxWo008852;
	Thu, 13 Sep 2007 16:50:59 +0100
Date:	Thu, 13 Sep 2007 16:50:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: IP22 64bit kernel
Message-ID: <20070913155059.GA8790@linux-mips.org>
References: <20070911213048.GA20579@alpha.franken.de> <46E8E134.8000004@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46E8E134.8000004@gentoo.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 13, 2007 at 03:05:24AM -0400, Kumba wrote:

> >Enabling this for (CONFIG_SGI_IP22 && CONFIG_64BIT) fixes the boot problem.
> >It's not big deal to add this, but I'm wondering why we not just always
> >use this macro ? What platforms do it break with it ?
> 
> Hmm, curious, the CONFIG_ARC64 macro?  Indys and O2s use 32bit versions of 
> the ARCS Prom, whereas Octane, Origin, and IP28 systems (and others) use 
> 64bit.  I suspect CONFIG_ARC64 is geared for these, but if it works on 
> Indy's too, that's curious.

The problem isn't limited to ARC firmware; basically any non-R8000 64-bit
system can be affected.  A kernel may be using either addresses in XKPHYS
or in CKSEG0 and the segment for which the kernel is linked is not
necessarily the same that the firmware will load it to.

  Ralf
