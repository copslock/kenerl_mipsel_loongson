Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 20:17:18 +0100 (BST)
Received: from ms-smtp-02.rdc-nyc.rr.com ([24.29.109.6]:61150 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by ftp.linux-mips.org with ESMTP
	id S20038915AbWJMTRN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 20:17:13 +0100
Received: from amiga (cpe-74-68-39-174.nj.res.rr.com [74.68.39.174])
	by ms-smtp-02.rdc-nyc.rr.com (8.13.6/8.13.6) with ESMTP id k9DJH9Ob011283;
	Fri, 13 Oct 2006 15:17:11 -0400 (EDT)
Date:	Fri, 13 Oct 2006 15:18:41 -0400
From:	Antonio SJ Musumeci <bile@landofbile.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: patch: include/asm-mips/system.h __cmpxchg64 bugfix and cleanup
Message-ID: <20061013151841.3a902627@amiga>
In-Reply-To: <20061013141101.GA19260@linux-mips.org>
References: <200610121802.k9CI26I5017308@ms-smtp-01.rdc-nyc.rr.com>
	<20061013104250.GA16820@linux-mips.org>
	<452F9A41.4020505@landofbile.com>
	<20061013141101.GA19260@linux-mips.org>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <bile@landofbile.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bile@landofbile.com
Precedence: bulk
X-list: linux-mips

Wouldn't it be better to check the macro in the preprocessor instead of
runtime? And why are those defined to 0 instead of explicitly undef'ed?
I've found one bug because it was assumed to be undefined instead of 0.
If no one objects I'll post a patch undefing those and fix any bugs I've
found because of them.

On Fri, 13 Oct 2006 15:11:01 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Oct 13, 2006 at 09:53:05AM -0400, Antonio SJ Musumeci wrote:
> 
> > Should I apply my patch on top of this one?
> 
> No, the two patches conflict in what they're doing.  The important
> part of your patch, the fix to the if condition I've already applied.
> 
>   Ralf
> 
