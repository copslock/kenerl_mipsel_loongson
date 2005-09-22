Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2005 23:31:10 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:54151 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133368AbVIVWay (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2005 23:30:54 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1EIZae-0004dq-9d; Thu, 22 Sep 2005 18:30:52 -0400
Date:	Thu, 22 Sep 2005 18:30:52 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS64 NPTL Status
Message-ID: <20050922223052.GA17827@nevyn.them.org>
References: <43323D35.9030905@jg555.com> <20050922213020.GA15905@nevyn.them.org> <43333001.3080703@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43333001.3080703@jg555.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 22, 2005 at 03:28:17PM -0700, Jim Gifford wrote:
> Daniel,
>    He I still keeping getting this error with the currently 9192005 
> snapshot of glibc.
> 
> In file included from ../sysdeps/mips/libc-tls.c:20:
> ../sysdeps/generic/libc-tls.c: In function '__libc_setup_tls':
> ../sysdeps/generic/libc-tls.c:191: warning: implicit declaration of 
> function 'INTERNAL_SYSCALL_DECL'

You'll need to provide more context, then, since I don't.  I built
those patches this morning.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
