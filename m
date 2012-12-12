Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 15:26:23 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:63976 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823690Ab2LLO0WNsL0N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 15:26:22 +0100
Received: by mail-la0-f49.google.com with SMTP id r15so654213lag.36
        for <multiple recipients>; Wed, 12 Dec 2012 06:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BWC70ruUfUEo9agIGAATFfwpkH7zOrtLKKd5qdd5hMI=;
        b=myXHd0WwSTrK//ANhC+hGCWevPPkkzZAV9Cor8Sa8G/3BnZfuwsJUBaU860/XhAI2M
         7ceBIb+yFOJd0Bjk2CUjufeYe68JmSIDlHZTkZ/Vz7g+YdPJF+9anbqRPFAjmaJLCA2V
         nCT3vWlEZJ3WLc9AybX35LJfSSTEq0QKj5+diS6dx7xsikB3w3k10Gnws74WY98U7A0w
         El0o7wVciMVxLQo3w2IPX2Il+QjyFoc5lb9be3ChMIME+a8LJ92NVnwYlHMXwTvaLxRp
         ePQbb34dKi9HciElzvWc2GsNDGv3KbtJZd3MwZxq/nPgiOqcsn2YT25XVrSQLqT7xdFc
         lz2Q==
Received: by 10.152.135.139 with SMTP id ps11mr1215913lab.29.1355322376483;
        Wed, 12 Dec 2012 06:26:16 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id u9sm10787664lbf.5.2012.12.12.06.26.15
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 06:26:16 -0800 (PST)
Message-ID: <50C8938C.8020705@openwrt.org>
Date:   Wed, 12 Dec 2012 15:24:12 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: dsp: Add assembler support for DSP ASEs.
References: <1354855981-28392-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1354855981-28392-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Hi Steven,

Le 12/07/12 05:53, Steven J. Hill a écrit :
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Newer toolchains support the DSP and DSP Rev2 instructions. This patch
> performs a check for that support and adds compiler and assembler
> flags for only the files that need use those instructions.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>   arch/mips/include/asm/mipsregs.h |   53 ++++++++++++++++++++++++++------------
>   arch/mips/kernel/Makefile        |   24 +++++++++++++++++
>   2 files changed, 60 insertions(+), 17 deletions(-)
>
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -99,4 +99,28 @@ obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
>
>   obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
>
> +ifeq ($(CONFIG_CPU_MIPS32), y)
> +#
> +# Check if assembler supports DSP ASE
> +#
> +ifeq ($(call cc-option-yn,-mdsp), y)
> +CFLAGS_signal.o			= -mdsp -DHAVE_AS_DSP
> +CFLAGS_signal32.o		= -mdsp -DHAVE_AS_DSP
> +CFLAGS_process.o		= -mdsp -DHAVE_AS_DSP
> +CFLAGS_branch.o			= -mdsp -DHAVE_AS_DSP
> +CFLAGS_ptrace.o			= -mdsp -DHAVE_AS_DSP
> +endif
> +
> +#
> +# Check if assembler supports DSP ASE Rev2
> +#
> +ifeq ($(call cc-option-yn,-mdsp2), y)
> +CFLAGS_signal.o			= -mdsp2 -DHAVE_AS_DSP
> +CFLAGS_signal32.o		= -mdsp2 -DHAVE_AS_DSP
> +CFLAGS_process.o		= -mdsp2 -DHAVE_AS_DSP
> +CFLAGS_branch.o			= -mdsp2 -DHAVE_AS_DSP
> +CFLAGS_ptrace.o			= -mdsp2 -DHAVE_AS_DSP

Should not this be -mdspr2 here? My GCC man page suggests that.

By the way, should not we also check that we are building for a 
MIPS32_R2 CPU when checking for -mdsp2?

> +endif
> +endif
> +

I would simplify this like this:

ifeq ($(CONFIG_CPU_MIPS32),y)
CFLAGS_DSP = -DHAVE_AS_DSP
ifeq ($(call cc-option-yn,-mdsp),y)
CFLAGS_DSP += -mdsp
endif
ifeq ($(call cc-option-yn,-mdsp2),y)
CFLAGS-DSP += -mdsp2
endif

CFLAGS_signal.o		= $(CFLAGS_DSP)
...
CFLAGS_ptrace.o		= $(CFLAGS_DSP)
endif

such that the day you can take advantage of a third DSP flavor it's only 
3 lines worth of Makefile to get it used, and you only have one place 
where you need to change CFLAGS.
--
Florian
