Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 21:07:54 +0100 (WEST)
Received: from pfepb.post.tele.dk ([195.41.46.236]:51789 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022745AbZFDUHr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 21:07:47 +0100
Received: from ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepb.post.tele.dk (Postfix) with ESMTP id D268CF84070;
	Thu,  4 Jun 2009 22:07:39 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id D430B580D0; Thu,  4 Jun 2009 22:09:53 +0200 (CEST)
Date:	Thu, 4 Jun 2009 22:09:53 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Jaswinder Singh Rajput <jaswinder@kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Michael Abbott <michael@araneidae.co.uk>
Subject: Re: [PATCH 4/6] headers_check fix: mips, ioctl.h
Message-ID: <20090604200953.GA13892@uranus.ravnborg.org>
References: <1244118232.5172.26.camel@ht.satnam> <1244118476.5172.29.camel@ht.satnam> <1244118599.5172.31.camel@ht.satnam> <1244118714.5172.33.camel@ht.satnam> <1244118949.5172.37.camel@ht.satnam> <20090604124631.GB19459@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090604124631.GB19459@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 04, 2009 at 01:46:31PM +0100, Ralf Baechle wrote:
> On Thu, Jun 04, 2009 at 06:05:49PM +0530, Jaswinder Singh Rajput wrote:
> 
> > Make ioctl.h compatible with asm-generic/ioctl.h and userspace
> > 
> > fix the following 'make headers_check' warning:
> > 
> >   usr/include/asm-mips/ioctl.h:64: extern's make no sense in userspace
> > 
> > Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> 
> Thanks, applied.

Hi Ralf.

Any specific reason why mips does not use include/asm-generic/ioctl.h?
Had mips done so this would not have been an issue.

	Sam
