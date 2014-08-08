Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2014 06:12:15 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:58994 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859939AbaHHEMMUEPCP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Aug 2014 06:12:12 +0200
Received: by mail-pa0-f47.google.com with SMTP id kx10so6464715pab.6
        for <multiple recipients>; Thu, 07 Aug 2014 21:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4jQr+j4FQhQrAg7iKtZuwqJIonJ5r4ROlZooX3wBzs0=;
        b=HuQ9D4xXH5gD4MWTjNjJE9h9OZDGM42WYF2rR6nPzlymkok4G73E9/mNrLM7XXOHk9
         bRyS0d4lzhYsaiW4JDWIKHc7GWgud1KU413oUoRp6iLfCI6SrmiqOnLF6LMQ8hx+csI8
         +dVJdKGcEKl1CDexfve5EfTAenG0ML2UYfEBJZmaNeO5eN39+/cNsKAD5hWbE46vkCC0
         AfTS1ZRU74tChi4YN67kOuwylYbOx3NQgMvKYSX0Ngoa8T/JWUsv3v3LVHAPr+e8awH9
         h3m5sQgUeQGnsDnfse+egnhAfamVyDVYk+9+SsOesV5xtdgg9xzk5BJnxKs9qvMVqHPJ
         cpLw==
X-Received: by 10.66.155.167 with SMTP id vx7mr4180pab.141.1407471125372;
        Thu, 07 Aug 2014 21:12:05 -0700 (PDT)
Received: from yggdrasil.local (42-66-15-49.EMOME-IP.hinet.net. [42.66.15.49])
        by mx.google.com with ESMTPSA id qb2sm1430645pbb.0.2014.08.07.21.12.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Aug 2014 21:12:04 -0700 (PDT)
Date:   Fri, 8 Aug 2014 12:11:54 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Alan Cooper <alcooperx@gmail.com>,
        Petri Gynther <pgynther@google.com>,
        Jun-Ru Chang <jrjang@gmail.com>, cminyard@mvista.com,
        Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Ftrace: Fix dynamic tracing of kernel modules
Message-ID: <20140808120113-tung7970@googlemail.com>
References: <20140724055502.301F710077A@puck.mtv.corp.google.com>
 <CAOGqxeXY4x7gyhpsSwm6dohG8rJschsR4yyd2YXdeAarsLp1WQ@mail.gmail.com>
 <CAGXr9JE7v9-hS3irmdgeaEU2iGLZHshEr_N-Do1UAsZhyzMe2g@mail.gmail.com>
 <CAOGqxeW8+cdfUuGqy8d6Ewcyy9oC7ZCsdd1p4aX_-zko38BAuA@mail.gmail.com>
 <20140807212514.GD29898@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140807212514.GD29898@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

On Thu, Aug 07, 2014 at 11:25:14PM +0200, Ralf Baechle wrote:
> On Wed, Aug 06, 2014 at 01:12:06PM -0400, Alan Cooper wrote:
> 
> > Actually , there's no reason to write the second NOP when nop'ing the
> > mcount call site in a module. This was done to remove the stack adjust
> > instruction which only exists at this location for internal kernel
> > routines. The following diff seems like a simpler way to solve issue
> > #1:
> 
> Oh?
> 
> $ mips-linux-objdump -d --reloc net/sctp/sctp.ko
> [...]
> 00000000 <sctp_sm_lookup_event>:
>        0:       27bdffe8        addiu   sp,sp,-24
>        4:       afbf0014        sw      ra,20(sp)
>        8:       3c030000        lui     v1,0x0
>                         8: R_MIPS_HI16  _mcount
>        c:       24630000        addiu   v1,v1,0
>                         c: R_MIPS_LO16  _mcount
>       10:       03e00821        move    at,ra
>       14:       27ac0014        addiu   t4,sp,20
>       18:       0060f809        jalr    v1
>       1c:       27bdfff8        addiu   sp,sp,-8  <====
> [...]
>       64:       27bd0018        addiu   sp,sp,24
>       68:       03e00008        jr      ra
> [...]
> 
> So the stack adjustment also exists for modules.
> 
> Or am I missunderstanding something?
> 
>   Ralf
> 

We have a workaround for dynamic ftrace under 32bit mode back in Feburary. I thought
it is not good enough but maybe this is the right solution for issue #1 ?

Tony

commit d3167328b1bd63c22abb129a17fcb658e11c2a7b
Author: Jun-Ru Chang <jrjang@gmail.com>
Date:   Thu Feb 27 15:23:34 2014 +0800

    mips: ftrace: fix ftrace_make_call long call restore
    
    In case of long call under 32bit mode, two instructions,
    lui and addiu, are required to load the mcount address into
    the jump register.
    
    In ftrace_make_nop, both instructions are marked as nop, so
    in ftrace_make_call, we have to restore both of them.
    
    Signed-off-by: Jun-Ru Chang <jrjang@gmail.com>
    Signed-off-by: Tony Wu <tung7970@gmail.com>

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 9bb8bcd..b12858c 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -61,6 +61,9 @@ static inline int in_kernel_space(unsigned long ip)
 
 static unsigned int insn_jal_ftrace_caller __read_mostly;
 static unsigned int insn_lui_v1_hi16_mcount __read_mostly;
+#ifndef CONFIG_64BIT
+static unsigned int insn_add_v1_lo16_mcount __read_mostly;
+#endif
 static unsigned int insn_j_ftrace_graph_caller __maybe_unused __read_mostly;
 
 static inline void ftrace_dyn_arch_init_insns(void)
@@ -73,6 +76,12 @@ static inline void ftrace_dyn_arch_init_insns(void)
 	buf = (u32 *)&insn_lui_v1_hi16_mcount;
 	UASM_i_LA_mostly(&buf, v1, MCOUNT_ADDR);
 
+#ifndef CONFIG_64BIT
+	/* addiu v1, vi, lo16_mcount */
+	buf = (u32 *)&insn_add_v1_lo16_mcount;
+	UASM_i_LA(&buf, v1, MCOUNT_ADDR);
+#endif
+
 	/* jal (ftrace_caller + 8), jump over the first two instruction */
 	buf = (u32 *)&insn_jal_ftrace_caller;
 	uasm_i_jal(&buf, (FTRACE_ADDR + 8) & JUMP_RANGE_MASK);
@@ -180,7 +189,10 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	new = in_kernel_space(ip) ? insn_jal_ftrace_caller :
 		insn_lui_v1_hi16_mcount;
 
-	return ftrace_modify_code(ip, new);
+	if (IS_BUILTIN(CONFIG_64BIT) || new == insn_jal_ftrace_caller)
+		return ftrace_modify_code(ip, new);
+	else
+		return ftrace_modify_code_2(ip, new, insn_add_v1_lo16_mcount);
 }
 
 #define FTRACE_CALL_IP ((unsigned long)(&ftrace_call))
