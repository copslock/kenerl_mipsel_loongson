Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 12:23:03 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53809 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013907AbaKRLXBVENmA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Nov 2014 12:23:01 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAIBMxuo015660;
        Tue, 18 Nov 2014 12:23:00 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAIBMxkJ015659;
        Tue, 18 Nov 2014 12:22:59 +0100
Date:   Tue, 18 Nov 2014 12:22:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     bin.jiang@windriver.com
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: get_user: set the parameter @x to zero on error
Message-ID: <20141118112258.GQ24983@linux-mips.org>
References: <1416292496-6149-1-git-send-email-bin.jiang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1416292496-6149-1-git-send-email-bin.jiang@windriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Nov 18, 2014 at 02:34:56PM +0800, bin.jiang@windriver.com wrote:

> From: Bin Jiang <bin.jiang@windriver.com>
> 
> The following compile warning is caused to use uninitialized variables:
> 
> fs/compat_ioctl.c: In function 'compat_SyS_ioctl':
> arch/mips/include/asm/uaccess.h:451:2: warning: 'length' may be used \
>                 uninitialized in this function [-Wmaybe-uninitialized]
>   __asm__ __volatile__(      \
>   ^
> fs/compat_ioctl.c:208:6: note: 'length' was declared here
>   int length, err;
>       ^
> 
> In get_user function, the parameter @x is used to store result. If the
> function return error, the @x won't be set and cause above warning.
> 
> According to the description of get_user function, the parameter @x should
> be set to zero on error.

You're not the first to send such a patch, see

  http://patchwork.linux-mips.org/patch/1307/

However I've hesistated to apply the previous patch which only claimed to
resolve a warning because __get_user and get_user get expanded very often
in the kernel so a small innocent looking change like this results in a
surprisingly large bloat.

A smart compiler will reorder this:

	int x;

	if (...) {
		...
	} else
		x = 0;

into:

	int x = 0;

	if (...) {
		...
	}

Which avoids the branches otherwise necessary for the else construct.  However
both the original and your patch fail to take care of the case where the
if is taken but __get_user_asm aborts due to an inaccessible fault.

That case is only fixed by manually doing above reordering - a compiler can't
know that the inline assembler won't assign anything in that case.

The comment btw was cut and paste and - blame me - it seems I failed to read
what it promises about @x for the error case; I had implemented get_user under
the assumption that the returned value was undefined in case of an -EFAULT
error.

Thanks for reporting this!

  Ralf
