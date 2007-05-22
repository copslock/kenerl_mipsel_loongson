Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 13:18:53 +0100 (BST)
Received: from host51-222-dynamic.2-87-r.retail.telecomitalia.it ([87.2.222.51]:48135
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022891AbXEVMSs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 May 2007 13:18:48 +0100
Received: from [80.76.68.90] (helo=pc01.bm.loc)
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1HqTJt-0006DL-12; Tue, 22 May 2007 14:18:30 +0200
Subject: Re: SGI O2 meth: missing sysfs device symlink
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <1179834093.7896.23.camel@scarafaggio>
References: <1178743456.15447.41.camel@scarafaggio>
	 <20070516151939.GH19816@deprecation.cyrius.com>
	 <20070516160313.GA3409@bongo.bofh.it>
	 <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>
	 <20070517151636.GJ3586@deprecation.cyrius.com>
	 <20070521154726.GE5943@linux-mips.org>
	 <20070522110956.GB29118@linux-mips.org>
	 <1179834093.7896.23.camel@scarafaggio>
Content-Type: text/plain
Date:	Tue, 22 May 2007 14:13:11 +0200
Message-Id: <1179835991.7896.32.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mar, 22/05/2007 alle 13.41 +0200, Giuseppe Sacco ha scritto:
> Il giorno mar, 22/05/2007 alle 12.09 +0100, Ralf Baechle ha scritto:
> > On Mon, May 21, 2007 at 04:47:26PM +0100, Ralf Baechle wrote:
> > 
> > Below patch is meant to cure the problem.  It's against HEAD but should
> > apply to somewhat older problems as well.
> > 
> > I appreciate testing asap so I can try to still push this upstream
> > for 2.6.22.
> [...]
> 
> I may test it against 2.6.18, the standard debian kernel for stable; but
> I will be on the console only in two days :-(

It seems the patch doesn't apply on 2.6.18, so I will recompile
2.6.22-rc2, but I do not know if it works on my SGI. I never tried it.

The error is:

giuseppe@sgi:/usr/local/src/linux-source-2.6.18$ patch -p1 --dry-run </tmp/sgi.patch 
patching file arch/mips/sgi-ip32/Makefile
Hunk #1 succeeded at 3 with fuzz 2.
patching file arch/mips/sgi-ip32/ip32-platform.c
patching file drivers/net/meth.c
Hunk #1 FAILED at 8.
Hunk #2 succeeded at 36 with fuzz 2 (offset 2 lines).
Hunk #3 succeeded at 53 (offset 2 lines).
Hunk #4 succeeded at 785 (offset 3 lines).
Hunk #5 succeeded at 809 with fuzz 2 (offset 3 lines).
Hunk #6 succeeded at 822 (offset 3 lines).
1 out of 6 hunks FAILED -- saving rejects to file drivers/net/meth.c.rej
