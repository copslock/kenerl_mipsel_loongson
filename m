Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 14:01:05 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:63940 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022895AbXEVNBD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 May 2007 14:01:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4MD0hS7016817;
	Tue, 22 May 2007 14:00:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4MD0hYW016816;
	Tue, 22 May 2007 14:00:43 +0100
Date:	Tue, 22 May 2007 14:00:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org, Martin Michlmayr <tbm@cyrius.com>
Subject: Re: SGI O2 meth: missing sysfs device symlink
Message-ID: <20070522130043.GA3781@linux-mips.org>
References: <1178743456.15447.41.camel@scarafaggio> <20070516151939.GH19816@deprecation.cyrius.com> <20070516160313.GA3409@bongo.bofh.it> <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org> <20070517151636.GJ3586@deprecation.cyrius.com> <20070521154726.GE5943@linux-mips.org> <20070522110956.GB29118@linux-mips.org> <1179834093.7896.23.camel@scarafaggio> <1179835991.7896.32.camel@scarafaggio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1179835991.7896.32.camel@scarafaggio>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 22, 2007 at 02:13:11PM +0200, Giuseppe Sacco wrote:

> It seems the patch doesn't apply on 2.6.18, so I will recompile
> 2.6.22-rc2, but I do not know if it works on my SGI. I never tried it.

Remove the "#include <linux/sched.h>" line drivers/net/meth.c, then apply
the patch.  Anyway, here's also a binary tarball:

ftp://ftp.linux-mips.org/pub/linux/mips/people/ralf/sgi-ip32/linux-2.6.18.8-gb29bece0-dirty.tar.bz2

  Ralf
