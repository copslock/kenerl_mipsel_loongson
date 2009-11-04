Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 07:10:41 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36403 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492151AbZKDGKh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Nov 2009 07:10:37 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA46C5JG002769;
	Wed, 4 Nov 2009 07:12:05 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA46C5C1002767;
	Wed, 4 Nov 2009 07:12:05 +0100
Date:	Wed, 4 Nov 2009 07:12:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [-queue] arch/mips/kernel/linux32.c:304: error: implicit
	declaration of function 'lock_kernel'
Message-ID: <20091104061205.GB610@linux-mips.org>
References: <1257314349.3778.62.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257314349.3778.62.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 04, 2009 at 01:59:09PM +0800, Wu Zhangjin wrote:

> When I compile the queue branch of your -queue git repo, meet this
> error:
> 
> arch/mips/kernel/linux32.c: In function 'SYSC_32_sysctl':
> arch/mips/kernel/linux32.c:304: error: implicit declaration of function
> 'lock_kernel'
> arch/mips/kernel/linux32.c:307: error: implicit declaration of function
> 'unlock_kernel'
> 
> and found you have removed this <linux/smp_lock.h> header file in
> linux32.c in this commit: 
> 
> commit 0adcf22332d4da33629568fd14e00069cbf002e6
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Tue Nov 3 23:06:18 2009 +0100
> 
>     MIPS: Don't include <linux/smp_lock.h> unnecessarily.
>     
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> :100644 100644 938b1d0... 3676660... M
> arch/mips/basler/excite/excite_iodev.c
> :100644 100644 b77fefa... 07cc39e... M  arch/mips/kernel/linux32.c
> :100644 100644 364f066... dcaed1b... M  arch/mips/kernel/rtlx.c
> :100644 100644 6047752... 2bd2151... M  arch/mips/kernel/vpe.c
> :100644 100644 15ea778... ed2453e... M
> arch/mips/sibyte/common/sb_tbprof.c

There is another patch from Thomas Gleixner pending which will push down
the lock_kernel calls deeper into the sysctl calls.  I also had that
patch applied so missed that build failure.

> So, revert it for linux32.c?

Yes, that's what I'll do for now.

Thanks!

  Ralf
