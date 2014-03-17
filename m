Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2014 15:56:50 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56272 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6867611AbaCQO4svyWvg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Mar 2014 15:56:48 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2HEuivP013437;
        Mon, 17 Mar 2014 15:56:44 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2HEufGC013402;
        Mon, 17 Mar 2014 15:56:41 +0100
Date:   Mon, 17 Mar 2014 15:56:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Viller Hsiao <villerhsiao@gmail.com>
Cc:     linux-mips@linux-mips.org, rostedt@goodmis.org, fweisbec@gmail.com,
        mingo@redhat.com, Qais.Yousef@imgtec.com
Subject: Re: [PATCH v2 1/2] MIPS: ftrace: Tweak safe_load()/safe_store()
 macros
Message-ID: <20140317145641.GN19285@linux-mips.org>
References: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
 <1393055209-28251-2-git-send-email-villerhsiao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393055209-28251-2-git-send-email-villerhsiao@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39483
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

On Sat, Feb 22, 2014 at 03:46:48PM +0800, Viller Hsiao wrote:

> Due to name collision in ftrace safe_load and safe_store macros,
> these macros cannot take expressions as operands.
> 
> For example, compiler will complain for a macro call like the following:
>   safe_store_code(new_code2, ip + 4, faulted);
> 
>   arch/mips/include/asm/ftrace.h:61:6: note: in definition of macro 'safe_store'
>      : [dst] "r" (dst), [src] "r" (src)\
>         ^
>   arch/mips/kernel/ftrace.c:118:2: note: in expansion of macro 'safe_store_code'
>     safe_store_code(new_code2, ip + 4, faulted);
>     ^
>   arch/mips/kernel/ftrace.c:118:32: error: undefined named operand 'ip + 4'
>     safe_store_code(new_code2, ip + 4, faulted);
>                                   ^
>   arch/mips/include/asm/ftrace.h:61:6: note: in definition of macro 'safe_store'
>      : [dst] "r" (dst), [src] "r" (src)\
>         ^
>   arch/mips/kernel/ftrace.c:118:2: note: in expansion of macro 'safe_store_code'
>     safe_store_code(new_code2, ip + 4, faulted);
>     ^
> 
> This patch tweaks variable naming in those macros to allow flexible
> operands.

Interesting catch - and while I think your patch indeed is an improvment
nobody seems to have observed this in a kernel tree, so I'm going to treat
this as a non-urgent improvment and queue it for 3.15.

If this can be triggered in any -stable or v3.14-rc7 tree, please let me
know.

Thanks,

  Ralf
