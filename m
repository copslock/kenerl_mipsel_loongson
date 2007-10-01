Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 11:24:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:8862 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022158AbXJAKYj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 11:24:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l91AOZv3023296;
	Mon, 1 Oct 2007 11:24:35 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l91AOXAv023295;
	Mon, 1 Oct 2007 11:24:33 +0100
Date:	Mon, 1 Oct 2007 11:24:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Fuxin Zhang <fxzhang@ict.ac.cn>, linux-mips@linux-mips.org
Subject: Re: cmpxchg broken in some situation
Message-ID: <20071001102433.GA20219@linux-mips.org>
References: <46FF7BC2.5050905@ict.ac.cn> <20071001025340.GA7091@linux-mips.org> <47007003.2050905@avtrex.com> <4700708B.8070708@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4700708B.8070708@avtrex.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Sep 30, 2007 at 08:59:07PM -0700, David Daney wrote:

> David Daney wrote:
> >Ralf Baechle wrote:
> >>+    } else if (cpu_has_llsc) {                    \
> >>+        __asm__ __volatile__(                    \
> >>+        "    .set    push                \n"    \
> >>+        "    .set    noat                \n"    \
> >>+        "    .set    mips3                \n"    \
> >>+        "1:    " ld "    %0, %2        # __cmpxchg_u32    \n"    \
> >>+        "    bne    %0, %z3, 2f            \n"    \
> >>+        "    .set    mips0                \n"    \
> >>+        "    move    $1, %z4                \n"    \
> >>+        "    .set    mips3                \n"    \
> >>+        "    " st "    $1, %1                \n"    \
> >>+        "    beqz    $1, 3f                \n"    \
> >>+        "2:                        \n"    \
> >>+        "    .subsection 2                \n"    \
> >>+        "3:    b    1b                \n"    \
> >>+        "    .previous                \n"    \
> >>+        "    .set    pop                \n"    \
> >>+        : "=&r" (__ret), "=R" (*m)                \
> >>+        : "R" (*m), "Jr" (old), "Jr" (new)            \
> >>+        : "memory");                        \
> >>  
> >Is a 'sync' needed after the 'sc'?
> >
> >According to this message:
> >http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20070919084515.GM9972%40networkno.de 
> >
> >it would seem so.
> 
> Drat, I probably posted too soon.  That is the smp_llsc_mb(); isn't it.

Yes - and the answer to your original question is a clear and definate
maybe ;-)

In the kernel we can afford to optimize for every piece of silicon on earth.
In userspace we can't make that sort of compile time choices as easily so
it's a better idea to just litter a few SYNCs over the code.

  Ralf
