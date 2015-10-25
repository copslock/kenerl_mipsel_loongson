Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2015 22:47:45 +0100 (CET)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35461 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009737AbbJYVrm7a49R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2015 22:47:42 +0100
Received: by oifu63 with SMTP id u63so48274470oif.2;
        Sun, 25 Oct 2015 14:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=qzJ7nwxkQG095lYvEihhK238ppC4iYH7blfcsGtZD/Y=;
        b=e0ue8Z/r9flc2FS9GT7zO/OuJ6yvfNEK9+acJ+efx9XRdlApTyDn58sVfd3CyXiRU8
         3Nc3UMgvfBngsM7cb55d9WqqtQyjCYUkRwlfJPv6xXycVtCbdDLhrk8yGE9emYT4H8nG
         o2YwBFf2Hh3sGHMhDH6AYptAWlIy5iKvmdTgZO6wJQvjC0s7DOfMgpkDM3DcVoP1hX5m
         dq6baqydWDNQONLAx9+0lA9AW278IUXc6eSmS1ibRngp5QpSbJ3RmsLQj8PoFvKgp8Q2
         Xqrinlwq/CxL8jXwE6vp0LzFkVUzGo+jmHnU9RMsqEZBYUX3K4CPFF2ISNbFh7O+wUW3
         NMaw==
X-Received: by 10.202.56.85 with SMTP id f82mr21458050oia.37.1445809657006;
        Sun, 25 Oct 2015 14:47:37 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:54f0:ccd0:ed05:ab8a? ([2001:470:d:73f:54f0:ccd0:ed05:ab8a])
        by smtp.googlemail.com with ESMTPSA id f1sm13365968oeu.17.2015.10.25.14.47.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Oct 2015 14:47:35 -0700 (PDT)
Subject: Re: [PATCH 10/16] compile error: MIPS: add definitions for extended
 context
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
 <1436540426-10021-11-git-send-email-paul.burton@imgtec.com>
 <562D452A.5030906@hauke-m.de>
Cc:     Matthew Fortune <matthew.fortune@imgtec.com>,
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
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <562D4DF5.1020304@gmail.com>
Date:   Sun, 25 Oct 2015 14:47:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <562D452A.5030906@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 25/10/2015 14:10, Hauke Mehrtens a écrit :
> This patch is causing a build error for me on 4.3-rc7.
> 
>   CC      arch/mips/kernel/signal.o
> arch/mips/kernel/signal.c: In function 'sc_to_extcontext':
> arch/mips/kernel/signal.c:143:12: error: 'struct ucontext' has no member
> named 'uc_extcontext'
>   return &uc->uc_extcontext;
>             ^
> In file included from include/linux/poll.h:11:0,
>                  from include/linux/ring_buffer.h:7,
>                  from include/linux/trace_events.h:5,
>                  from include/trace/syscall.h:6,
>                  from include/linux/syscalls.h:81,
>                  from arch/mips/kernel/signal.c:26:
> arch/mips/kernel/signal.c: In function 'save_msa_extcontext':
> arch/mips/kernel/signal.c:171:40: error: dereferencing pointer to
> incomplete type 'struct msa_extcontext'
>    err = __put_user(read_msa_csr(), &msa->csr);
>                                         ^
> ./arch/mips/include/asm/uaccess.h:441:15: note: in definition of macro
> '__put_user_nocheck'
>   __typeof__(*(ptr)) __pu_val;     \
>                ^
> arch/mips/kernel/signal.c:171:9: note: in expansion of macro '__put_user'
>    err = __put_user(read_msa_csr(), &msa->csr);
>          ^
> arch/mips/kernel/signal.c:186:20: error: 'MSA_EXTCONTEXT_MAGIC'
> undeclared (first use in this function)
>   err |= __put_user(MSA_EXTCONTEXT_MAGIC, &msa->ext.magic);
>                     ^
> ./arch/mips/include/asm/uaccess.h:444:14: note: in definition of macro
> '__put_user_nocheck'
>   __pu_val = (x);       \
>               ^
> arch/mips/kernel/signal.c:186:9: note: in expansion of macro '__put_user'
>   err |= __put_user(MSA_EXTCONTEXT_MAGIC, &msa->ext.magic);
>          ^
> arch/mips/kernel/signal.c:186:20: note: each undeclared identifier is
> reported only once for each function it appears in
>   err |= __put_user(MSA_EXTCONTEXT_MAGIC, &msa->ext.magic);
>                     ^
> ./arch/mips/include/asm/uaccess.h:444:14: note: in definition of macro
> '__put_user_nocheck'
>   __pu_val = (x);       \
>               ^
> arch/mips/kernel/signal.c:186:9: note: in expansion of macro '__put_user'
>   err |= __put_user(MSA_EXTCONTEXT_MAGIC, &msa->ext.magic);
>          ^
> .......
> 
> 
> When I include uapi/asm/ucontext.h instead of asm/ucontext.h in signal.c
> it compiles again.

The problem appears if you had previously auto-generated files in
arch/mips/include/generated that do not get automatically cleaned up
when you switch to a new kernel version, and with an incompatible
ucontext layout between the two.

Jacek tripped over that here:

https://www.linux-mips.org/archives/linux-mips/2015-09/msg00150.html

and I asked whether we could follow-up with a proper Kbuild patch to
address that build dependency here:

https://www.linux-mips.org/archives/linux-mips/2015-09/msg00165.html

but this does not appear to have been proposed or addressed yet.

Paul, could you look into this and see how we could teach Kbuild about
this build dependency?
-- 
Florian
