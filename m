Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 18:37:53 +0200 (CEST)
Received: from mail-pb0-f47.google.com ([209.85.160.47]:39428 "EHLO
        mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816022Ab3DJQhv1VWf8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Apr 2013 18:37:51 +0200
Received: by mail-pb0-f47.google.com with SMTP id rq13so363358pbb.34
        for <multiple recipients>; Wed, 10 Apr 2013 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=UYFUFeAhY0ZTs/gEKDcmOFbiiuenYwcs4OuWq8+FPc8=;
        b=aiH1eWMQgcW1Nw3fmZaJ53O1tpIPebFA0IBHorMmgOxZVptJhr3ysFZmwbz1zSO/b9
         XEgJ4mx9jgCaVY+2zyOe8DW5IYGkEw5Q9JkSQdmC44pNoQI/uCP5aAmFjLDFLjLUZxnf
         SBd7xOp9JTt5ad1avH16I6xRlqbHTT7/SVlKJGsaA68RVALzVeMnChF97TOWrZYeXSCQ
         5SuC8He1GISzfKG+83mdp4tKpL3UV6aJvMLqx4cgl7e86EdTMqL4BCBTeP/BY3sdY/0w
         jZMJbRJxeeRWXTixhrMABEDB8CxbGYzkVFMjtU8YPUqJaP8RznniYerGguD/cVB/qTyx
         pRTg==
X-Received: by 10.66.171.132 with SMTP id au4mr4612469pac.11.1365611864879;
        Wed, 10 Apr 2013 09:37:44 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ef3sm1055132pad.20.2013.04.10.09.37.43
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 09:37:43 -0700 (PDT)
Message-ID: <51659556.3070502@gmail.com>
Date:   Wed, 10 Apr 2013 09:37:42 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Wladislav Wiebe <wladislav.kw@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Makefile: workaround printk recursion bug
References: <51652CF5.1080009@gmail.com>
In-Reply-To: <51652CF5.1080009@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36068
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

On 04/10/2013 02:12 AM, Wladislav Wiebe wrote:
>
> From: Wladislav Wiebe <wladislav.kw@gmail.com>
>
> Function tracing is broken due to removal of selecting FRAME_POINTER with
> FUNCTION_TRACER as result of commit: b732d439cb43336cd6d7e804ecb2c81193ef63b0
>
> Latest commit ad8c396936e328f5344e1881afde9e28d5f2045f "MIPS: Unbreak
> function tracer for 64-bit kernel." fixes just the early startup hang,
> but on MIPS64/CAVIUM_OCTEON2 are still random printk recursion bugs
> which cause also Kernel hangs, especially on late startup phase when
> network drivers get loaded. This patch enable for CAVIUM_OCTEON2/64 Bit
> architecture -fno-omit-frame-pointer cflag when FUNCTION_TRACER get
> enabled. This will fix random Kernel hangs with "BUG: recent printk
> recursion!" from linux/kernel/printk.c.
>
> Maybe there exist a other solution in mcount handling, since in the
> commit message from Al Cooper is mentioned that "MIPS frame pointers are
> generally considered to be useless because they cannot be used to unwind
> the stack. Unfortunately the MIPS function tracing code has bugs that
> are masked by the use of frame pointers. This commit fixes the bugs so
> that MIPS frame pointers don't need to be enabled."
>
> But this is just a solution for MIPS32 - on a symmetric multiprocessing
> @MIPS64/CAVIUM_OCTEON2 it doesn't work properly.

There are a couple of problems that I see with this patch:

1) It doesn't handle non-OCTEON2.  Surely other 64-bit targets are 
effected as well

2) You don't say how it is broken or how this fixes it.

3) Function graph tracing on 3.9.0-rc6 compiled with gcc-4.7.0 works 
fine for me without this.  So I see no need to clog up the make files 
with a rats nest of ifdef

Without more information about why this  is needed, I would have to say NAK.

David Daney

>
> Signed-off-by: Wladislav Wiebe <wladislav.kw@gmail.com>
> ---
>   arch/mips/Makefile |    9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 6f7978f..8befe31 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -119,6 +119,15 @@ cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
>   				   -fno-omit-frame-pointer
>
>   #
> +# FTrace depended compiler options, currently only needed by MIPS64/OCTEON2.
> +#
> +ifdef CONFIG_64BIT
> +ifdef CONFIG_CAVIUM_OCTEON2
> +cflags-$(CONFIG_FUNCTION_TRACER) += $(call cc-option,-fno-omit-frame-pointer)
> +endif
> +endif
> +
> +#
>   # CPU-dependent compiler/assembler options for optimization.
>   #
>   cflags-$(CONFIG_CPU_R3000)	+= -march=r3000
>
