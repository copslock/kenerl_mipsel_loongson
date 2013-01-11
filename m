Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2013 18:01:11 +0100 (CET)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:61752 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818323Ab3AKRBKSGB-I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jan 2013 18:01:10 +0100
Received: by mail-pb0-f51.google.com with SMTP id ro12so1047350pbb.38
        for <multiple recipients>; Fri, 11 Jan 2013 09:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2SV2OxWpELTs07N0aG9QprxqOl1yqFranzACXKFwLYc=;
        b=ixRS5oEHEN1lrf1JqlYYC6Fljt5LutjHNxBIBhC1854k668O8E2hikSeq/COkHRSEq
         hY7O0zZuWDBfys/iCOYRzkFArBzSvNBeQvHUNEuYJx526Wbr97lKjb7OavQdVZXCds6q
         EsQEYktAu72iHRk7CB1us57hvJ0R/YBq/HNY0U86sa6KDScev++Mc+E1wbYzhtIklBdg
         5V0c5mc0wWktG5Tq8TXR642FdQJuRii0CDPVhFDNPI7qx+yMQPOzLfIefI53YjMJ9zh0
         ieZbjhuzA1AkKNmsH0hcu8ewnqMbD3gptWa6c3HIeWkMbuRf89HAX1+qUWRlOFSNT594
         svGQ==
X-Received: by 10.68.130.135 with SMTP id oe7mr62374996pbb.38.1357923663210;
        Fri, 11 Jan 2013 09:01:03 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id rk6sm3075655pbc.20.2013.01.11.09.01.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 09:01:02 -0800 (PST)
Message-ID: <50F0454D.5060109@gmail.com>
Date:   Fri, 11 Jan 2013 09:01:01 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Al Cooper <alcooperx@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: function tracer: Fix broken function tracing
References: <y> <1357914810-20656-1-git-send-email-alcooperx@gmail.com>
In-Reply-To: <1357914810-20656-1-git-send-email-alcooperx@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/11/2013 06:33 AM, Al Cooper wrote:
> Function tracing is currently broken for all 32 bit MIPS platforms.
> When tracing is enabled, the kernel immediately hangs on boot.
> This is a result of commit b732d439cb43336cd6d7e804ecb2c81193ef63b0
> that changes the kernel/trace/Kconfig file so that is no longer
> forces FRAME_POINTER when FUNCTION_TRACING is enabled.
>
> MIPS frame pointers are generally considered to be useless because
> they cannot be used to unwind the stack. Unfortunately the MIPS
> function tracing code has bugs that are masked by the use of frame
> pointers. This commit fixes the bugs so that MIPS frame pointers do
> not need to be enabled.
>
> The bugs are a result of the odd calling sequence used to call the trace
> routine. This calling sequence is inserted into every tracable function
> when the tracing CONFIG option is enabled. This sequence is generated
> for 32bit MIPS platforms by the compiler via the "-pg" flag.
> Part of the sequence is "addiu sp,sp,-8" in the delay slot after every
> call to the trace routine "_mcount" (some legacy thing where 2 arguments
> used to be pushed on the stack). The _mcount routine is expected to
> adjust the sp by +8 before returning.
>
> One of the bugs is that when tracing is disabled for a function, the
> "jalr _mcount" instruction is replaced with a nop, but the
> "addiu sp,sp,-8" is still executed and the stack pointer is left
> trashed. When frame pointers are enabled the problem is masked
> because any access to the stack is done through the frame
> pointer and the stack pointer is restored from the frame pointer when
> the function returns. This patch uses a branch likely instruction
> "bltzl zero, f1" instead of "nop" to disable the call because this
> instruction will not execute the "addiu sp,sp,-8" instruction in
> the delay slot. The other possible solution would be to nop out both
> the jalr and the "addiu sp,sp,-8", but this would need to be interrupt
> and SMP safe and would be much more intrusive.

I thought all CPUs were in stop_machine() when the modifications were 
done, so that there is no issue with multi-word instruction patching.

Am I wrong about this?

So really I think you can do two NOP just as easily.

The only reason I bring this up is that I am not sure all 32-bit CPUs 
implement the 'Likely' branch variants. Also there may be an affect on 
the branch predictor.

A third possibility would be to replace the JALR with 'ADDIU SP,SP,8' 
That way the following adjustment would be canceled out.  This would 
work well on single-issue CPUs, but the instructions may not be able to 
dual-issue on a multi issue machine due to data dependencies.

David Daney

>
> A few other bugs were fixed where the _mcount routine itself did not
> always fix the sp on return.
>
