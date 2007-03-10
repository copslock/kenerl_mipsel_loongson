Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2007 13:26:21 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:40590 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021863AbXCJN0R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Mar 2007 13:26:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2ADOPla001638;
	Sat, 10 Mar 2007 13:24:25 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2ADOOKO001637;
	Sat, 10 Mar 2007 13:24:24 GMT
Date:	Sat, 10 Mar 2007 13:24:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Watkins <pwatkins@sicortex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Have sigpoll and sigio band field match glibc for n64
Message-ID: <20070310132423.GA1295@linux-mips.org>
References: <1173469586997-git-send-email-pwatkins@sicortex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1173469586997-git-send-email-pwatkins@sicortex.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 09, 2007 at 02:46:25PM -0500, Peter Watkins wrote:

> The siginfo field si_fd is incorrect on n64 because the band field does
> not match glibc.

Susv3 says:

[...]
The <signal.h> header shall define the siginfo_t type as a structure that
includes at least the following members:

[...]
long          si_band   Band event for SIGPOLL. 
[...]

So the kernel is right, glibc is wrong I'd say ...

  Ralf
