Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 09:37:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:9703 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021513AbXEWIh4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 May 2007 09:37:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4N8bhJ4004962;
	Wed, 23 May 2007 09:37:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4N8bgBb004961;
	Wed, 23 May 2007 09:37:42 +0100
Date:	Wed, 23 May 2007 09:37:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Subject: Re: SGI O2 meth: missing sysfs device symlink
Message-ID: <20070523083742.GA4495@linux-mips.org>
References: <1178743456.15447.41.camel@scarafaggio> <20070516151939.GH19816@deprecation.cyrius.com> <20070516160313.GA3409@bongo.bofh.it> <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org> <20070517151636.GJ3586@deprecation.cyrius.com> <20070521154726.GE5943@linux-mips.org> <20070522110956.GB29118@linux-mips.org> <4653BA42.3060104@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4653BA42.3060104@gentoo.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 22, 2007 at 11:51:30PM -0400, Kumba wrote:

> Didn't test on 2.6.22 (yet), but 2.6.21.1 works:

That's the only one I care about for purposes of upstream patch submission
anyway.

> Btw, If we wanted to protect meth from the speculative execution issues of 
> the R10000 processor, what's the right way for that?  I believe IP28 used a 
> special type of buffer for protecting Seeq from the DMA wonkiness that 
> occurs, but I got the indication that Meth would need a different approach.

I don't see why the standard approach would fail for meth.

  Ralf
