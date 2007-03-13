Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 16:43:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:17280 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022314AbXCMQnE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 16:43:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2DGf8C6005354;
	Tue, 13 Mar 2007 16:41:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2DGf7KI005353;
	Tue, 13 Mar 2007 16:41:07 GMT
Date:	Tue, 13 Mar 2007 16:41:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Peter Watkins <pwatkins@sicortex.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Have sigpoll and sigio band field match glibc for n64
Message-ID: <20070313164107.GA5004@linux-mips.org>
References: <1173469586997-git-send-email-pwatkins@sicortex.com> <20070310132423.GA1295@linux-mips.org> <20070313141951.GA3206@caradoc.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070313141951.GA3206@caradoc.them.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 13, 2007 at 10:19:51AM -0400, Daniel Jacobowitz wrote:

> This will break the ABI only for uses of si_band and si_fd, and only
> on n64.  Anyone see a reason why I shouldn't change glibc?
> 
> Ralf, as I mentioned on IRC, I've got bigger worries about siginfo.
> Shouldn't n32 be using the same siginfo as o32?  It's got pointers in it.

Yes, you're right.  Will you cook up a patch?

  Ralf
