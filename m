Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 14:32:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:11702 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28579089AbXAWOcP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 14:32:15 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0NEWEKA018821;
	Tue, 23 Jan 2007 14:32:14 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0NEWEZo018820;
	Tue, 23 Jan 2007 14:32:14 GMT
Date:	Tue, 23 Jan 2007 14:32:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/7] Clean up signal code
Message-ID: <20070123143214.GC18083@linux-mips.org>
References: <1169561903878-git-send-email-fbuihuu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169561903878-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 23, 2007 at 03:18:16PM +0100, Franck Bui-Huu wrote:

> This patchset cleans up signal related code by factorizing code
> shared by all signal sources. The consequence is that the signal
> code is decreased a lot.
> 
> This patchset has been splitted out into 7 differents patches
> to ease code review.
> 
> Two questions are still open: 
> 
>     (a) It seems that the status register is not saved by
>         setup_sigcontext() and therefore not restored by
>         restore_sigcontext(). Is it a bug ?

No.  All the information in the MIPS c0_status register is priviledged.
Unlike CISC architectures MIPS has no flags such as zero, equal, overflow
or similar in the status register that is nothing that would constitute
part of the thread context.

The one flag one could possibly argument about might be c0_status.fr - but
none of the ABIs or tools or application software can make use of it ...

>     (b) Status register is saved by setup_sigcontext32() but
>         not restored by restore_sigcontext(). Is it a bug ?

Not really a bug but useless code, yes.  We used to save c0_status in the
dark ages but again, no known code - not even IRIX code - relies on this
field.

> Unfortunately I do not have any 64 bits cross compiler setup
> and no adequate plateforms to test the changes introduced by
> this patchset in signal32.c and signal_n32.c. If someone
> could give it a try, that would be nice.

Will try to find some time but likely it'll take me well over a week so
maybe somebody else?

  Ralf
