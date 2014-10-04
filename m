Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2014 18:04:02 +0200 (CEST)
Received: from mail-vc0-f178.google.com ([209.85.220.178]:53254 "EHLO
        mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010519AbaJDQEAO2wKl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Oct 2014 18:04:00 +0200
Received: by mail-vc0-f178.google.com with SMTP id hq12so1754765vcb.37
        for <multiple recipients>; Sat, 04 Oct 2014 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QEWaIYBfpH2LyBO2Sopf8EpJQkDBrdi/ttt6Hq/27Fg=;
        b=iekPpE14l2gQgs/qz2IAxxq/GTsILJraqVgnNBCNBvdHJUW2UZ4/5unnJxuVTm0BtR
         4JegH+0l9UPQcz/6HsG/a+OcXbf+BuhArjcu2OuTQC+abULU2RDZD/4oqN93cZ+DpMO8
         K/n3FT+0MBo+JT8r5zTw+M1yO7AOLlXlD9lqNvgDMxhb1h7L+ebcPUZtwdCxVx1GEJpw
         A8C658HBSeoBSfkE8O/zYjGk5NE8sty7XeDYotnG8Fey5rqXhf6MpY92gw+fN0q2QdOo
         PHtX3KF0n4WRjz67t6Wcf3vxNlaVXYsOPIlpbNL6XUnXTL88xQhIztu0QbCJ67vUoHsR
         ZUkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QEWaIYBfpH2LyBO2Sopf8EpJQkDBrdi/ttt6Hq/27Fg=;
        b=A1svTCPf9sRC9KDhrN+BqA6Il0pKOYWQkceuOB5zL0yzyOwn+95+CwhgTWSy6cVYjw
         YgCfRX+8UAkNLPwoABu9sxZ3f+6srKF7QNI89TFIMkcbY+pGlF0R83N6GURXgdQlA8/s
         1RPlO+CIoAIkUc5uhy9qv2e1zVhyq1giMMe70=
MIME-Version: 1.0
X-Received: by 10.52.166.102 with SMTP id zf6mr13262vdb.62.1412438633845; Sat,
 04 Oct 2014 09:03:53 -0700 (PDT)
Received: by 10.220.3.148 with HTTP; Sat, 4 Oct 2014 09:03:53 -0700 (PDT)
In-Reply-To: <20141004082307.GS10583@worktop.programming.kicks-ass.net>
References: <20141004030438.28569.85536.stgit@linux-yegoshin>
        <20141004082307.GS10583@worktop.programming.kicks-ass.net>
Date:   Sat, 4 Oct 2014 09:03:53 -0700
X-Google-Sender-Auth: a5LSQBCKbsHbsdRVmigCIx0FDaE
Message-ID: <CA+55aFynSp90n=jdUdmY7nq-9t4pHS82Tj-WfZOBfot7ip0hBw@mail.gmail.com>
Subject: Re: [PATCH 0/3] MIPS executable stack protection
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Zubair.Kakakhel@imgtec.com, David Daney <david.daney@cavium.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Davidlohr Bueso <davidlohr@hp.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>, chenhc@lemote.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>, alex@alex-smith.me.uk,
        Thomas Gleixner <tglx@linutronix.de>,
        John Crispin <blogic@openwrt.org>, jchandra@broadcom.com,
        paul.burton@imgtec.com, qais.yousef@imgtec.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, markos.chandras@imgtec.com,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        lars.persson@axis.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Sat, Oct 4, 2014 at 1:23 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Oct 03, 2014 at 08:17:14PM -0700, Leonid Yegoshin wrote:
>> The following series implements an executable stack protection in MIPS.
>>
>> It sets up a per-thread 'VDSO' page and appropriate TLB support.
>
> So traditionally we've always avoided per-thread pages like that. What
> makes it worth it on MIPS?

Nothing makes it worth it on MIPS.

It may be easy to implement when you have all software-fill of TLB's,
but it's a mistake even then - because it means that you'll never be
able to do hardware TLB walkers.

And MIPS *does* have hardware TLB walkers, even if they are not
necessarily available everywhere.

So this is a horrible idea. Don't do it. Page tables need to be
per-process, not per thread, so that page tables can be shared.

              Linus
