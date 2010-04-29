Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 17:46:36 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42622 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492131Ab0D2Pqc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Apr 2010 17:46:32 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3TFkPXi026045;
        Thu, 29 Apr 2010 16:46:25 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3TFkOxB026043;
        Thu, 29 Apr 2010 16:46:24 +0100
Date:   Thu, 29 Apr 2010 16:46:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnaud Patard <apatard@mandriva.com>
Cc:     wuzhangjin@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] loongson 2f: Add gpio/gpioilb support
Message-ID: <20100429154623.GA25765@linux-mips.org>
References: <m3sk6ewpep.fsf@anduin.mandriva.com>
 <1272543102.30655.138.camel@localhost>
 <m3iq7awiqi.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3iq7awiqi.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 29, 2010 at 02:23:01PM +0200, Arnaud Patard wrote:

> > The above blank line is at the end of the file, we can remove it,
> > otherwise, "git am" will complain about it.
> 
> Then, please, either fix your tool or fix it yourself. Last time I've
> looked at Documentation/SubmittingPatches, it was not
> mentionned. Moreover, checkpatch.pl is not complaining. If you really
> think, it's a must have, ask to fix checkpatch.pl first otherwise it's
> going to be missed again and again.

git-am will complain about it - with a not terribly helpful message that
does not mention the offending file.  I've configured git to strip
trailing whitespace and blank lines automatically.  In a patch series
this could lead to the problem where a subsequent patch fails to apply
because got modified.

>  arch/mips/Kconfig                        |    2      2 +     0 -     0 !
>  arch/mips/include/asm/mach-lemote/gpio.h |   33      33 +    0 -     0 !
>  arch/mips/loongson/common/Makefile           |    2  2 +     0 -     0 !
>  arch/mips/loongson/common/gpio.c             |  128  128 +   0 -     0 !
>  arch/mips/loongson/common/platform.c         |   25  25 +    0 -     0 !
>  5 files changed, 190 insertions(+)

Your diffstat doesn't match what's in the patch:

 arch/mips/Kconfig                          |    2 
 arch/mips/loongson/common/gpio.c           |  140 ++++++++++++++++++++++++++++
 arch/mips/loongson/common/Makefile         |    1 
 arch/mips/include/asm/mach-loongson/gpio.h |   35 +++++++
 4 files changed, 178 insertions(+), 0 deletions(-)

So what's wrong, diffstat or patch?

  Ralf
