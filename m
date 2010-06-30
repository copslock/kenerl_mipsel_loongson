Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2010 22:37:17 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42940 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492376Ab0F3Ugw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jun 2010 22:36:52 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o5UEo7kL004270;
        Wed, 30 Jun 2010 15:50:07 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o5UEo6ui004268;
        Wed, 30 Jun 2010 15:50:06 +0100
Date:   Wed, 30 Jun 2010 15:50:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Adam Jiang <jiang.adam@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: How to detect STACKOVEFLOW on mips
Message-ID: <20100630145006.GA31938@linux-mips.org>
References: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20565

On Wed, Jun 30, 2010 at 02:59:42PM +0900, Adam Jiang wrote:

> I'm having a problem with kernel mode stack on my box. It seems that
> STACKOVERFLOW happened to Linux kernel. However, I can't prove it
> because the lack of any detection in __do_IRQ() function just like on
> the other architectures. If you know something about, please help me
> on following two questions.
> - Is there any possible to do this on MIPS?
> - or, more simple question, how could I get the address $sp pointed by
> asm() notation in C?

Due to the large register frame on MIPS the stack is 8kB on 32-bit, 16kB
on 64-bit or PAGE_SIZE, whatever is larger.  This is should be hard to
overflow by accident unless doing something outrageously stupid.

To access the stackpointer include <linux/thread_info.h>.  The function
current_thread_info() will return the pointer to the struct thread_info
of the current thread.  This structure is located at the bottom of the
stack.  With something like

  register void *stackp __asm__("$29");

you then can access the stack pointer as the stackp variable.  You
obviously need to maintain the relation

  current_thread_info() + 1 < stackp

at all times - and you better have a bit of extra space available just for
peace of mind.

There used to be some code for other architectures that zeros the stack
page and counts how much of that has been overwritten by the stack.  That
was never ported to MIPS.

Another helper to find functions that do excessive static allocations is
"make checkstack".

  Ralf
