Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2012 10:14:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36938 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903726Ab2H1IN7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Aug 2012 10:13:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7S8DvvV018914;
        Tue, 28 Aug 2012 10:13:57 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7S8DrC8018913;
        Tue, 28 Aug 2012 10:13:53 +0200
Date:   Tue, 28 Aug 2012 10:13:53 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lin Ming <mlin@ss.pku.edu.cn>
Cc:     linux-mips@linux-mips.org
Subject: Re: panic in hrtimer_run_queues
Message-ID: <20120828081353.GB23288@linux-mips.org>
References: <CAF1ivSYqNpzZD5U6Ne_FL_gDmPC0aETb7Gt3uyWZzNp9tTMP5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1ivSYqNpzZD5U6Ne_FL_gDmPC0aETb7Gt3uyWZzNp9tTMP5Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34368
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

On Tue, Aug 28, 2012 at 09:42:51AM +0800, Lin Ming wrote:

> Hi list,
> 
> I'm working on a board running 2.6.30 kernel.
> The panic log is attached in the end.
> 
> 8002c098:       0c00aeaa        jal     8002baa8 <__remove_hrtimer>
> 8002c09c:       00003821        move    a3,zero
> 8002c0a0:       8e220020        lw      v0,32(s1)
> 8002c0a4:       0040f809        jalr    v0
> 8002c0a8:       02202021        move    a0,s1
> 8002c0ac:       02002821        move    a1,s0
> ------> panic happens here.
> But this instruction just move data between registers.
> How could it cause memory access panic?

in case of a jal or jalr instruction the return address will point to the
instruction of the jal(r) instruction plus 2 instruction as here.  This
is where in case of a successful return from the subroutine execution
would continue.

But in your case v0 (that's register $2) contains 0 and it's been loaded
from address 32(s1) before, so it would appear that memory at that
address has either been overwritten or not initialized.

  Ralf
