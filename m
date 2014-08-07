Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2014 23:25:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38628 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6875431AbaHGVZRqlL7p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Aug 2014 23:25:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s77LPFwN012740;
        Thu, 7 Aug 2014 23:25:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s77LPEXV012739;
        Thu, 7 Aug 2014 23:25:14 +0200
Date:   Thu, 7 Aug 2014 23:25:14 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     Petri Gynther <pgynther@google.com>, linux-mips@linux-mips.org,
        Steven Rostedt <rostedt@goodmis.org>, cminyard@mvista.com
Subject: Re: [PATCH] MIPS: Ftrace: Fix dynamic tracing of kernel modules
Message-ID: <20140807212514.GD29898@linux-mips.org>
References: <20140724055502.301F710077A@puck.mtv.corp.google.com>
 <CAOGqxeXY4x7gyhpsSwm6dohG8rJschsR4yyd2YXdeAarsLp1WQ@mail.gmail.com>
 <CAGXr9JE7v9-hS3irmdgeaEU2iGLZHshEr_N-Do1UAsZhyzMe2g@mail.gmail.com>
 <CAOGqxeW8+cdfUuGqy8d6Ewcyy9oC7ZCsdd1p4aX_-zko38BAuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGqxeW8+cdfUuGqy8d6Ewcyy9oC7ZCsdd1p4aX_-zko38BAuA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41899
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

On Wed, Aug 06, 2014 at 01:12:06PM -0400, Alan Cooper wrote:

> Actually , there's no reason to write the second NOP when nop'ing the
> mcount call site in a module. This was done to remove the stack adjust
> instruction which only exists at this location for internal kernel
> routines. The following diff seems like a simpler way to solve issue
> #1:

Oh?

$ mips-linux-objdump -d --reloc net/sctp/sctp.ko
[...]
00000000 <sctp_sm_lookup_event>:
       0:       27bdffe8        addiu   sp,sp,-24
       4:       afbf0014        sw      ra,20(sp)
       8:       3c030000        lui     v1,0x0
                        8: R_MIPS_HI16  _mcount
       c:       24630000        addiu   v1,v1,0
                        c: R_MIPS_LO16  _mcount
      10:       03e00821        move    at,ra
      14:       27ac0014        addiu   t4,sp,20
      18:       0060f809        jalr    v1
      1c:       27bdfff8        addiu   sp,sp,-8  <====
[...]
      64:       27bd0018        addiu   sp,sp,24
      68:       03e00008        jr      ra
[...]

So the stack adjustment also exists for modules.

Or am I missunderstanding something?

  Ralf
