Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 16:53:30 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53705 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133540AbWCQQxW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2006 16:53:22 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2HH2jS2015905;
	Fri, 17 Mar 2006 17:02:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2HH2gdS015889;
	Fri, 17 Mar 2006 17:02:42 GMT
Date:	Fri, 17 Mar 2006 17:02:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 1480: "bad address" instead of "argument list too"
Message-ID: <20060317170242.GA13850@linux-mips.org>
References: <20060317165629.GX18750@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317165629.GX18750@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 17, 2006 at 04:56:29PM +0000, Martin Michlmayr wrote:

> I get the following in a directory which has many files in it on a
> Braodcom 1480:
> 
> 2179:tbm@bigsur: ~/build/logs] grep foo *
> zsh: bad address: grep
> 
> Normally, I'd expect an "zsh: argument list too long: grep" error.
> 
> I get this with different shells.  Hmm, that's interesting.  "echo *"
> works.  I assume shell built-in commands work but others don't.

Chances are this is caused by the return value of some syscall.  Can you
use strace on a shell to isolate it?  Is this 32-bit software on a 64-bit
kernel?

  Ralf
