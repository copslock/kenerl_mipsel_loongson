Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Oct 2006 20:07:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:31670 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039499AbWJOTHg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Oct 2006 20:07:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9FIgrq4003272;
	Sun, 15 Oct 2006 19:42:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9FIgRvt003271;
	Sun, 15 Oct 2006 19:42:27 +0100
Date:	Sun, 15 Oct 2006 19:42:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Antonio SJ Musumeci <bile@landofbile.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: patch: include/asm-mips/system.h __cmpxchg64 bugfix and cleanup
Message-ID: <20061015184226.GA3259@linux-mips.org>
References: <200610121802.k9CI26I5017308@ms-smtp-01.rdc-nyc.rr.com> <20061013104250.GA16820@linux-mips.org> <452F9A41.4020505@landofbile.com> <20061013141101.GA19260@linux-mips.org> <20061013151841.3a902627@amiga>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013151841.3a902627@amiga>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 13, 2006 at 03:18:41PM -0400, Antonio SJ Musumeci wrote:

> Wouldn't it be better to check the macro in the preprocessor instead of
> runtime? And why are those defined to 0 instead of explicitly undef'ed?
> I've found one bug because it was assumed to be undefined instead of 0.
> If no one objects I'll post a patch undefing those and fix any bugs I've
> found because of them.

Any reasonable system configuration will define cpu_has_llsc to 1 in
order to override the default.  R10000_LLSC_WAR is a constant as well.
So only one of the three if blocks will remain.  If that's not the case
you either don't have a cpu-feature-overrides.h file for your platform
or it doesn't define cpu_has_llsc to a constant expression.

  Ralf
