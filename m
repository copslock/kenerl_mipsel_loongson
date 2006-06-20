Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 16:29:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46033 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133789AbWFTP31 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 16:29:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5KFTRtF019345;
	Tue, 20 Jun 2006 16:29:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5KFTQg8019344;
	Tue, 20 Jun 2006 16:29:26 +0100
Date:	Tue, 20 Jun 2006 16:29:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ivan Korzakow <ivan.korzakow@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Merge window ...
Message-ID: <20060620152926.GA19154@linux-mips.org>
References: <20060619103653.GA4257@linux-mips.org> <a59861030606200814j218ce04br44abef138c533137@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59861030606200814j218ce04br44abef138c533137@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 20, 2006 at 05:14:02PM +0200, Ivan Korzakow wrote:

> Does that mean that MIPS, eventually, is doing like others arch for
> releasing ? If so does that mean that we can get a MIPS kernel from
> Linus tree without pulling from the (huge) mips repo ?

For some systems that is working since quite a while already.  For some
of the other platforms (Alchemy, Sibyte to name the biggest offenders)
kernel.org won't have a chance of working until somebody rewrites the
bloddy drivers for those things into something that actually can be
merged.

  Ralf
