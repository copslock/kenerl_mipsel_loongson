Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2006 23:44:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:63406 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038699AbWISWoA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Sep 2006 23:44:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8JMigDj005785;
	Tue, 19 Sep 2006 23:44:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8JMifX7005784;
	Tue, 19 Sep 2006 23:44:41 +0100
Date:	Tue, 19 Sep 2006 23:44:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org, richard@codesourcery.com
Subject: Re: [PATCH] fstatat syscall names
Message-ID: <20060919224441.GA4031@linux-mips.org>
References: <877j02xozk.fsf@talisman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877j02xozk.fsf@talisman.home>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Sep 17, 2006 at 08:38:39PM +0100, Richard Sandiford wrote:

> MIPS is the only port to call its fstatat()-related syscalls
> "__NR_fstatat".  Now I can see why that might be seen as every
> other port being wrong, but I think for o32, it is at best confusing.
> __NR_fstat provides a plain (32-bit) stat while __NR_fstatat provides a
> 64-bit stat.  Changing the name to __NR_fstatat64 would make things more
> explicit, match x86, and make the glibc port slightly easier.
> 
> The current name is more appropriate for n32 and n64, but it would be
> appropriate for other 64-bit targets too, and those targets have chosen
> to call it __NR_newfstatat instead.  Using the same name for MIPS would
> again be more consistent and make the glibc port slightly easier.
> 
> I'm not wedded to this idea if the current names are preferred,
> but FWIW...

I may have prefered the current naming at the time because they seemed to
be more logical to me when I choose those names but I'm not married to
them either.

  Ralf
