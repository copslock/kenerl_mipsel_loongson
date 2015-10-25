Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2015 22:10:05 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:45748 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008799AbbJYVKDwn6WN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 25 Oct 2015 22:10:03 +0100
Received: from [192.168.178.22] (p5DE965E8.dip0.t-ipconnect.de [93.233.101.232])
        by hauke-m.de (Postfix) with ESMTPSA id C4C8A100029;
        Sun, 25 Oct 2015 22:10:02 +0100 (CET)
Message-ID: <562D452A.5030906@hauke-m.de>
Date:   Sun, 25 Oct 2015 22:10:02 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        linux-kernel@vger.kernel.org,
        Michal Nazarewicz <mina86@mina86.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Maciej W. Rozycki" <macro@codesourcery.com>
Subject: Re: [PATCH 10/16] compile error: MIPS: add definitions for extended
 context
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com> <1436540426-10021-11-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1436540426-10021-11-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This patch is causing a build error for me on 4.3-rc7.

  CC      arch/mips/kernel/signal.o
arch/mips/kernel/signal.c: In function 'sc_to_extcontext':
arch/mips/kernel/signal.c:143:12: error: 'struct ucontext' has no member
named 'uc_extcontext'
  return &uc->uc_extcontext;
            ^
In file included from include/linux/poll.h:11:0,
                 from include/linux/ring_buffer.h:7,
                 from include/linux/trace_events.h:5,
                 from include/trace/syscall.h:6,
                 from include/linux/syscalls.h:81,
                 from arch/mips/kernel/signal.c:26:
arch/mips/kernel/signal.c: In function 'save_msa_extcontext':
arch/mips/kernel/signal.c:171:40: error: dereferencing pointer to
incomplete type 'struct msa_extcontext'
   err = __put_user(read_msa_csr(), &msa->csr);
                                        ^
./arch/mips/include/asm/uaccess.h:441:15: note: in definition of macro
'__put_user_nocheck'
  __typeof__(*(ptr)) __pu_val;     \
               ^
arch/mips/kernel/signal.c:171:9: note: in expansion of macro '__put_user'
   err = __put_user(read_msa_csr(), &msa->csr);
         ^
arch/mips/kernel/signal.c:186:20: error: 'MSA_EXTCONTEXT_MAGIC'
undeclared (first use in this function)
  err |= __put_user(MSA_EXTCONTEXT_MAGIC, &msa->ext.magic);
                    ^
./arch/mips/include/asm/uaccess.h:444:14: note: in definition of macro
'__put_user_nocheck'
  __pu_val = (x);       \
              ^
arch/mips/kernel/signal.c:186:9: note: in expansion of macro '__put_user'
  err |= __put_user(MSA_EXTCONTEXT_MAGIC, &msa->ext.magic);
         ^
arch/mips/kernel/signal.c:186:20: note: each undeclared identifier is
reported only once for each function it appears in
  err |= __put_user(MSA_EXTCONTEXT_MAGIC, &msa->ext.magic);
                    ^
./arch/mips/include/asm/uaccess.h:444:14: note: in definition of macro
'__put_user_nocheck'
  __pu_val = (x);       \
              ^
arch/mips/kernel/signal.c:186:9: note: in expansion of macro '__put_user'
  err |= __put_user(MSA_EXTCONTEXT_MAGIC, &msa->ext.magic);
         ^
.......


When I include uapi/asm/ucontext.h instead of asm/ucontext.h in signal.c
it compiles again.

Hauke
