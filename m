Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2014 22:07:47 +0200 (CEST)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58977 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859950AbaFTUHorI8DD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jun 2014 22:07:44 +0200
Received: by mail-ie0-f174.google.com with SMTP id lx4so3563405iec.5
        for <linux-mips@linux-mips.org>; Fri, 20 Jun 2014 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=RM//3/y0LZCtaUvk0KNEd4zwAavkPH+swvPBlbW0EKU=;
        b=X6R77r1DvnprWpNBw6H+oGYWMgW8oWGsZf21drV+Iw8O41VVHoypzySbpS7GuFqeoL
         F2u1o034rJmiB9JZcBuXmJyPipcqZ5RWAEWTTUP+PNriFiIxt7HER10W4qqbzC02PqMu
         yqnY3IayA79lLMRgAyseYm9AtGa0MeMzjWvK0leGyQQ06F6Z5yZAH66xboSBlF8lrUqf
         0IIYkoB6pimp/tc2X2IjbCNZETvdxVNITXTVOmHgEPnianyh2hicl8wDKz8mZnt+uUdf
         5lwjIF/HzTkg9Sbvpq3EQAGmHl0l+aCAXe01C1A3lbufzCC5JUIKEjPiOKnsmNr7gEcW
         kdwg==
X-Received: by 10.50.141.164 with SMTP id rp4mr7406714igb.20.1403294858483;
        Fri, 20 Jun 2014 13:07:38 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id z8sm7001550igl.20.2014.06.20.13.07.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 13:07:37 -0700 (PDT)
Message-ID: <53A49488.6050902@gmail.com>
Date:   Fri, 20 Jun 2014 13:07:36 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Christoph Lameter <cl@linux.com>,
        linux-mips <linux-mips@linux-mips.org>
CC:     Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 19/31] MIPS: Replace __get_cpu_var uses in FPU emulator.
References: <20140620193115.547427118@linux.com> <20140620193127.123705312@linux.com>
In-Reply-To: <20140620193127.123705312@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40650
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

+ linux-mips@linux-mips.org, as that is the main MIPS patch reviewing list.

On 06/20/2014 12:31 PM, Christoph Lameter wrote:
> From: David Daney<david.daney@cavium.com>
>
> The use of __this_cpu_inc() requires a fundamental integer type, so
> change the type of all the counters to unsigned long, which is the
> same width they were before, but not wrapped in local_t.
>
> Signed-off-by: David Daney<david.daney@cavium.com>
> Signed-off-by: Christoph Lameter<cl@linux.com>
> ---
>   arch/mips/include/asm/fpu_emulator.h | 14 +++++++-------
>   arch/mips/math-emu/cp1emu.c          |  6 +++---
>   2 files changed, 10 insertions(+), 10 deletions(-)
>
> Index: linux/arch/mips/include/asm/fpu_emulator.h
> ===================================================================
> --- linux.orig/arch/mips/include/asm/fpu_emulator.h	2014-06-16 09:15:42.199326017 -0500
> +++ linux/arch/mips/include/asm/fpu_emulator.h	2014-06-16 09:17:42.776959733 -0500
> @@ -33,17 +33,17 @@
>   #ifdef CONFIG_DEBUG_FS
>
>   struct mips_fpu_emulator_stats {
> -	local_t emulated;
> -	local_t loads;
> -	local_t stores;
> -	local_t cp1ops;
> -	local_t cp1xops;
> -	local_t errors;
> -	local_t ieee754_inexact;
> -	local_t ieee754_underflow;
> -	local_t ieee754_overflow;
> -	local_t ieee754_zerodiv;
> -	local_t ieee754_invalidop;
> +	unsigned long emulated;
> +	unsigned long loads;
> +	unsigned long stores;
> +	unsigned long cp1ops;
> +	unsigned long cp1xops;
> +	unsigned long errors;
> +	unsigned long ieee754_inexact;
> +	unsigned long ieee754_underflow;
> +	unsigned long ieee754_overflow;
> +	unsigned long ieee754_zerodiv;
> +	unsigned long ieee754_invalidop;
>   };
>
>   DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
> @@ -51,7 +51,7 @@
>   #define MIPS_FPU_EMU_INC_STATS(M)					\
>   do {									\
>   	preempt_disable();						\
> -	__local_inc(&__get_cpu_var(fpuemustats).M);			\
> +	__this_cpu_inc(fpuemustats.M);					\
>   	preempt_enable();						\
>   } while (0)
>
>
