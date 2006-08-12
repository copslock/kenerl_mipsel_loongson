Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 23:41:07 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:20702 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20037879AbWHLWlG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2006 23:41:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7CMf4RR009435;
	Sat, 12 Aug 2006 23:41:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7CMf0m0009434;
	Sat, 12 Aug 2006 23:41:00 +0100
Date:	Sat, 12 Aug 2006 23:41:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Koeller <thomas@koeller.dyndns.org>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, wim@iguana.be,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060812224100.GA9043@linux-mips.org>
References: <200608102319.13679.thomas@koeller.dyndns.org> <1155326835.24077.116.camel@localhost.localdomain> <200608121806.02844.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608121806.02844.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Aug 12, 2006 at 06:06:02PM +0200, Thomas Koeller wrote:

> > > +	while (1) continue;
> >
> > cpu_relax();
> 
> I tried to find out about the purpose of cpu_relax(). On MIPS, at least,
> it maps to barrier(). I do not quite understand why I would need a
> barrier() in this place. Would you, or someone else, care to
> enlighten me?

Busy wait loops are meant to be filled with cpu_relax() in Linux.  On
processors like the Pentium 4 this expands into something that keeps
the CPU from consuming excessive amounts of energy for just twiddling
thumbs and probably also CPU dependant.  On MIPS cpu_relax() so far is
meaningless and therfore just defined as barrier().

  Ralf
