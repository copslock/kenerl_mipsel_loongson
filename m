Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2012 16:15:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59912 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903265Ab2H3OP1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Aug 2012 16:15:27 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7UEFPU4004618;
        Thu, 30 Aug 2012 16:15:25 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7UEFPa5004617;
        Thu, 30 Aug 2012 16:15:25 +0200
Date:   Thu, 30 Aug 2012 16:15:25 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 1/2] asm-offsets.c: adding #define to break circular
 dependency
Message-ID: <20120830141525.GD23288@linux-mips.org>
References: <1346279647-27955-1-git-send-email-jim2101024@gmail.com>
 <503E9F66.9030200@gmail.com>
 <CANCKTBsXhKNtNJxYhyn4Ygt=c3=4ZT-quB3L1XJVFC4y-mWM7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBsXhKNtNJxYhyn4Ygt=c3=4ZT-quB3L1XJVFC4y-mWM7Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34382
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Aug 30, 2012 at 10:06:30AM -0400, Jim Quinlan wrote:

> I'm not sure the tangle is so easily undone.  The first dependency I see is
> 
> asm-offsets.c
> asm/processors.h
> linux/cpumask.h
> linux/kernel.h
> linux/bitops.h
> asm/bitops.h
> linux/irqflags.h
> asm/irqflags.h
> 
> When compared to other architectures, the MIPS asm/bitops.h seems to
> include more files at the top, including linux/irqflags.h.
> Any suggestions?

This is because MIPS bitops for some ancient processors which don't have
atomic operations and Cavium cnMIPS cores where disabling interrupts is
faster than the atomic operations are implemented by disabling interrupts.

This makes these atomic operations relativly bloated in terms of code size
generated and may it'd be a good idea to outline the bits.  With a bit
of luck we even get better cache locality - and fewer header file
inclusions.

  Ralf
